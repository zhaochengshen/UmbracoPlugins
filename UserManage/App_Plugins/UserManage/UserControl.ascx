<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControl.ascx.cs" Inherits="UserManage.App_Plugins.UserManage.UserControl" %>

<script src="Script/jquery-1.8.2.intellisense.js"></script>
<script src="Script/jquery-1.8.2.min.js"></script>
<script src="Script/jquery.form.js"></script>
<script src="Script/json2.js"></script>
<script src="Script/users.js"></script>
<link href="css/main.css" rel="stylesheet" />



<div>
    <div style="background-color: #808080">
        <input id="btnAddUser" type="button" value="添加用户" />
    </div>
    <table id="table1" class="gridtable">
    </table>

    <div id="div_AddUser">
        <form id="form1">
            <table class="editTable">
                <tr>
                    <td>用户姓名：</td>
                    <td>
                        <input id="add_txtUserName" name="add_txtUserName" type="text" /><span id="add_txtUserNameMsg" class="Error"></span>
                    </td>
                </tr>
                <tr>
                    <td>登录名：</td>
                    <td>
                        <input id="add_txtUserLogin" name="add_txtUserLogin" type="text" /><span id="add_txtUserLoginMsg" class="Error"></span>

                    </td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td>
                        <input id="add_txtUserPassword" name="add_txtUserPassword" type="password" /><span id="add_txtUserPasswordMsg" class="Error"></span>

                    </td>
                </tr>
                <tr>
                    <td>邮箱：</td>
                    <td>
                        <input id="add_txtUserEmail" name="add_txtUserEmail" type="text" /><span id="add_txtUserEmailMsg" class="Error"></span>

                    </td>
                </tr>
                <tr>
                    <td>用户类别：</td>
                    <td>
                        <select id="add_txtUserType" name="add_txtUserType">
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>禁用后台管理界面：</td>
                    <td>
                        <input id="add_cbDisabled" name="add_cbDisabled" type="checkbox" checked="checked" />

                    </td>
                </tr>
                <tr>
                    <td>禁用用户：</td>
                    <td>
                        <input id="add_cbNoConsole" name="add_cbNoConsole" type="checkbox" />

                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input id="Add_submit" type="button" value="保存" />
                        <input id="btnCloseAdd" type="button" value="关闭" onclick="" />
                    </td>
                </tr>
            </table>

        </form>
    </div>


    <div id="div_UpdateUser">
        <form enctype="multipart/form-data" id="form2">
            <table class="editTable">
                <tr>
                    <td>用户编号：</td>
                    <td>
                        <label id="lblUserID"></label>
                    </td>
                </tr>
                <tr>
                    <td>用户姓名：</td>
                    <td>
                        <input id="update_txtUserName" name="update_txtUserName" type="text" /><span id="update_txtUserNameMsg" class="Error"></span>
                    </td>
                </tr>
                <tr>
                    <td>登录名：</td>
                    <td>
                        <input id="update_txtUserLogin" name="update_txtUserLogin" type="text" /><span id="update_txtUserLoginMsg" class="Error"></span>

                    </td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td>
                        <input id="update_txtUserPassword" name="update_txtUserPassword" type="password" />

                    </td>
                </tr>
                <tr>
                    <td>邮箱：</td>
                    <td>
                        <input id="update_txtUserEmail" name="update_txtUserEmail" type="text" /><span id="update_txtUserEmailMsg" class="Error"></span>

                    </td>
                </tr>
                <tr>
                    <td>用户类别：</td>
                    <td>
                        <select id="update_txtUserType" name="update_txtUserType">
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>禁用后台管理界面：</td>
                    <td>
                        <input id="update_cbDisabled" name="update_cbDisabled" type="checkbox" checked="checked" />

                    </td>
                </tr>
                <tr>
                    <td>禁用用户：</td>
                    <td>
                        <input id="update_cbNoConsole" name="update_cbNoConsole" type="checkbox" />

                    </td>
                </tr>
                <tr>
                    <td>区域：</td>
                    <td id="update_Area"> 
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="update_submit" type="button" value="保存" />
                        <input id="btnCloseUpdate" type="button" value="关闭" />
                    </td>
                </tr>
            </table>

        </form>

    </div>
</div>


