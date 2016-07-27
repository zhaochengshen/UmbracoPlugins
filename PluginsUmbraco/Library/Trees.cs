using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.cms.presentation.Trees;
using umbraco.BusinessLogic.Actions;

namespace PluginsUmbraco.Library
{
    public class Trees : BaseTree
    {
        public Trees(string application) : base(application) { }

        protected override void CreateRootNode(ref XmlTreeNode rootNode)
        {
            rootNode.NodeID = System.Guid.NewGuid().ToString();
            rootNode.Action = "javascript:CreateContent()";
            rootNode.Menu.Clear();
            rootNode.Menu.Add(ActionRefresh.Instance);
            //rootNode.Icon = "/App_Plugins/FileManage/Images/aspose.ico";
            //rootNode.OpenIcon = "/App_Plugins/PluginsUmbraco/Images/aspose.ico";

        }
        public override void Render(ref XmlTree tree)
        {
        }

        public override void RenderJS(ref System.Text.StringBuilder Javascript)
        {
            Javascript.Append(@"function CreateContent(){
                    UmbClientMgr.contentFrame('../App_Plugins/FileManage/FileManage.ascx');
            }");
        }
    }
}