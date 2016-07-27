<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserInfoEdit.ascx.cs" Inherits="PluginsUmbraco.App_Plugins.UserInfo.Views.UserInfo.UserInfoEdit" %>

<div class="form-group" style="min-width: 300px; width: 50%;">
    <div class="form-group">
        <label for="name">用户姓名</label>
        <input type="text" class="form-control" id="txtuserName" runat="server"
            placeholder="请输入用户姓名">
    </div>
    <div class="form-group">
        <label for="name">用户名</label>
        <input type="text" class="form-control" id="txtLoginName" runat="server"
            placeholder="请输入用户名">
    </div>
    <div class="form-group">
        <label for="name">密码</label>
        <input type="password" class="form-control" id="txtpwd" runat="server"
            placeholder="请输入密码">
    </div>
    <div class="form-group">
        <label for="name">邮箱</label>
        <input type="text" class="form-control" id="txtEmail" runat="server"
            placeholder="请输入邮箱">
    </div>

  <%--  <div class="checkbox">
        <label>
            <input type="checkbox" id="ckDisControl" runat="server">
            禁用后台管理界面
        </label>
    </div>
    <div class="checkbox">
        <label>
            <input type="checkbox" id="ckDisUser" runat="server">
            禁用用户
        </label>
    </div>--%>
    <asp:Button ID="btnSubmit" runat="server" class="btn btn-default" Text="提交" OnClick="btnSubmit_Click" />

</div>
