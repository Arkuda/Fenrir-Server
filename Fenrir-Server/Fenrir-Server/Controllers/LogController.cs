using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fenrir_Server.Controllers
{
    public class LogController : Controller
    {
        
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [Authorize]
        public ActionResult adm()
        {
            return View();
        }
        
    }
}
