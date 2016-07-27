using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using umbraco.DataLayer;
using Newtonsoft.Json;

namespace FileManage.App_Plugins.FileManage
{
    /// <summary>
    /// FilesHandler 的摘要说明
    /// </summary>
    public class FilesHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string Type = context.Request.QueryString["Type"];//1 添加文件和文件夹、2 获取菜单路径、 3 数据列表

            //添加文件和文件夹
            if (Type == "1")
            {
                string fileName = context.Request.QueryString["fileName"];
                string fileType = context.Request.QueryString["fileType"];
                int parentID = Convert.ToInt32(context.Request.QueryString["parentID"].ToString());
                string filePath = string.Empty;
                HttpPostedFile file = context.Request.Files["txtFile"];

                if (fileType == "1" && file != null)
                {
                    string originalFileName = Path.GetFileName(file.FileName); ;

                    if (!string.IsNullOrWhiteSpace(originalFileName))
                    {
                        string virtualPath = "~\\media\\FileUpload\\" + DateTime.Now.ToString("yyyyMMddHHmmss") + "\\";
                        filePath = System.Web.HttpContext.Current.Server.MapPath(virtualPath);
                        if (!Directory.Exists(filePath)) { Directory.CreateDirectory(filePath); }
                        filePath += originalFileName;
                        file.SaveAs(filePath);
                        filePath = virtualPath.Substring(1) + originalFileName;
                    }
                }
                else if (fileType == "1" && file == null)
                {
                    context.Response.Write("-1");
                    return;
                }

                using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
                {
                    string strSql = "INSERT INTO files(filename,fileType,parentid,filepath) VALUES(@filename,@filetype,@parentid,@filepath);";
                    var paramFilename = helper.CreateParameter("@filename", fileName);
                    var paramFileType = helper.CreateParameter("@filetype", fileType);
                    var paramParentID = helper.CreateParameter("@parentid", parentID);
                    var paramFilePath = helper.CreateParameter("@filepath", filePath);

                    helper.ExecuteNonQuery(strSql, paramFilename, paramFileType, paramParentID, paramFilePath);

                }
            }
            //获取菜单
            else if (Type == "2")
            {
                int id = context.Request.QueryString["id"] != null ? Convert.ToInt32(context.Request.QueryString["id"]) : 1;
                context.Response.Write(MenuTree(id));
            }
            //获取数据列表
            else if (Type == "3")
            {
                int id = context.Request.QueryString["id"] != null ? Convert.ToInt32(context.Request.QueryString["id"]) : 1;
                context.Response.Write(BindFiles(id));
            }
            //获取上级菜单
            else if (Type == "4")
            {
                int id = context.Request.QueryString["id"] != null ? Convert.ToInt32(context.Request.QueryString["id"]) : 1;
                context.Response.Write(GetParentID(id));
            }
            //删除当前项及其子项
            else if (Type == "5")
            {
                int id = context.Request.QueryString["id"] != null ? Convert.ToInt32(context.Request.QueryString["id"]) : 1;
                context.Response.Write(DelFiles(id));
            }
            context.Response.End();

        }

        //获取父节点编号
        public int GetParentID(int ID)
        {
            int parentID = 1;
            if (ID <= 1) { return 1; }
            parentID = GetFiles().Where(f => f.ID == ID).FirstOrDefault() != null ? GetFiles().Where(f => f.ID == ID).FirstOrDefault().ParentID : 1;

            return parentID;
        }


        //删除当前内容及其子项
        public bool DelFiles(int id)
        {
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string strSql = "DELETE FROM files WHERE FIND_IN_SET (id, querychildrenfile(@FileID));";
                var paramFileId = helper.CreateParameter("@FileID", id);

                try
                {
                    helper.ExecuteNonQuery(strSql, paramFileId);
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }

        //查找所有文件信息
        public string BindFiles(int ID)
        {
            List<Files> list = GetFiles().Where(f => f.ParentID == ID).ToList();

            return JsonConvert.SerializeObject(list);
        }


        public List<Files> listFiles = new List<Files>();
        //导航

        public string MenuTree(int ID)
        {
            var list = GetFiles().Where(f => f.ID == ID);

            foreach (Files item in list)
            {
                listFiles.Add(item);
                MenuTree(item.ParentID);
            }
            listFiles = listFiles.OrderBy(f => f.ID).ToList();


            return JsonConvert.SerializeObject(listFiles);

        }


        //获取所有文件记录
        public List<Files> GetFiles()
        {
            var list = new List<Files>();
            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string strSql = "SELECT * FROM files";
                using (IRecordsReader dr = helper.ExecuteReader(strSql))
                {
                    while (dr.Read())
                    {
                        var files = new Files();
                        files.ID = dr.GetInt("ID");
                        files.FileName = dr.GetString("fileName");
                        files.FileType = Convert.ToInt32(dr.GetString("fileType"));
                        files.ParentID = Convert.ToInt32(dr.GetString("ParentID"));
                        files.FilePath = dr.GetString("FilePath");
                        list.Add(files);
                    }
                }
                return list;
            }
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