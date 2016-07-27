<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="FileManage.App_Plugins.FileManage.test" %>

<%@ Register Src="~/App_Plugins/FileManage/FilesUserControl.ascx" TagPrefix="uc1" TagName="FilesUserControl" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body> 
    <div>
        <uc1:FilesUserControl runat="server" ID="FilesUserControl" />

    </div> 
</body>
</html>
