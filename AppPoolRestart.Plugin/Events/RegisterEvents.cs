using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Configuration;
using System.Threading.Tasks;
using Umbraco.Core;
using umbraco.BusinessLogic; 
using System.IO;

namespace AppPoolRestart.Plugin.Events
{
    public class RegisterEvents : ApplicationEventHandler
    {
        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            //if (WebConfigurationManager.AppSettings["AppPoolRefresh:TouchedOn"] == null) { 

            //} 

            using (var helper = Application.SqlHelper)
            {
                string strSql = "INSERT INTO files(filename,fileType,parentid,filepath) VALUES('程序执行'1,1,'');";
                helper.ExecuteNonQuery(strSql);

                string filepath = "C:\\test.txt";
                File.WriteAllText(filepath, "我已经执行了" + DateTime.Now);

            }
        }
    }
}
