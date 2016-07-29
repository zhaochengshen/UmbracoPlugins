<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Umbraco/Masterpages/umbracoPage.Master" CodeBehind="UserTypeManage.aspx.cs" Inherits="UserManage.App_Plugins.UserManage.UserTypeManage" %>


<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register Src="~/App_Plugins/UserManage/UserTypeControl.ascx" TagPrefix="uc1" TagName="UserTypeControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" Text="用户类型管理" runat="server">
        <asp:PlaceHolder ID="MemberExportPlaceHolder" runat="server">
            <div class="umb-pane ng-scope">
                <!--内容区域-->  
                <uc1:UserTypeControl runat="server" id="UserTypeControl" />
                <!--内容区域-->
            </div>
        </asp:PlaceHolder>
    </umbraco:UmbracoPanel>
</asp:Content>
