using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FileManage.App_Plugins.FileManage
{
    public class Files
    {
        public int ID { get; set; }
        public string FileName { get; set; }

        public int FileType { get; set; }

        public int ParentID { get; set; }

        public string FilePath { get; set; }
    }
}