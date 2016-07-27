<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManage.aspx.cs" Inherits="UserManage.App_Plugins.UserManage.css.UserManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <style type="text/css">
            .userManageTitle {
                text-align: center;
                font-size: 20px;
                font-weight: 700;
            }

            .userTypeSetNode {
                width: 100%;
            }
        </style>
        <div class="userManageTitle">
            用户类型管理
        </div>
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView runat="server" ID="gridUserTypeList" BorderWidth="0px" CellPadding="0"
                    CssClass="courselist" AutoGenerateColumns="False" BorderStyle="None" GridLines="None"
                    DataKeyNames="Id" OnRowDeleting="gridUserTypeList_RowDeleting" OnRowEditing="gridUserTypeList_RowEditing"
                    OnRowUpdating="gridUserTypeList_RowUpdating" OnRowCancelingEdit="gridUserTypeList_RowCancelingEdit"
                    OnRowDataBound="gridUserTypeList_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="序号">
                            <ItemTemplate>
                              <%--  <%# this.pager.PageIndex * this.pager.PageSize +  this.gridUserTypeList.Rows.Count + 1 %>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Id" Visible="False" HeaderText="标识" />
                        <asp:TemplateField HeaderText="名称">
                            <ItemTemplate>
                                <span title="<%# Eval("Name") %>">
                                   <%# Eval("Name") %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server" MaxLength="20"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="标识名">
                            <ItemTemplate>
                                <span title="<%# Eval("Alias") %>">
                                    <%# Eval("Alias") %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtAlias" runat="server" MaxLength="20"></asp:TextBox>
                                <asp:Label ID="lblAlias" runat="server"></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="浏览栏目">
                            <ItemTemplate>
                                <span title="<%# Eval("NodeNames") %>">
                                    <%# Eval("NodeNames") %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBoxList ID="cbEditNodeList" runat="server" CssClass="userTypeSetNode" DataValueField="Value"
                                    DataTextField="Text">
                                </asp:CheckBoxList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="true" EditText="编辑" UpdateText="保存"
                            CancelText="取消" DeleteText="删除" HeaderText="操作" />
                    </Columns>
                    <EmptyDataTemplate>
                        <table cellspacing="0" cellpadding="0" align="center" class="courselist">
                            <tr>
                                <th>序号
                                </th>
                                <th>名称
                                </th>
                                <th>标识名
                                </th>
                                <th>浏览栏目
                                </th>
                                <th>操作
                                </th>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:GridView> 
            </ContentTemplate>
        </asp:UpdatePanel>


    </form>
</body>
</html>
