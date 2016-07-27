using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AppPoolRestart.Plugin.Models;
using Umbraco.Web.Mvc;
using Umbraco.Core.Logging;
using Umbraco.Web.Editors;
using System.Web.Mvc;


namespace AppPoolRestart.Plugin.Controllers
{
    [PluginController("User")]
    public class UserApiController : UmbracoAuthorizedJsonController
    {
        [System.Web.Http.HttpGet]
        public bool EditUser()
        {
            UserDBContext db = new UserDBContext();

            try
            {
                //string userName = Request.Form["txtuserName"];
                //string loginName = Request.Form["txtLoginName"];
                //string pwd = Request.Form["txtpwd"];
                //string email = Request.Form["txtEmail"];
                //string disControl = Request.Form["ckDisControl"];
                //string disUser = Request.Form["ckDisUser"];

                //User user = new Models.User();
                //user.userName = userName;
                //user.userLogin = loginName;
                //user.userPassword = pwd;
                //user.userEmail = email;
                //user.userType = 1;
                //user.userLanguage = "en";
                //user.userDisabled = disUser == "true" ? 1 : 0;
                //user.userDisabled = disControl == "true" ? 1 : 0;
                //user.startStructureID = 1;
                //user.startMediaID = 1;
                //user.securityStampToken = "";
                //user.failedLoginAttempts = 0;
                //user.lastLockoutDate = DateTime.Now;
                //user.lastPasswordChangeDate = DateTime.Now;
                //user.lastLoginDate = DateTime.Now;


                //db.Users.Add(user);
                //db.SaveChanges();

                return true;

            }
            catch (Exception ex)
            {
                return false;
            }

        }


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
        [System.Web.Http.HttpGet]
        public ActionResult GetUserList(string userName)
        { 
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
