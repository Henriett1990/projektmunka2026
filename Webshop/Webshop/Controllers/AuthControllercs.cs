using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MySqlConnector;
using System.Security.Claims;
using Webshop.Dtos;

namespace Webshop.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly Connect _connect = new Connect();

        [HttpPost("register")]
        public async Task<ActionResult> Register(RegisterDto dto)
        {
            using var connection = _connect.GetConnection();

            var checkCmd = new MySqlCommand("SELECT COUNT(*) FROM Users WHERE email = @email", connection);
            checkCmd.Parameters.AddWithValue("@email", dto.Email);
            var exists = Convert.ToInt32(await checkCmd.ExecuteScalarAsync()) > 0;

            if (exists)
                return Conflict(new { message = "Ez az email cím már regisztrálva van." });

            var hashedPassword = BCrypt.Net.BCrypt.HashPassword(dto.Password);

            var insertCmd = new MySqlCommand(
                "INSERT INTO Users (username, email, password) VALUES (@username, @email, @password)", connection);
            insertCmd.Parameters.AddWithValue("@username", dto.UserName);
            insertCmd.Parameters.AddWithValue("@email", dto.Email);
            insertCmd.Parameters.AddWithValue("@password", hashedPassword);

            await insertCmd.ExecuteNonQueryAsync();

            return StatusCode(201, new { message = "Sikeres regisztráció!" });
        }

        [HttpPost("login")]
        public async Task<ActionResult> Login(LoginDto dto)
        {
            using var connection = _connect.GetConnection();

            var cmd = new MySqlCommand("SELECT id, username, password, IsAdmin FROM Users WHERE email = @email", connection);
            cmd.Parameters.AddWithValue("@email", dto.Email);

            int userId;
            string userName, hashedPassword;
            bool isAdmin;

            using (var reader = await cmd.ExecuteReaderAsync())
            {
                if (!await reader.ReadAsync())
                    return Unauthorized(new { message = "Hibás email vagy jelszó." });

                userId = reader.GetInt32("id");
                userName = reader.GetString("username");
                hashedPassword = reader.GetString("password");
                isAdmin = reader.GetBoolean("IsAdmin");
            }

            if (!BCrypt.Net.BCrypt.Verify(dto.Password, hashedPassword))
                return Unauthorized(new { message = "Hibás email vagy jelszó." });

            var claims = new List<Claim>
    {
        new Claim(ClaimTypes.NameIdentifier, userId.ToString()),
        new Claim(ClaimTypes.Name, userName)
    };

            if (isAdmin)
                claims.Add(new Claim(ClaimTypes.Role, "Admin"));

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

            return Ok(new { message = "Sikeres bejelentkezés!" });
        }

        [HttpPost("logout")]
        public async Task<ActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return Ok(new { message = "Sikeres kijelentkezés." });
        }

        [Authorize]
        [HttpGet("me")]
        public ActionResult Me()
        {
            return Ok(new { userName = User.Identity?.Name });
        }
    }
}