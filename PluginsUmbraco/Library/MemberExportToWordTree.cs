using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.BusinessLogic.Actions;
using umbraco.cms.presentation.Trees;

namespace PluginsUmbraco.Library
{
    public class MemberExportToWordTree : BaseTree
    {
        public MemberExportToWordTree(string application) : base(application) { }

        protected override void CreateRootNode(ref XmlTreeNode rootNode)
        {
            rootNode.NodeID = System.Guid.NewGuid().ToString();
            rootNode.Action = "javascript:openExportToWordPage()";
            rootNode.Menu.Clear();
            rootNode.Menu.Add(ActionRefresh.Instance);
            rootNode.Icon = "/App_Plugins/PluginsUmbraco/Images/aspose.ico";
            rootNode.OpenIcon = "/App_Plugins/PluginsUmbraco/Images/aspose.ico";
        }

        public override void Render(ref XmlTree tree)
        {
        }

        public override void RenderJS(ref System.Text.StringBuilder Javascript)
        {
            Javascript.Append(
               @"function openExportToWordPage() {
                 UmbClientMgr.contentFrame('../App_Plugins/PluginsUmbraco/Index.html'); 
                }");
        }
    }
}