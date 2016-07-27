using PluginsUmbraco.App_Plugins.UserInfo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PluginsUmbraco.App_Plugins.UserInfo.Views.UserInfo
{
    public partial class UserInfoList : System.Web.UI.UserControl
    {
        UserDBContext db = new UserDBContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }
        public void GetUserList(string userName)
        {
            List<User> list = new List<User>();
            if (!string.IsNullOrWhiteSpace(userName))
            {
                list = db.Users.Where(users => users.userName == userName).ToList();
            }
            else
            {
                list = db.Users.ToList();
            }
            gvList.DataSource = list;
            gvList.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetUserList(txtUserName.Text.Trim());
        }

        protected void gvList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            Label lblID = gvList.Rows[e.RowIndex].FindControl("lblID") as Label;
            //执行删除
            int ID = !string.IsNullOrWhiteSpace(lblID.Text) ? Convert.ToInt32(lblID.Text.Trim()) : 0;
            User user = db.Users.Single(u => u.id == ID);
            db.Users.Remove(user);
            db.SaveChanges();

            btnSearch_Click(this, null);
        }

        protected void gvList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //编辑
            gvList.EditIndex = e.NewEditIndex;
            btnSearch_Click(this, null);
        }

        protected void gvList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvList.EditIndex = -1;
            btnSearch_Click(this, null);
        }

        protected void gvList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow gvr = gvList.Rows[e.RowIndex];
            string userName = (gvr.FindControl("txtUserName") as TextBox).Text.Trim();
            string userLogin = (gvr.FindControl("txtUserLogin") as TextBox).Text.Trim();
            string userEmail = (gvr.FindControl("txtUserEmail") as TextBox).Text.Trim();

            Label lblID = gvr.FindControl("lblID") as Label;
            int ID = !string.IsNullOrWhiteSpace(lblID.Text) ? Convert.ToInt32(lblID.Text) : 0;
            User user = db.Users.First(u => u.id == ID);
            user.userName = userName;
            user.userLogin = userLogin;
            user.userEmail = userEmail;

            db.SaveChanges();
            gvList.EditIndex = -1;
            btnSearch_Click(this, null); 
        } 
    }
}