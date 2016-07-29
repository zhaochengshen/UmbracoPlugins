<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="UserManage.App_Plugins.UserManage.test" %>

<%@ Register Src="~/App_Plugins/UserManage/UserTypeControl.ascx" TagPrefix="uc1" TagName="UserTypeControl" %>
<%@ Register Src="~/App_Plugins/UserManage/UserControl.ascx" TagPrefix="uc1" TagName="UserControl" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%-- <uc1:UserTypeControl runat="server" ID="UserTypeControl" />--%>
            <uc1:UserControl runat="server" ID="UserControl" />
            <%-- <uc1:UserTypeControl runat="server" ID="UserTypeControl" />--%>
        </div>
    </form>
</body>
</html>
