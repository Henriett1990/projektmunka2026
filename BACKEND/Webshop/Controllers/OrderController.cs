using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySqlConnector;
using System.Security.Claims;
using Webshop.Dtos;

namespace Webshop.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class OrderController : ControllerBase
    {
        private readonly Connect _connect = new Connect();
        private readonly EmailService _emailService;
        private readonly IConfiguration _config;

        public OrderController(EmailService emailService, IConfiguration config)
        {
            _emailService = emailService;
            _config = config;
        }

        [HttpPost]
        public async Task<ActionResult> Create(OrderDto dto)
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (userIdClaim == null || !int.TryParse(userIdClaim, out int userId))
                return Unauthorized(new { message = "Érvénytelen felhasználó." });

            if (dto.Items == null || dto.Items.Count == 0)
                return BadRequest(new { message = "A kosár üres." });

            using var connection = _connect.GetConnection();
            using var transaction = await connection.BeginTransactionAsync();

            try
            {
                int totalPrice = dto.Items.Sum(i => i.Price * i.Quantity);

                var orderCmd = new MySqlCommand(
                    "INSERT INTO Orders (user_id, total_price) VALUES (@userId, @total); SELECT LAST_INSERT_ID();",
                    connection, (MySqlTransaction)transaction);
                orderCmd.Parameters.AddWithValue("@userId", userId);
                orderCmd.Parameters.AddWithValue("@total", totalPrice);

                var orderId = Convert.ToInt32(await orderCmd.ExecuteScalarAsync());

                foreach (var item in dto.Items)
                {
                    var itemCmd = new MySqlCommand(
                        "INSERT INTO OrderItems (order_id, product_id, product_name, unit_price, quantity) " +
                        "VALUES (@orderId, @productId, @name, @price, @qty)",
                        connection, (MySqlTransaction)transaction);
                    itemCmd.Parameters.AddWithValue("@orderId", orderId);
                    itemCmd.Parameters.AddWithValue("@productId", item.Id);
                    itemCmd.Parameters.AddWithValue("@name", item.Name);
                    itemCmd.Parameters.AddWithValue("@price", item.Price);
                    itemCmd.Parameters.AddWithValue("@qty", item.Quantity);
                    await itemCmd.ExecuteNonQueryAsync();
                }

                await transaction.CommitAsync();

                // --- E-mail küldés ---
                var userEmailCmd = new MySqlCommand("SELECT email FROM Users WHERE id = @userId", connection);
                userEmailCmd.Parameters.AddWithValue("@userId", userId);
                var userEmail = (string?)await userEmailCmd.ExecuteScalarAsync();

                var itemsList = string.Join("\n", dto.Items.Select(i => $"- {i.Name} x{i.Quantity} = {i.Price * i.Quantity} Ft"));
                var body = $"Rendelésed részletei (#{orderId}):\n\n{itemsList}\n\nVégösszeg: {totalPrice} Ft\n\nKöszönjük a rendelést!";

                if (!string.IsNullOrEmpty(userEmail))
                {
                    await _emailService.SendEmailAsync(userEmail, "Rendelésed visszaigazolása", body);
                }

                var adminEmail = _config["EmailSettings:AdminEmail"];
                var masodikEmail = _config["EmailSettings:MasodikEmail"];
                var adminBody = $"Új rendelés érkezett (#{orderId})\nFelhasználó ID: {userId}\nVásárló email: {userEmail}\n\n{itemsList}\n\nVégösszeg: {totalPrice} Ft";

                await _emailService.SendEmailAsync(adminEmail, "Új rendelés érkezett", adminBody);

                if (!string.IsNullOrEmpty(masodikEmail))
                {
                    await _emailService.SendEmailAsync(masodikEmail, "Új rendelés érkezett", adminBody);
                }

                return StatusCode(201, new { message = "Rendelés sikeresen leadva!", orderId });
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                return StatusCode(500, new { message = "Hiba történt a rendelés mentésekor.", error = ex.Message });
            }
        }
    }
}