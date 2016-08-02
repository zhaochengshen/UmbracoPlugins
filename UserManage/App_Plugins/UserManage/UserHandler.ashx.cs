using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.DataLayer;
using Newtonsoft.Json;
using Umbraco.Core;
using Umbraco.Core.Security;
using System.Web.Security;
using System.Text;
using System.Security.Cryptography;
using System.Xml.Linq;


namespace UserManage.App_Plugins.UserManage
{
    /// <summary>
    /// UserHandler 的摘要说明
    /// </summary>
    public class UserHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";



            string type = context.Request.QueryString["type"];
            if (string.IsNullOrWhiteSpace(type)) { context.Response.Write("-1"); }

            //获取用户信息列表
            if (type == "1")
            {
                context.Response.Write(JsonConvert.SerializeObject(GetUsers()));
            }
            //添加用户
            else if (type == "2")
            {
                if (string.IsNullOrWhiteSpace(context.Request.Form["add_txtUserLogin"])) { context.Response.Write("登录名不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["add_txtUserName"])) { context.Response.Write("用户姓名不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["add_txtUserPassword"])) { context.Response.Write("密码不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["add_txtUserEmail"])) { context.Response.Write("邮箱不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["add_txtUserType"])) { context.Response.Write("用户类别不能为空！"); }

                User user = new User();
                user.UserName = context.Request.Form["add_txtUserName"];
                user.UserLogin = context.Request.Form["add_txtUserLogin"];
                user.UserPassword = Encryption(context.Request.Form["add_txtUserPassword"]);
                user.UserEmail = context.Request.Form["add_txtUserEmail"];
                user.UserType = Convert.ToInt32(context.Request.Form["add_txtUserType"]);
                user.UserDisabled = string.IsNullOrWhiteSpace(context.Request.Form["add_cbDisabled"]) ? false : context.Request.Form["add_cbDisabled"] == "on" ? true : false;
                user.UserNoConsole = string.IsNullOrWhiteSpace(context.Request.Form["add_cbNoConsole"]) ? false : context.Request.Form["add_cbNoConsole"] == "on" ? true : false;
                //string userArea = context.Request.Form["add_cbarea"]; 
                if (AddUser(user, null) == false)
                {
                    context.Response.Write("-1");
                }
            }
            //删除用户
            else if (type == "3")
            {
                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserID"])) { context.Response.Write("-1"); }
                string userID = context.Request.QueryString["UserID"];
                context.Response.Write(DelUser(userID));
            }
            //根据用户编号获取用户信息
            else if (type == "4")
            {

                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserID"])) { context.Response.Write("-1"); }
                int userID = Convert.ToInt32(context.Request.QueryString["UserID"]);
                context.Response.Write(JsonConvert.SerializeObject(GetUsers().Where(u => u.ID == userID)));
            }
            //修改用户
            else if (type == "5")
            {
                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserID"])) { context.Response.Write("-1"); }
                string userID = context.Request.QueryString["UserID"];
                if (string.IsNullOrWhiteSpace(context.Request.Form["update_txtUserLogin"])) { context.Response.Write("登录名不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["update_txtUserName"])) { context.Response.Write("用户姓名不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["update_txtUserEmail"])) { context.Response.Write("邮箱不能为空！"); }
                if (string.IsNullOrWhiteSpace(context.Request.Form["update_txtUserType"])) { context.Response.Write("用户类别不能为空！"); }


                User user = new User();
                user.ID = Convert.ToInt32(userID);
                user.UserName = context.Request.Form["update_txtUserName"];
                user.UserLogin = context.Request.Form["update_txtUserLogin"];
                user.UserPassword = string.IsNullOrWhiteSpace(context.Request.Form["update_txtUserPassword"]) ? "" : Encryption(context.Request.Form["update_txtUserPassword"]);
                user.UserEmail = context.Request.Form["update_txtUserEmail"];
                user.UserType = Convert.ToInt32(context.Request.Form["update_txtUserType"]);
                user.UserDisabled = string.IsNullOrWhiteSpace(context.Request.Form["update_cbDisabled"]) ? false : context.Request.Form["update_cbDisabled"] == "on" ? true : false;
                user.UserNoConsole = string.IsNullOrWhiteSpace(context.Request.Form["update_cbNoConsole"]) ? false : context.Request.Form["update_cbNoConsole"] == "on" ? true : false;
                string strArea = string.IsNullOrWhiteSpace(context.Request.Form["update_cbarea"]) ? string.Empty : context.Request.Form["update_cbarea"];
                string[] permissionArray = strArea.Split(',');
                UpdateUser(user, permissionArray);

            }
            //获取内容模块
            else if (type == "6")
            {
                context.Response.Write(JsonConvert.SerializeObject(GetApplication()));
            }
            context.Response.End();
        }


        public List<ApplicationConfig> GetApplication()
        {
            List<ApplicationConfig> list = new List<ApplicationConfig>();
            string path = HttpContext.Current.Server.MapPath("\\Config\\applications.config");
            XElement root = XElement.Load(path);


            foreach (var item in root.Elements("add"))
            {
                ApplicationConfig app = new ApplicationConfig();
                app.Alias = item.Attribute("alias").Value;
                app.Name = item.Attribute("name").Value;
                list.Add(app);
            }
            return list;
        }


        /// <summary>
        /// 对密码进行加密
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        public string Encryption(string password)
        {
            var hash = new HMACSHA1();
            hash.Key = Encoding.Unicode.GetBytes(password);
            return Convert.ToBase64String(hash.ComputeHash(Encoding.Unicode.GetBytes(password)));
        }


        public bool UpdateUser(User user, string[] permissionArray)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                try
                {
                    //不修改密码
                    if (string.IsNullOrWhiteSpace(user.UserPassword))
                    {
                        string sql_UpdateUser = @"UPDATE umbracouser SET userDisabled=@userDisabled,userNoConsole=@userNoConsole,userType=@userType,userName=@userName,userLogin=@userLogin,userEmail=@userEmail WHERE id=@ID";
                        var param1 = helper.CreateParameter("@userDisabled", user.UserDisabled);
                        var param2 = helper.CreateParameter("@userNoConsole", user.UserNoConsole);
                        var param3 = helper.CreateParameter("@userType", user.UserType);
                        var param4 = helper.CreateParameter("@userName", user.UserName);
                        var param5 = helper.CreateParameter("@userLogin", user.UserLogin);
                        var param6 = helper.CreateParameter("@userEmail", user.UserEmail);
                        var param7 = helper.CreateParameter("@ID", user.ID);

                        if ((helper.ExecuteNonQuery(sql_UpdateUser, param1, param2, param3, param4, param5, param6, param7) > 0))
                        {
                            if (SetPermission(user.ID, permissionArray)) { return true; }
                            else { return false; }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    //修改密码
                    else
                    {
                        string sql_UpdateUser = @"UPDATE umbracouser SET userDisabled=@userDisabled,userNoConsole=@userNoConsole,userType=@userType,userName=@userName,userLogin=@userLogin,userPassword=@userPassword,userEmail=@userEmail,lastPasswordChangeDate =NOW() WHERE id=@ID";
                        var param1 = helper.CreateParameter("@userDisabled", user.UserDisabled);
                        var param2 = helper.CreateParameter("@userNoConsole", user.UserNoConsole);
                        var param3 = helper.CreateParameter("@userType", user.UserType);
                        var param4 = helper.CreateParameter("@userName", user.UserName);
                        var param5 = helper.CreateParameter("@userLogin", user.UserLogin);
                        var param6 = helper.CreateParameter("@userPassword", user.UserPassword);
                        var param7 = helper.CreateParameter("@userEmail", user.UserEmail);
                        var param8 = helper.CreateParameter("@ID", user.ID);

                        if ((helper.ExecuteNonQuery(sql_UpdateUser, param1, param2, param3, param4, param5, param6, param7, param8) > 0))
                        {
                            if (SetPermission(user.ID, permissionArray)) { return true; }
                            else { return false; }
                        }
                        else
                        {
                            return false;
                        }

                    }



                }
                catch { return false; }
            }
        }
        /// <summary>
        /// 设置用户可访问模块
        /// </summary>
        /// <param name="userID">用户编号</param>
        /// <param name="permissionArray">可访问模块</param>
        /// <returns></returns>
        public bool SetPermission(int userID, string[] permissionArray)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                if (permissionArray.Length > 0)
                {
                    string sql_UpdateApp = "DELETE FROM umbracouser2app WHERE USER=@UserID; INSERT INTO umbracouser2app(USER,app) values ";
                    foreach (var item in permissionArray)
                    {
                        sql_UpdateApp += "(@UserID,'" + item + "'),";
                    }
                    sql_UpdateApp = sql_UpdateApp.Substring(0, sql_UpdateApp.Length - 1) + ";";

                    var paramUserID = helper.CreateParameter("@UserID", userID);
                    if ((helper.ExecuteNonQuery(sql_UpdateApp, paramUserID) > 0))
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return true;
                }
            }
        }

        //添加用户信息
        public bool AddUser(User user, string[] permissionArry)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                try
                {
                    string sql_inserUser = @"INSERT INTO umbracouser(userDisabled,userNoConsole,userType,startStructureID,startMediaID,userName,userLogin,userPassword,userEmail,userLanguage) 
VALUES(@userDisabled,@userNoConsole,@userType,-1,-1,@userName,@userLogin,@userPassword,@userEmail,'zh-CN')";
                    var param1 = helper.CreateParameter("@userDisabled", user.UserDisabled);
                    var param2 = helper.CreateParameter("@userNoConsole", user.UserNoConsole);
                    var param3 = helper.CreateParameter("@userType", user.UserType);
                    var param4 = helper.CreateParameter("@userName", user.UserName);
                    var param5 = helper.CreateParameter("@userLogin", user.UserLogin);
                    var param6 = helper.CreateParameter("@userPassword", user.UserPassword);
                    var param7 = helper.CreateParameter("@userEmail", user.UserEmail);
                    if (helper.ExecuteNonQuery(sql_inserUser, param1, param2, param3, param4, param5, param6, param7) > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                catch { return false; }
            }
        }


        /// <summary>
        /// 根据用户ID删除用户信息
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public bool DelUser(string userID)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                try
                {
                    string sql_Del = "DELETE FROM umbracouser2nodepermission WHERE userid=@userID;DELETE FROM umbracouser2app WHERE USER=@userID;DELETE FROM umbracouser WHERE id =@userID;";
                    var paramUserID = helper.CreateParameter("@userID", userID);
                    if (helper.ExecuteNonQuery(sql_Del, paramUserID) > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                catch { return false; }

            }
        }
        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <returns></returns>
        public List<User> GetUsers()
        {
            List<User> list = new List<User>();
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string sql_query = "SELECT id,userDisabled,userNoConsole,userType,StartStructureID,StartMediaID,UserName,userLogin,userPassword,userEmail,userLanguage,lastPasswordChangeDate,lastLoginDate FROM umbracouser";
                using (IRecordsReader dr = helper.ExecuteReader(sql_query))
                {
                    while (dr.Read())
                    {
                        User user = new User();
                        user.ID = dr.GetInt("id");
                        user.UserDisabled = Convert.ToBoolean(dr.GetInt("userDisabled"));
                        user.UserNoConsole = Convert.ToBoolean(dr.GetInt("userNoConsole"));
                        user.UserType = dr.GetInt("userType");
                        user.UserName = dr.GetString("userName");
                        user.UserLogin = dr.GetString("userLogin");
                        user.UserPassword = dr.GetString("userPassword");
                        user.UserEmail = dr.GetString("userEmail");
                        user.UserLanguage = dr.GetString("userLanguage");
                        user.LastPasswordChangeDate = string.IsNullOrWhiteSpace(dr.GetString("LastPasswordChangeDate")) ? DateTime.MinValue : dr.GetDateTime("LastPasswordChangeDate");

                        string sqlApp = "SELECT USER,App FROM umbracouser2app WHERE USER = '" + user.ID + "'";
                        List<User2App> listApp = new List<User2App>();
                        using (IRecordsReader drApp = helper.ExecuteReader(sqlApp))
                        {
                            while (drApp.Read())
                            {
                                User2App app = new User2App();
                                app.App = drApp.GetString("app");
                                listApp.Add(app);
                            }
                        }
                        user.Permission = listApp;

                        list.Add(user);
                    }
                }
            }
            return list;
        }


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}