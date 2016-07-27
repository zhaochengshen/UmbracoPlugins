using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using umbraco.DataLayer;

namespace FileManage.App_Plugins.FileManage
{
    public partial class FileManageUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTree(null, -1);
                ddlFileType_SelectedIndexChanged(this, null);
            }

        }


        public void BindTree(TreeNode parentNode, int parentID)
        {
            var list = GetFiles().Where(f => f.ParentID == parentID);

            foreach (var item in list)
            {
                TreeNode node = new TreeNode();
                node.Text = item.FileName;
                node.Value = item.ID.ToString();
                if (item.FileType.Equals(0))
                {
                    node.ImageUrl = "images/folder.png";
                }
                else
                {
                    node.ImageUrl = "images/file.png";
                }
                BindTree(node, item.ID);

                if (parentNode == null)
                {
                    TreeView1.Nodes.Add(node);
                }
                else
                {
                    parentNode.ChildNodes.Add(node);
                }
            }
        }

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



        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {

            lblInfo_fileName.Text = TreeView1.SelectedNode.Text;
            lblInfo_fileID.Text = TreeView1.SelectedNode.Value;
            if (TreeView1.SelectedNode.ImageUrl == "images/folder.png")
            {
                lblParentID.Text = TreeView1.SelectedNode.Value.ToString();
                lblParentText.Text = TreeView1.SelectedNode.Text.ToString();
                lblInfo_fileType.Text = "文件夹";
                lblInfo_filePath.Text = string.Empty;
            }
            else
            {
                var files = GetFiles().FirstOrDefault(f => f.ID == Convert.ToInt32(TreeView1.SelectedNode.Value));
                lblParentID.Text = string.Empty;
                lblParentText.Text = string.Empty;
                lblInfo_fileType.Text = "文件";
                lblInfo_filePath.Text = files.FilePath.Substring(files.FilePath.LastIndexOf("\\") + 1);
            }
        }



        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(lblParentID.Text))
            {
                Alert("请选择上级目录");
                return;
            }

            string fileName = txtFileName.Text.Trim();
            string fileType = ddlFileType.SelectedValue.Trim();
            string parentID = lblParentID.Text.Trim();
            string filePath = string.Empty;



            if (fileType.Equals("1"))
            {
                if (string.IsNullOrWhiteSpace(FileUpload1.PostedFile.FileName))
                {
                    Alert("请选择上传的文件");
                    return;
                }

                if (!UploadFile(out filePath))
                {
                    Alert("文件上传失败！");
                    return;
                }
            }

            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string strSql = "INSERT INTO files(filename,fileType,parentid,filepath) VALUES(@filename,@filetype,@parentid,@filepath);";
                var paramFilename = helper.CreateParameter("@filename", fileName);
                var paramFileType = helper.CreateParameter("@filetype", fileType);
                var paramParentID = helper.CreateParameter("@parentid", parentID);
                var paramFilePath = helper.CreateParameter("@filepath", filePath);

                try
                {

                    helper.ExecuteNonQuery(strSql, paramFilename, paramFileType, paramParentID, paramFilePath);
                    Alert("文件保存成功！");
                    Response.Redirect(Request.Url.ToString());
                }
                catch (Exception ex)
                {

                    Alert("文件保存失败:" + ex.Message);
                }
            }

        }

        protected void btnDel_Click(object sender, EventArgs e)
        {
            if (TreeView1.SelectedNode == null || string.IsNullOrWhiteSpace(TreeView1.SelectedNode.Value))
            {
                Alert("请选择要删除的文件");
                return;
            }
            if (TreeView1.SelectedNode.Value.Equals("1"))
            {
                Alert("不能删除根目录");
                return;
            }

            using (var helper = umbraco.BusinessLogic.Application.SqlHelper)
            {
                string strSql = "DELETE FROM files WHERE FIND_IN_SET (id, querychildrenfile(@FileID));";
                var paramFileId = helper.CreateParameter("@FileID", lblInfo_fileID.Text.Trim());

                try
                {
                    helper.ExecuteNonQuery(strSql, paramFileId);
                    Alert("文件删除成功！");
                    Response.Redirect(Request.Url.ToString());
                }
                catch (Exception ex)
                {

                    Alert("文件删除失败:" + ex.Message);
                }
            }


        }

        protected void ddlFileType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFileType.SelectedValue.Equals("0"))
            {
                FileUpload1.Enabled = false;
            }
            else
            {
                FileUpload1.Enabled = true;
            }
        }


        public bool UploadFile(out string path)
        {
            path = string.Empty;
            string fileName = FileUpload1.PostedFile.FileName;
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                string virtualPath = "~\\media\\FileUpload\\" + DateTime.Now.ToString("yyyyMMddHHmmss") + "\\";
                string filePath = Server.MapPath(virtualPath); 
                if (!Directory.Exists(filePath)) { Directory.CreateDirectory(filePath); }
                filePath += fileName;
                FileUpload1.PostedFile.SaveAs(filePath);
                path = virtualPath.Substring(1) + fileName;
                return true;
            }
            return false;
        }

        public void Alert(string message)
        {
            Response.Write("<script>alert('" + message + "');</script>");

        }

    }

}