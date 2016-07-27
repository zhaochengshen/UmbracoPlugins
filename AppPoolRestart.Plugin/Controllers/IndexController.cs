using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Umbraco.Web.Mvc;

namespace AppPoolRestart.Plugin.Controllers
{
    public class IndexController : RenderMvcController
    {
        public override System.Web.Mvc.ActionResult Index(Umbraco.Web.Models.RenderModel model)
        {
            return View("Index", model);
        }
    }
}
