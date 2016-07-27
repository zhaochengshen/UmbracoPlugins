<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Umbraco/Masterpages/umbracoPage.Master" CodeBehind="FileManage.aspx.cs" Inherits="PluginsUmbraco.App_Plugins.FileManage.FileManage" %>

<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" Text="文件资源管理" runat="server">
        <asp:PlaceHolder ID="MemberExportPlaceHolder" runat="server">
            <div class="umb-pane ng-scope">
                这里填写内容也可以
            </div>
        </asp:PlaceHolder>
    </umbraco:UmbracoPanel>
</asp:Content>
