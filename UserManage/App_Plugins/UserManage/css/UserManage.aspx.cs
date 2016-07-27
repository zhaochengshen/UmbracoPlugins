using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using umbraco.BusinessLogic;
using umbraco.cms.businesslogic.web;

namespace UserManage.App_Plugins.UserManage.css
{
    public partial class UserManage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindUserTypeList();
            }
        }
        /// <summary>
        /// 取校园管理员可看到的用户类型列表
        /// </summary>
        /// <returns></returns>
        internal static IEnumerable<UserType> GetSchollAdminLookUserTypeList()
        {
            string[] strCannotEdits = new[] { "admin", "writer", "translator", "schooladmin" };
            var whereList = from userType in UserType.GetAllUserTypes() 
                            select userType;

            return whereList;
        }
        private void bindUserTypeList()
        {
            var whereList = GetSchollAdminLookUserTypeList();
            this.gridUserTypeList.DataSource = whereList.ToList();
            this.gridUserTypeList.DataBind();


            //var whereList = GetSchollAdminLookUserTypeList();
            //this.pager.RecordTotal = whereList.Count();
            //List<UserTypeUIShowModel> userTypeList = new List<UserTypeUIShowModel>();
            //if (this.pager.RecordTotal > 0)
            //{
            //    userTypeList = whereList.OrderBy(x => x.Id)
            //        .Skip(this.pager.PageIndex * this.pager.PageSize)
            //        .Take(this.pager.PageSize)
            //        .ToList()
            //        .Select(x => new UserTypeUIShowModel()
            //        {
            //            Id = x.Id,
            //            Name = x.Name,
            //            Alias = x.Alias,
            //            NodeIdList = UserTypePermission.GetNodeIdList(x.Id)
            //        }).AsParallel().ToList();
            //}
            //userTypeList.Add(new UserTypeUIShowModel()
            //{
            //    Id = int.MinValue
            //});
            //this.gridUserTypeList.DataSource = userTypeList;
            //this.gridUserTypeList.DataBind();

            //this.pager.InitPageMessage();

        }
        protected void gridUserTypeList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //this.gridUserTypeList.EditIndex = -1;
            //int id = (int)this.gridUserTypeList.DataKeys[e.RowIndex].Value;

            //UserType userType = new UserType(id);
            //foreach (User user in userType.GetUserList())
            //{
            //    user.UserType = ConstHelper.UserDefaultUserType;
            //}
            //userType.Delete();

            //this.bindUserTypeList();
        }

        protected void gridUserTypeList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.gridUserTypeList.EditIndex = e.NewEditIndex;

            this.bindUserTypeList();
        }

        protected void gridUserTypeList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // int id = (int)this.gridUserTypeList.DataKeys[e.RowIndex].Value;

            //var currentRow = this.gridUserTypeList.Rows[e.RowIndex];
            //string strName = this.getControl(currentRow, "txtName").Text;
            //string strAlias = this.getControl(currentRow, "txtAlias").Text;
            //List<int> checkId = new List<int>();
            //List<int> unCheckId = new List<int>();
            //var cbList = this.gridUserTypeList.Rows[e.RowIndex].FindControl("cbEditNodeList") as CheckBoxList;
            //if (null != cbList)
            //{
            //    foreach (ListItem item in cbList.Items)
            //    {
            //        if (item.Selected)
            //        {
            //            checkId.Add(int.Parse(item.Value));
            //        }
            //        else
            //        {
            //            unCheckId.Add(int.Parse(item.Value));
            //        }
            //    }
            //}

            //if (string.IsNullOrEmpty(strName))
            //{
            //    this.RunAjaxJavascript(this.gridUserTypeList, "alert('名称不能为空！');");
            //    return;
            //}
            //if (string.IsNullOrEmpty(strAlias))
            //{
            //    this.RunAjaxJavascript(this.gridUserTypeList, "alert('别名不能为空！');");
            //    return;
            //}

            //try
            //{
            //    if (id == int.MinValue)
            //    {//表示新增记录
            //        var userType = UserType.MakeNew(strName, ConstHelper.USERTYPE_EDIT_DEFAULTPERMISSIONS, strAlias);
            //        UserTypePermission.SetUserTypePermissions(userType, checkId, unCheckId);
            //    }
            //    else
            //    {
            //        UserType userType = new UserType(id);
            //        userType.Name = strName;
            //        userType.Alias = strAlias;
            //        userType.Save();
            //        UserTypePermission.SetUserTypePermissions(userType, checkId, unCheckId);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Logger.WriteError("User Type", ex.Message, ex);
            //    this.RunAjaxJavascript(this.gridUserTypeList, "alert('保存失败！请确保标识名不能重复。');");
            //    return;
            //}

            this.gridUserTypeList.EditIndex = -1;
            this.bindUserTypeList();
        }

        protected void gridUserTypeList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.gridUserTypeList.EditIndex = -1;

            this.bindUserTypeList();
        }

        protected void gridUserTypeList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow && e.Row.DataItem is UserTypeUIShowModel)
            //{
            //    var rowModel = e.Row.DataItem as UserTypeUIShowModel;

            //    if (rowModel.Alias == "editor")
            //    {//默认编辑组无法编辑和删除
            //        foreach (TableCell cell in e.Row.Cells)
            //        {
            //            foreach (Control item in cell.Controls)
            //            {
            //                var link = item as LinkButton;
            //                if (link != null && (link.Text == "删除" || link.Text == "编辑"))
            //                {
            //                    link.Visible = false;
            //                }
            //            }
            //        }
            //    }
            //    else
            //    {//对删除按钮添加删除确认JS判断
            //        foreach (TableCell cell in e.Row.Cells)
            //        {
            //            foreach (Control item in cell.Controls)
            //            {
            //                var link = item as LinkButton;
            //                if (link != null && link.Text == "删除")
            //                {
            //                    link.Attributes.Add("onclick", "javascript:return confirm('您确认要删除此记录吗？');");
            //                }
            //            }
            //        }
            //    }

            //    if (rowModel.Id == int.MinValue)
            //    {//新增行对操作按钮做修改
            //        foreach (TableCell cell in e.Row.Cells)
            //        {
            //            foreach (Control item in cell.Controls)
            //            {
            //                var link = item as LinkButton;
            //                if (link != null && link.Text == "编辑")
            //                {
            //                    link.Text = "新建";
            //                }
            //                else if (link != null && link.Text == "删除")
            //                {
            //                    link.Visible = false;
            //                }
            //            }
            //        }
            //    }

            //    if (e.Row.RowIndex == this.gridUserTypeList.EditIndex)
            //    {//编辑行
            //        //一级栏目使用的列表数据源绑定
            //        var cbList = e.Row.FindControl("cbEditNodeList") as CheckBoxList;
            //        if (cbList != null)
            //        {
            //            var datasSource = UserTypePermission.CustomFirstDocumentList
            //                .Select(x => new ListItem()
            //                {
            //                    Text = x.Name.LimitByteCharLength(20),
            //                    Value = x.Id.ToString(),
            //                    Selected = rowModel.NodeIdList.Contains(x.Id)
            //                }).ToList();

            //            cbList.Items.Clear();
            //            cbList.DataSource = datasSource;
            //            cbList.DataBind();

            //            foreach (ListItem item in cbList.Items)
            //            {
            //                if (rowModel.NodeIdList.Contains(int.Parse(item.Value)))
            //                {
            //                    item.Selected = true;
            //                }
            //            }
            //        }

            //        var txtAlias = this.getControl(e.Row, "txtAlias");
            //        var lblAlias = this.getLabelControl(e.Row, "lblAlias");
            //        if (null != txtAlias)
            //        {
            //            txtAlias.Text = rowModel.Alias;
            //            lblAlias.Text = rowModel.Alias;

            //            //别名控件在新增时是可以操作写，在编辑时是不可操作写，这里用两个控件是因为一个控件禁止操作IE下全选会页面假死
            //            txtAlias.Visible = rowModel.Id == int.MinValue;
            //            lblAlias.Visible = rowModel.Id != int.MinValue;
            //        }

            //        var txtName = this.getControl(e.Row, "txtName");
            //        if (null != txtName)
            //        {
            //            txtName.Text = rowModel.Name;
            //        }
            //    }
            // }
        }
    }
}