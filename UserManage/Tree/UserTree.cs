using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.BusinessLogic.Actions;
using umbraco.cms.presentation.Trees;

namespace UserManage.Tree
{
    public class UserTree : BaseTree
    {

        public UserTree(string application) : base(application) { }

        protected override void CreateRootNode(ref XmlTreeNode rootNode)
        {
            rootNode.NodeID = System.Guid.NewGuid().ToString();
            rootNode.Action = "javascript:CreateUserTree()";
            rootNode.Menu.Clear();
            rootNode.Menu.Add(ActionRefresh.Instance);
            rootNode.Icon = "/App_Plugins/FileManage/Images/folder.ico";
            rootNode.OpenIcon = "/App_Plugins/FileManage/Images/folder.ico";
        }



        public override void RenderJS(ref System.Text.StringBuilder Javascript)
        {
            Javascript.Append(@"function CreateUser(){
UmbClientMgr.contentFrame('../APP_Plugins/UserMangae/User.aspx');
}");
        }

    }
}