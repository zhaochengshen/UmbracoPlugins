using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using umbraco.BusinessLogic;

using umbraco.cms.businesslogic.packager;
using System.Text;

namespace FileManage.Events
{
    public class RegisterEvents : ApplicationEventHandler
    {

        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            InstalledPackage.BeforeDelete += InstalledPackage_BeforeDelete;
            InstalledPackage.AfterSave += InstalledPackage_AfterSave;
        }


        private void InstalledPackage_BeforeDelete(InstalledPackage sender, System.EventArgs e)
        {
            if (sender.Data.Name == "FileManage")
            {
                Install.Helper install = new Install.Helper();
                install.RemoveTrees();
                install.RemoveApplication();
            }
        }
        private void InstalledPackage_AfterSave(InstalledPackage sender, System.EventArgs e)
        {

            if (sender.Data.Name == "FileManage")
            {
                using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
                {
                    StringBuilder sbSQL = new StringBuilder();
                    sbSQL.Append(" CREATE TABLE IF NOT EXISTS files ( ");
                    sbSQL.Append("  id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, ");
                    sbSQL.Append("  fileName VARCHAR(200) NOT NULL COMMENT '文件[夹]名称', ");
                    sbSQL.Append("  FileType VARCHAR(200) NOT NULL COMMENT '文件类型：0文件夹 1文件', ");
                    sbSQL.Append("  ParentID INT(11) NOT NULL COMMENT '父节点ID',");
                    sbSQL.Append("  FilePath VARCHAR(200) DEFAULT NULL COMMENT '文件路径'");
                    sbSQL.Append(" ); ");
                    sbSQL.Append(" INSERT IGNORE INTO files(id,fileName,FileType,ParentID,FilePath) VALUES (1,'文件管理系统','0',-1,NULL); ");

                    helper.ExecuteNonQuery(sbSQL.ToString()); 

                    string sqlFunction = @"  
                          DROP FUNCTION IF EXISTS queryChildrenFile;
                          CREATE 
                          FUNCTION  queryChildrenFile() 
                          RETURNS VARCHAR(4000) CHARSET utf8
                          BEGIN 
                          DECLARE sTemp VARCHAR(4000);
                          DECLARE sTempChd VARCHAR(4000);
                          SET sTemp = '&';
                          SET sTempChd = CAST(fileID AS CHAR);
                          WHILE sTempChd IS NOT NULL DO
                          SET sTemp = CONCAT(sTemp,',',sTempChd);
                          SELECT GROUP_CONCAT(id) INTO sTempChd FROM files WHERE FIND_IN_SET(parentId,sTempChd)>0;
                          END WHILE;
                          RETURN sTemp;
                          END
                          ";
                    helper.ExecuteNonQuery(sqlFunction);

                }

                Install.Helper install = new Install.Helper();
                install.AddApplication();
                install.AddTrees();

            }
        }
    }
}