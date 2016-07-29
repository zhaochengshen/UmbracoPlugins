<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserTypeControl.ascx.cs" Inherits="UserManage.App_Plugins.UserManage.UserTypeControl" %>




<div>
    <div style="background-color: #808080">
        <input id="btnAddUserType" type="button" value="添加用户类型" />
    </div>
    <table id="table1" class="gridtable">
    </table>

    <div id="div_AddUserType">
        <form enctype="multipart/form-data" id="form1">
            <table class="editTable">
                <tr>
                    <td>用户类型名称：</td>
                    <td>
                        <input id="txtUserTypeName" name="txtUserTypeName" type="text" /><span id="txtUserTypeMsg" class="Error"></span>

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="submit" type="button" value="保存" />
                        <input id="btnCloseAddUserType" type="button" value="关闭" onclick="" />
                    </td>
                </tr>
            </table>

        </form>
    </div>


    <div id="div_Permission">
        <form enctype="multipart/form-data" id="form2">
            <table class="editTable">
                <tr style="">
                    <td>用户类别ID：</td>
                    <td>
                        <span id="lblUserTypeID"></span>

                    </td>
                </tr>
                <tr>
                    <td>用户类型名称：</td>
                    <td>
                        <span id="lblUserTypeName"></span>

                    </td>
                </tr>
                <tr>
                    <td>用户类型别名：</td>
                    <td>
                        <span id="lblUserTypeAlias"></span>
                    </td>
                </tr>
                <tr>
                    <td>权限</td>
                    <td>
                        <label>
                            <input type="checkbox" name="cbpermission" value="I" />管理主机名</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="Z" />跟踪审计</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="F" />浏览节点</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="7" />改变文档类型</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="O" />复制</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="D" />删除</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="M" />移动</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="C" />创建</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="P" />公众访问权限</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="U" />发布</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="R" />权限</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="K" />回滚</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="5" />发给翻译</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="S" />排序</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="H" />提交至发布者</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="4" />翻译</label>
                        <label>
                            <input type="checkbox" name="cbpermission" value="A" />更新</label>

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="submitPermission" type="button" value="保存" />
                        <input id="btnClosePermission" type="button" value="关闭" />
                    </td>
                </tr>
            </table>

        </form>

    </div>

</div>


<script src="Script/jquery-1.8.2.intellisense.js"></script>
<script src="Script/jquery-1.8.2.min.js"></script>
<script src="Script/jquery.form.js"></script>
<script src="Script/json2.js"></script>
<script src="Script/userType.js"></script>
<link href="css/main.css" rel="stylesheet" />