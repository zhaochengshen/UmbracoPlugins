using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UserManage.App_Plugins.UserManage
{
    public class User
    {
        /// <summary>
        /// 用户编号
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 禁用用户 
        /// false启用  true 禁用
        /// </summary>
        public bool UserDisabled { get; set; }

        /// <summary>
        /// 禁用后台管理界面
        /// false 启用  true 禁用
        /// </summary>
        public bool UserNoConsole { get; set; }
        /// <summary>
        /// 用户类型
        /// </summary>
        public int UserType { get; set; }

        ///// <summary>
        ///// 默认打开内容项
        ///// </summary>
        //public int StartStructuserID { get; set; }

        ///// <summary>
        ///// 默认打开媒体项
        ///// </summary>
        //public int StartMediaID { get; set; }

        ///// <summary>
        /// 用户姓名
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// 用户登录名
        /// </summary>
        public string UserLogin { get; set; }
        /// <summary>
        /// 用户密码
        /// </summary>
        public string UserPassword { get; set; }

        /// <summary>
        /// 用户邮箱
        /// </summary>
        public string UserEmail { get; set; }
        /// <summary>
        /// 用户语言
        /// </summary>
        public string UserLanguage { get; set; }


        //public string SecurityStampToken { get; set; }

        //public int FailedLoginAttempts { get; set; }

        //public DateTime LastLockoutDate { get; set; }

        /// <summary>
        /// 最后一次修改密码时间
        /// </summary>
        public DateTime LastPasswordChangeDate { get; set; }

        ///// <summary>
        ///// 最后一次登录时间
        ///// </summary>
        //public DateTime LastLoginDate { get; set; }

        public List<User2App> Permission { get; set; }
    }

    public class User2App
    {
        public string App { get; set; }
    }
}