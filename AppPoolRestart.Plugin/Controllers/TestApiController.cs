using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Umbraco.Web.Mvc;
using Umbraco.Web.Editors;
using Umbraco.Core.Logging;
using System.Xml;
using System.Web;
using System.Web.Http;

namespace AppPoolRestart.Plugin.Controllers
{
    [PluginController("test")]
    public class TestApiController : UmbracoAuthorizedJsonController
    {

        [HttpGet]
        public bool testMethod()
        {
            bool success = false;
            try
            {
                var currentDateTime = DateTime.Now.ToString();
                var webConfigPath = System.Web.HttpContext.Current.Server.MapPath(@"~/web.config");

                XmlDocument webConfig = new XmlDocument();
                webConfig.Load(webConfigPath);

                // Updating an AppSetting is actually not necessary, simply loading then saving the config file will cause 
                // an App Pool restart. This is just to track that the plug is working and educational purposes.
                XmlNode appPoolRefreshNode = webConfig.SelectSingleNode(String.Format("/configuration/appSettings/add[@key='{0}']", "test"));
                if (appPoolRefreshNode == null)
                {
                    XmlAttribute keyAttr = webConfig.CreateAttribute("key");
                    keyAttr.Value = "test";

                    XmlAttribute valueAttr = webConfig.CreateAttribute("value");
                    valueAttr.Value = currentDateTime;

                    appPoolRefreshNode = webConfig.CreateNode("element", "add", "");
                    appPoolRefreshNode.Attributes.Append(keyAttr);
                    appPoolRefreshNode.Attributes.Append(valueAttr);

                    XmlNode appSettingsNode = webConfig.SelectSingleNode("/configuration/appSettings");
                    appSettingsNode.AppendChild(appPoolRefreshNode);
                }
                else
                {
                    appPoolRefreshNode.Attributes["value"].Value = currentDateTime;
                }

                webConfig.Save(webConfigPath);

                success = true;
            }
            catch (Exception ex)
            {
                // Opps
                LogHelper.Error(typeof(TestApiController), ex.Message, ex);
            }
            return success;
        }
    }
}
