<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Umbraco/Masterpages/umbracoPage.Master" CodeBehind="FileManage.aspx.cs" Inherits="FileManage.App_Plugins.FileManage.FileManage" %>


<%@ Register Assembly="controls" Namespace="umbraco.uicontrols" TagPrefix="umbraco" %>
<%@ Register Src="~/App_Plugins/FileManage/FilesUserControl.ascx" TagPrefix="uc1" TagName="FilesUserControl" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="body" runat="server">
    <umbraco:UmbracoPanel ID="UmbracoPanel" Text="文件资源管理" runat="server">
        <asp:PlaceHolder ID="MemberExportPlaceHolder" runat="server">
            <div class="umb-pane ng-scope">  
                <uc1:FilesUserControl runat="server" ID="FilesUserControl" />
            </div>
        </asp:PlaceHolder>
    </umbraco:UmbracoPanel>
</asp:Content>
