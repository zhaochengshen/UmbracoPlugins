using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using umbraco.DataLayer;
using Newtonsoft.Json;
using System.EnterpriseServices;

namespace UserManage.App_Plugins.UserManage
{
    /// <summary>
    /// UserTypeHandler 的摘要说明
    /// </summary>
    public class UserTypeHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain"; 

            string type = !string.IsNullOrWhiteSpace(context.Request.QueryString["type"]) ? context.Request.QueryString["type"].ToString() : "-1";
            if (type == "-1")
            {
                context.Response.Write("error can't return value");
            }
            //查询用户类型
            else if (type == "1")
            {
                context.Response.Write(JsonConvert.SerializeObject(GetUserType()));
            }
            //添加用户类型
            else if (type == "2")
            {
                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserTypeName"]))
                {
                    context.Response.Write("-1");
                }

                string userTypeName = context.Request.QueryString["UserTypeName"];
                if (AddUserType(userTypeName))
                {
                    context.Response.Write("0");
                }
                else
                {
                    context.Response.Write("-1");
                }

            }
            //删除用户类型
            else if (type == "3")
            {
                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserTypeID"]))
                {
                    context.Response.Write("-1");
                }
                string userTypeID = context.Request.QueryString["UserTypeID"];

                if (DeleteUserType(userTypeID))
                {
                    context.Response.Write("0");
                }
                else
                {
                    context.Response.Write("-1");
                }
            }
            //配置权限
            else if (type == "4")
            {
                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserTypeID"]) || string.IsNullOrWhiteSpace(context.Request.QueryString["permission"]))
                {
                    context.Response.Write("-1");
                }
                string id = context.Request.QueryString["UserTypeID"].ToString();
                string permission = context.Request.QueryString["permission"].ToString();

                if (SetPermission(id, permission))
                {
                    context.Response.Write("0");
                }
                else
                {
                    context.Response.Write("-1");
                }
            }
            //获取用户权限
            else if (type == "5")
            {
                if (string.IsNullOrWhiteSpace(context.Request.QueryString["UserTypeID"]))
                {
                    context.Response.Write("-1");
                }

                string userTypeID = context.Request.QueryString["UserTypeID"].ToString();
                context.Response.Write(GetUserTypePermission(userTypeID));
            }


            context.Response.End();
        }
         

        public string GetUserTypePermission(string userTypeID)
        {
            string permission = string.Empty;
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string sql_queryPermission = "SELECT ID,UserTypeAlias,UserTypeName,UserTypeDefaultPermissions FROM UmbracoUserType WHERE ID =@userTypeID";
                var paramUserTypeID = helper.CreateParameter("@userTypeID", userTypeID);
                using (IRecordsReader dr = helper.ExecuteReader(sql_queryPermission, paramUserTypeID))
                {
                    while (dr.Read())
                    {
                        permission += dr.GetString("UserTypeDefaultPermissions");
                    }
                }
            }
            return permission;
        }

        /// <summary>
        /// 删除用户类别信息
        /// </summary>
        /// <param name="userTypeID">用户类别ID</param>
        /// <returns></returns>
        public bool DeleteUserType(string userTypeID)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                try
                {
                    string sql_userTypeDel = "delete from UmbracoUserType where id=@id";
                    var paramID = helper.CreateParameter("@id", userTypeID);

                    if (helper.ExecuteNonQuery(sql_userTypeDel, paramID) > 0) { return true; }
                    else { return false; }
                }
                catch { return false; }
            }
        }



        /// <summary>
        /// 配置用户权限
        /// </summary>
        /// <param name="userTypeID">用户类别ID</param>
        /// <param name="permission">权限字符串</param>
        /// <returns></returns>
        public bool SetPermission(string userTypeID, string permission)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string sql_userTypePermission = "UPDATE UmbracoUserType SET UserTypeDefaultPermissions=@permission WHERE ID =@ID";
                var paramID = helper.CreateParameter("@ID", userTypeID);
                var paramPermission = helper.CreateParameter("@permission", permission);
                if (helper.ExecuteNonQuery(sql_userTypePermission, paramID, paramPermission) > 0) { return true; }
                else { return false; }
            }
        }


        /// <summary>
        /// 添加用户类别信息
        /// </summary>
        /// <param name="userTypeName">用户类别名称</param>
        /// <returns></returns>
        public bool AddUserType(string userTypeName)
        {
            string userTypeAlias = userTypeName.ToLower();
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                try
                {
                    string sql_userTypeInsert = "INSERT INTO UmbracoUserType(UserTypeAlias,UserTypeName,UserTypeDefaultPermissions) VALUES(@UserTypeAlias,@UserTypeName,'')";
                    var paramUserTypeAlias = helper.CreateParameter("@UserTypeAlias", userTypeAlias);
                    var paramUserTypeName = helper.CreateParameter("@UserTypeName", userTypeName);

                    if (helper.ExecuteNonQuery(sql_userTypeInsert, paramUserTypeAlias, paramUserTypeName) > 0) { return true; }
                    else { return false; }
                }
                catch { return false; }

            }

        }


        /// <summary>
        /// 获取用户类型
        /// </summary>
        /// <returns></returns>
        public List<UserType> GetUserType()
        {
            List<UserType> list = new List<UserType>();
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string sql_UserTypeQuery = "SELECT ID,UserTypeAlias,UserTypeName,UserTypeDefaultPermissions FROM UmbracoUserType";

                using (IRecordsReader dr = helper.ExecuteReader(sql_UserTypeQuery))
                {
                    while (dr.Read())
                    {
                        UserType userType = new UserType();
                        userType.ID = Convert.ToInt32(dr.GetString("ID"));
                        userType.UserTypeAlias = dr.GetString("UserTypeAlias");
                        userType.UserTypeName = dr.GetString("UserTypeName");
                        userType.UserTypeDefaultPermissions = dr.GetString("UserTypeDefaultPermissions");
                        list.Add(userType);
                    }
                }
            }
            return list;
        } 
        /// <summary>
        /// 用户权限对应关系
        /// </summary>
        public enum Permission
        {
            //[Description("I")]
            //管理主机名,
            //[Description("Z")]
            //跟踪审计,
            //[Description("F")]
            //浏览节点,
            //[Description("7")]
            //改变文档类型,
            //[Description("O")]
            //复制,
            //[Description("D")]
            //删除,
            //[Description("M")]
            //移动,
            //[Description("C")]
            //创建,
            //[Description("P")]
            //公众访问权限,
            //[Description("U")]
            //发布,
            //[Description("R")]
            //权限,
            //[Description("K")]
            //回滚,
            //[Description("5")]
            //发给翻译,
            //[Description("S")]
            //排序,
            //[Description("H")]
            //提交至发布者,
            //[Description("4")]
            //翻译,
            //[Description("A")]
            //更新 



            //管理主机名 = "I",
            //跟踪审计 = "Z",
            //浏览节点 = "F",
            //改变文档类型 = "7",
            //复制 = "O",
            //删除 = "D",
            //移动 = "M",
            //创建 = "C",
            //公众访问权限 = "P",
            //发布 = "U",
            //权限 = "R",
            //回滚 = "K",
            //发给翻译 = "5",
            //排序 = "S",
            //提交至发布者 = "H",
            //翻译 = "4",
            //更新 = "A"
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