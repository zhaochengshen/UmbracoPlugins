using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace PluginsUmbraco.Controllers
{
    public class IndexController : RenderMvcController
    {
         

        // GET: Index
        public ActionResult test()
        {
            ViewBag.List = "list";

            return View();
        }
    }
}