using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Web.Hosting;
using System.Web;

namespace AppPoolRestart.Plugin.Install
{
    public class InstallHelper
    {
        private const string APPKEY_TOUCHEDON = "AppPoolRefresh:TouchedOn";
        public void AddAppSetting()
        {
            var webConfigPath = HttpContext.Current.Server.MapPath(@"~/web.config");

            XmlDocument webConfig = new XmlDocument();
            webConfig.Load(webConfigPath);

            XmlNode appPoolRefreshNode = webConfig.SelectSingleNode(String.Format("/configuration/appSettings/add[@key='{0}']", APPKEY_TOUCHEDON));
            if (appPoolRefreshNode == null)
            {
                XmlAttribute keyAttr = webConfig.CreateAttribute("key");
                keyAttr.Value = "AppPoolRefresh:TouchedOn";

                XmlAttribute valueAttr = webConfig.CreateAttribute("value");
                valueAttr.Value = String.Empty;

                appPoolRefreshNode = webConfig.CreateNode("element", "add", "");
                appPoolRefreshNode.Attributes.Append(keyAttr);
                appPoolRefreshNode.Attributes.Append(valueAttr);

                XmlNode appSettingsNode = webConfig.SelectSingleNode("/configuration/appSettings");
                appSettingsNode.AppendChild(appPoolRefreshNode);

                webConfig.Save(webConfigPath);
            }

        }
    }
}
