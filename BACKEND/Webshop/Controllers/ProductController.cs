using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySqlConnector;
using Webshop.Dtos;
using Webshop.Models;

namespace Webshop.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly Connect _connect = new Connect();

        [HttpGet]
        public async Task<ActionResult<List<Products>>> GetAll()
        {
            using var connection = _connect.GetConnection();
            var cmd = new MySqlCommand("SELECT * FROM Products", connection);

            var products = new List<Products>();

            using var reader = await cmd.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                products.Add(new Products
                {
                    Id = reader.GetInt32("id"),
                    Category = reader.GetString("category"),
                    Name = reader.GetString("name"),
                    Unit = reader.GetString("unit"),
                    Price = reader.GetInt32("price"),
                    Description = reader.GetString("description"),
                    Image = reader.IsDBNull(reader.GetOrdinal("image")) ? null : reader.GetString("image"),
                    Stock = reader.GetInt32("stock"),
                    CreatedAt = reader.GetDateTime("created_at")
                });
            }

            return Ok(products);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Products>> GetById(int id)
        {
            using var connection = _connect.GetConnection();
            var cmd = new MySqlCommand("SELECT * FROM Products WHERE id = @id", connection);
            cmd.Parameters.AddWithValue("@id", id);

            using var reader = await cmd.ExecuteReaderAsync();
            if (!await reader.ReadAsync())
                return NotFound(new { message = "A termék nem található." });

            var product = new Products
            {
                Id = reader.GetInt32("id"),
                Category = reader.GetString("category"),
                Name = reader.GetString("name"),
                Unit = reader.GetString("unit"),
                Price = reader.GetInt32("price"),
                Description = reader.GetString("description"),
                Image = reader.IsDBNull(reader.GetOrdinal("image")) ? null : reader.GetString("image"),
                Stock = reader.GetInt32("stock"),
                CreatedAt = reader.GetDateTime("created_at")
            };

            return Ok(product);
        }

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<ActionResult> Create(ProductDto dto)
        {
            if (dto.Price < 0)
                return BadRequest(new { message = "Az ár nem lehet negatív." });

            using var connection = _connect.GetConnection();

            var cmd = new MySqlCommand(
                "INSERT INTO Products (category, name, unit, price, description, image, stock) " +
                "VALUES (@category, @name, @unit, @price, @description, @image, @stock)", connection);

            cmd.Parameters.AddWithValue("@category", dto.Category);
            cmd.Parameters.AddWithValue("@name", dto.Name);
            cmd.Parameters.AddWithValue("@unit", dto.Unit);
            cmd.Parameters.AddWithValue("@price", dto.Price);
            cmd.Parameters.AddWithValue("@description", dto.Description);
            cmd.Parameters.AddWithValue("@image", (object?)dto.Image ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@stock", dto.Stock);

            await cmd.ExecuteNonQueryAsync();

            return StatusCode(201, new { message = "Termék sikeresen létrehozva!" });
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public async Task<ActionResult> Update(int id, ProductDto dto)
        {
            if (dto.Price < 0)
                return BadRequest(new { message = "Az ár nem lehet negatív." });

            using var connection = _connect.GetConnection();

            var cmd = new MySqlCommand(
                "UPDATE Products SET category=@category, name=@name, unit=@unit, price=@price, " +
                "description=@description, image=@image, stock=@stock WHERE id=@id", connection);

            cmd.Parameters.AddWithValue("@category", dto.Category);
            cmd.Parameters.AddWithValue("@name", dto.Name);
            cmd.Parameters.AddWithValue("@unit", dto.Unit);
            cmd.Parameters.AddWithValue("@price", dto.Price);
            cmd.Parameters.AddWithValue("@description", dto.Description);
            cmd.Parameters.AddWithValue("@image", (object?)dto.Image ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@stock", dto.Stock);
            cmd.Parameters.AddWithValue("@id", id);

            var rows = await cmd.ExecuteNonQueryAsync();

            if (rows == 0)
                return NotFound(new { message = "A termék nem található." });

            return Ok(new { message = "Termék sikeresen módosítva!" });
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            using var connection = _connect.GetConnection();

            var cmd = new MySqlCommand("DELETE FROM Products WHERE id=@id", connection);
            cmd.Parameters.AddWithValue("@id", id);

            var rows = await cmd.ExecuteNonQueryAsync();

            if (rows == 0)
                return NotFound(new { message = "A termék nem található." });

            return Ok(new { message = "Termék sikeresen törölve!" });
        }
    }
}