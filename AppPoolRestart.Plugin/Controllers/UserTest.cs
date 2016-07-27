using AppPoolRestart.Plugin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using Umbraco.Web.Mvc;
using System.Web.Mvc;

namespace AppPoolRestart.Plugin.Controllers
{
    public class UserTest :ApiController
    {

        [System.Web.Http.HttpGet]
        public ActionResult GetUserList()
        {
            string userName = string.Empty;
            JsonResult json = new JsonResult();
            UserDBContext db = new UserDBContext();
            List<User> list = new List<User>();
            if (!string.IsNullOrWhiteSpace(userName))
            {
                list = db.Users.Where(users => users.userName == userName).ToList();
            }
            else
            {
                list = db.Users.ToList();
            }
            json.Data = list;
            json.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            return json;
        }
    }
}
