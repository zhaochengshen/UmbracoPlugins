using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.cms.presentation.Trees;
using umbraco.BusinessLogic.Actions;

namespace UserManage.Tree
{
    public class UserRoot : BaseTree
    {
        public UserRoot(string application) : base(application) { }

        protected override void CreateRootNode(ref XmlTreeNode rootNode)
        {
            rootNode.NodeID = System.Guid.NewGuid().ToString();
            rootNode.Action = "javascript:CreateUser()";
            rootNode.Menu.Clear();
            rootNode.Menu.Add(ActionRefresh.Instance);
            rootNode.Icon = "/App_Plugins/FileManage/Images/folder.ico";
            rootNode.OpenIcon = "/App_Plugins/FileManage/Images/folder.ico";

        }
        public override void Render(ref XmlTree tree)
        {
        }

        public override void RenderJS(ref System.Text.StringBuilder Javascript)
        {
            Javascript.Append(@"function CreateUser(){
                    UmbClientMgr.contentFrame('../App_Plugins/UserManage/User.aspx');
            }");
        }
    }
}