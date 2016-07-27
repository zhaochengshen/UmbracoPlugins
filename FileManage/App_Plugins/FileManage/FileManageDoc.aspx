<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Umbraco/Masterpages/umbracoPage.Master" CodeBehind="FileManageDoc.aspx.cs" Inherits="FileManage.App_Plugins.FileManage.FileManageDoc" %>

<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" Text="文件资源管理" runat="server">
        <asp:PlaceHolder ID="MemberExportPlaceHolder" runat="server">
            <div class="umb-pane ng-scope">
                资源管理说明文件 
            </div>
        </asp:PlaceHolder>
    </umbraco:UmbracoPanel>
</asp:Content>
