using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using System.IO;

namespace UserManage.Install
{
    public class Helper
    {
        private string CONFIG_APPLICATION = System.Web.HttpContext.Current.Server.MapPath("~/config/applications.config"),
            CONFIG_DASHBOARD = System.Web.HttpContext.Current.Server.MapPath("~/config/Dashboard.config"),
        CONFIG_TREE = System.Web.HttpContext.Current.Server.MapPath("~/config/trees.config");


        public void AddApplication()
        {
            XElement root = XElement.Load(CONFIG_APPLICATION);
            if (root.Elements("add").Where(p => p.Attribute("alias").Value == "UserManage").Count() == 0)
            {
                XElement xele = root.Elements("add").LastOrDefault();
                int index = root.Elements("add").Count() + 1;

                xele.AddAfterSelf(new XElement("add",
                    new XAttribute("alias", "UserManage"),
                    new XAttribute("name", "UserManage"),
                    new XAttribute("sortOrder", index),
                    new XAttribute("icon", "icon-wrench")
                    ));
                root.Save(CONFIG_APPLICATION);
            }
        }

        public void RemoveApplication()
        {
            XElement root = XElement.Load(CONFIG_APPLICATION);
            if (root.Elements("add").Where(p => p.Attribute("alias").Value == "UserManage").Count() > 0)
            { 
                root.Elements("add").Where(p => p.Attribute("alias").Value == "UserManage").Remove();
                root.Save(CONFIG_APPLICATION);
            }
        }

        public void AddTrees()
        {
            XElement root = XElement.Load(CONFIG_TREE);
            if (root.Elements("add").Where(t => t.Attribute("application").Value == "UserManage").Count() == 0)
            {
                XElement xele = root.Elements("add").LastOrDefault();
                xele.AddAfterSelf(
                    new XComment("UserManage"),
                    new XElement("add",
                         new XAttribute("application", "UserManage"),
                         new XAttribute("alias", "User"),
                         new XAttribute("title", "用户"),
                         new XAttribute("type", "UserManage.Tree.UserTree, UserManage"),
                         new XAttribute("sortOrder", "0")
                         ),
                    new XElement("add",
                         new XAttribute("application", "UserManage"),
                         new XAttribute("alias", "UserManageDoc"),
                         new XAttribute("title", "用户类型"),
                         new XAttribute("type", "UserManage.Tree.UserTypeTree, UserManage"),
                         new XAttribute("sortOrder", "1")

                    ));
                root.Save(CONFIG_TREE);
            }
        }
        public void RemoveTrees()
        {
            XElement root = XElement.Load(CONFIG_TREE);
            if (root.Elements("add").Where(p => p.Attribute("application").Value == "UserManage").Count() > 0)
            { 
                root.Elements("add").Where(p => p.Attribute("application").Value == "UserManage").Remove(); 
                root.Save(CONFIG_TREE);
            }
        }
    }
}