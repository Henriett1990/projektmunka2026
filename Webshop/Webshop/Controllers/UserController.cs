using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Webshop.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        [HttpPost]
        public ActionResult AddNewUser()
        {
            return StatusCode(201, new { message = "Sikeres rögzítés!" });
        
        }

    }
}
