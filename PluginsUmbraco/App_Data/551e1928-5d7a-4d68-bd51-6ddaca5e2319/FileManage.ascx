<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileManage.ascx.cs" Inherits="TestMVCUmbraco.App_Plugins.FileManage.FileManage" %>

<style>
    .ltd {
        width: 120px;
    }
</style>

<div style="background-color: #eee; width: 30%; float: left; height: 500px;">
    <asp:TreeView ID="TreeView1" runat="server" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"></asp:TreeView>
</div>
<div style="background-color: #c8dbdb; height: 400px; margin-left: 20px; width: 60%; display: table;">
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%;">
        <tr>
            <th colspan="2">文件信息</th>
        </tr>
        <tr>
            <td class="ltd">名称:</td>
            <td>
                <asp:Label ID="lblInfo_fileID" runat="server" Visible="false"></asp:Label>
                <asp:Label ID="lblInfo_fileName" runat="server"></asp:Label></td>

        </tr>

        <tr>
            <td>类型:</td>
            <td>
                <asp:Label ID="lblInfo_fileType" runat="server"></asp:Label></td>

        </tr>

        <tr>
            <td>文件地址:</td>
            <td>
                <asp:Label ID="lblInfo_filePath" runat="server"></asp:Label>
            </td>


        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnDel" runat="server" Text="删除选定文件（夹）及其子文件（夹）" OnClientClick="return confirm('真的要删除吗')" OnClick="btnDel_Click" />
            </td>
        </tr>
    </table>
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; margin-top: 20px;">
        <tr>
            <th colspan="2">新建文件OR文件夹</th>
        </tr>
        <tr>
            <td class="ltd">名称:</td>
            <td>
                <asp:TextBox ID="txtFileName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>类型：</td>
            <td>
                <asp:DropDownList ID="ddlFileType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFileType_SelectedIndexChanged">
                    <asp:ListItem Value="0">文件夹</asp:ListItem>
                    <asp:ListItem Value="1">文件</asp:ListItem>
                </asp:DropDownList>

            </td>
        </tr>
        <tr>
            <td>父节点ID： </td>
            <td>
                <asp:Label ID="lblParentID" runat="server" Text=""></asp:Label>

            </td>
        </tr>
        <tr>
            <td>父节点：</td>
            <td>
                <asp:Label ID="lblParentText" runat="server" Text=""></asp:Label>

            </td>
        </tr>
        <tr>
            <td>选择上传的文件</td>
            <td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSubmit" runat="server" Text="提交" OnClientClick="" OnClick="btnSubmit_Click" /></td>

        </tr>

    </table>
</div>
