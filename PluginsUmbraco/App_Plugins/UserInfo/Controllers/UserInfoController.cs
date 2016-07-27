using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PluginsUmbraco.App_Plugins.UserInfo.Models;

namespace PluginsUmbraco.App_Plugins.UserInfo.Controllers
{
    public class UserInfoController : Controller
    {

        public List<User> listUser = new List<User>{
            new User{id =1,userName ="张三"},
            new User{id =2,userName="李四"},
            new User{id =3,userName="王五"},
            new User{id =4,userName="黑豆"},
            new User{id =5,userName="赵六"}
        };
        // GET: UserInfo
        public ActionResult Index()
        {
            ViewData["list"] = listUser;

            return View();
        }
    }
}