using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using umbraco.BusinessLogic;

using umbraco.cms.businesslogic.packager;
using System.Text;

namespace UserManage.Events
{
    public class RegisterEvents : ApplicationEventHandler
    {

        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        
        {
            InstalledPackage.BeforeDelete += InstalledPackage_BeforeDelete;
            InstalledPackage.AfterSave += InstalledPackage_AfterSave; 
        }



        private void InstalledPackage_BeforeDelete(InstalledPackage sender, System.EventArgs e)
        {
            if (sender.Data.Name == "UserManage")
            {  
                Install.Helper install = new Install.Helper();
                install.RemoveTrees();
                install.RemoveApplication(); 
            }
        }
        private void InstalledPackage_AfterSave(InstalledPackage sender, System.EventArgs e)
        {

            if (sender.Data.Name == "UserManage")
            {  
                Install.Helper install = new Install.Helper();
                install.AddApplication();
                install.AddTrees();

            }
        }
    }
}