using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.cms.presentation.Trees;
using umbraco.BusinessLogic.Actions;

namespace UserManage.Tree
{
    public class UserTypeTree : BaseTree
    {
        public UserTypeTree(string application) : base(application) { }

        protected override void CreateRootNode(ref XmlTreeNode rootNode)
        {
            rootNode.NodeID = System.Guid.NewGuid().ToString();
            rootNode.Action = "javascript:CreaUserType()";
            rootNode.Menu.Clear();
            rootNode.Menu.Add(ActionRefresh.Instance);
            rootNode.Icon = "/App_Plugins/UserManage/Images/folder.ico";
            rootNode.OpenIcon = "/App_Plugins/UserManage/Images/folder.ico";
        }

        public override void Render(ref XmlTree Tree)
        {
        } 


        public override void RenderJS(ref System.Text.StringBuilder Javascript)
        {
            Javascript.Append(@"function CreaUserType(){
                    UmbClientMgr.contentFrame('../App_Plugins/UserManage/UserTypeManage.aspx');
            }");
        }
    }
}