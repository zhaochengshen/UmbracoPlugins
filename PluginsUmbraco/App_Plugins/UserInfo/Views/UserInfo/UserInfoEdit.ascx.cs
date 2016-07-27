using PluginsUmbraco.App_Plugins.UserInfo.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PluginsUmbraco.App_Plugins.UserInfo.Views.UserInfo
{
    public partial class UserInfoEdit : System.Web.UI.UserControl
    {
        UserDBContext db = new UserDBContext();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string userName = txtuserName.Value.Trim();
                string loginName = txtLoginName.Value.Trim();
                string pwd = txtpwd.Value.Trim();
                string email = txtEmail.Value.Trim();
                bool disControl = true;
                bool disUser = true;
                //bool disControl = ckDisControl.Checked;
                //bool disUser = ckDisUser.Checked;

                User user = new Models.User();
                user.userName = userName;
                user.userLogin = loginName;
                user.userPassword = pwd;
                user.userEmail = email;
                user.userType = 1;
                user.userLanguage = "en";
                user.userDisabled = disUser == true ? 1 : 0;
                user.userDisabled = disControl == true ? 1 : 0;
                user.startStructureID = 1;
                user.startMediaID = 1;
                user.securityStampToken = "";
                user.failedLoginAttempts = 0;
                user.lastLockoutDate = DateTime.Now;
                user.lastPasswordChangeDate = DateTime.Now;
                user.lastLoginDate = DateTime.Now;


                db.Users.Add(user);
                db.SaveChanges();

                txtuserName.Value = string.Empty;
                txtLoginName.Value = string.Empty;
                txtpwd.Value = string.Empty;
                txtEmail.Value = string.Empty;

                Response.Write("<script>alert('用户添加成功！');</script>");

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message.ToString() + "');</script>");
            }




        }



    }
}