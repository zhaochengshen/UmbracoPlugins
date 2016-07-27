using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using System.IO;

namespace FileManage.Install
{
    public class Helper
    {
        private string CONFIG_APPLICATION = System.Web.HttpContext.Current.Server.MapPath("~/config/applications.config"),
            CONFIG_DASHBOARD = System.Web.HttpContext.Current.Server.MapPath("~/config/Dashboard.config"),
        CONFIG_TREE = System.Web.HttpContext.Current.Server.MapPath("~/config/trees.config");


        public void AddApplication()
        {
            XElement root = XElement.Load(CONFIG_APPLICATION);
            if (root.Elements("add").Where(p => p.Attribute("alias").Value == "FileManage").Count() == 0)
            {
                XElement xele = root.Elements("add").LastOrDefault();
                int index = root.Elements("add").Count() + 1;

                xele.AddAfterSelf(new XElement("add",
                    new XAttribute("alias", "FileManage"),
                    new XAttribute("name", "FileManage"),
                    new XAttribute("sortOrder", index),
                    new XAttribute("icon", "icon-wrench")
                    ));
                root.Save(CONFIG_APPLICATION);
            }
        }

        public void RemoveApplication()
        {
            XElement root = XElement.Load(CONFIG_APPLICATION);
            if (root.Elements("add").Where(p => p.Attribute("alias").Value == "FileManage").Count() > 0)
            {
                root.Elements("add").Where(p => p.Attribute("alias").Value == "FileManage").Remove();
                root.Save(CONFIG_APPLICATION);
            }
        }

        public void AddTrees()
        {
            XElement root = XElement.Load(CONFIG_TREE);
            if (root.Elements("add").Where(t => t.Attribute("application").Value == "FileManage").Count() == 0)
            {
                XElement xele = root.Elements("add").LastOrDefault();
                xele.AddAfterSelf(
                    new XComment("FileManage"),
                    new XElement("add",
                         new XAttribute("application", "FileManage"),
                         new XAttribute("alias", "FileManage"),
                         new XAttribute("title", "资源管理"),
                         new XAttribute("type", "FileManage.Tree.FileManageRoot, FileManage"),
                         new XAttribute("sortOrder", "0")
                         ),
                    new XElement("add",
                         new XAttribute("application", "FileManage"),
                         new XAttribute("alias", "FileManageDoc"),
                         new XAttribute("title", "资源管理说明"),
                         new XAttribute("type", "FileManage.Tree.FileManageDoc, FileManage"),
                         new XAttribute("sortOrder", "1")

                    ));
                root.Save(CONFIG_TREE);
            }
        }
        public void RemoveTrees()
        {
            XElement root = XElement.Load(CONFIG_TREE);
            if (root.Elements("add").Where(p => p.Attribute("application").Value == "FileManage").Count() > 0)
            {
                root.Elements("add").Where(p => p.Attribute("application").Value == "FileManage").Remove();
                root.Save(CONFIG_TREE);
            }
        }

        public void AddSectionDashboard()
        {
            XElement root = XElement.Load(CONFIG_DASHBOARD);
            if (root.Elements("section").Where(p => p.Attribute("alias").Value == "FileManage").Count() == 0)
            {
                XElement xele = root.Elements("section").LastOrDefault();

                xele.AddAfterSelf(new XElement("section",
                    new XAttribute("alias", "FileManage"),
                    new XElement("areas",
                        new XElement("area", "FileManage")
                        ),
                    new XElement("tab",
                        new XAttribute("caption", "FileManage"),
                        new XElement("control", "/App_Plugins/FileManage/FileManage.ascx"))
                    ));
                root.Save(CONFIG_DASHBOARD);
            }
        }
        public void RemoveSectionDashboard()
        {
            XElement root = XElement.Load(CONFIG_DASHBOARD);
            if (root.Elements("section").Where(p => p.Attribute("alias").Value == "FileManage").Count() > 0)
            {
                root.Elements("section").Where(p => p.Attribute("alias").Value == "FileManage").Remove();
                root.Save(CONFIG_DASHBOARD);
            }
        }
    }
}