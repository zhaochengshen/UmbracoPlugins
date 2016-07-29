using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UserManage.App_Plugins.UserManage
{
    public class UserType
    {
        public int ID { get; set; }
        public string UserTypeAlias { get; set; }
        public string UserTypeName { get; set; }
        public string UserTypeDefaultPermissions { get; set; }
    }
}