<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FilesUserControl.ascx.cs" Inherits="FileManage.App_Plugins.FileManage.FilesUserControl" %>


<script src="Scripts/jquery-1.8.2.intellisense.js"></script>
<script src="Scripts/jquery-1.8.2.min.js"></script> 
<script src="Scripts/xbreadcrumbs.js"></script> 
<script src="Scripts/json2.js"></script>
<script src="Scripts/jquery.form.js"></script>
<script src="Scripts/main.js"></script>


<link href="CSS/xbreadcrumbs.css" rel="stylesheet" />
<link href="CSS/main.css" rel="stylesheet" />
 
<input type="hidden" id="ID" /> 
<div>

    <div style="background-color: #c3c1b3">
        <ul class="xbreadcrumbs" id="breadcrumbs">
        </ul>
    </div>


    <div style="background-color: #808080">
        <input id="goBack" type="button" value="返回上一级目录" />
        <input id="btnAddFile" type="button" value="添加文件" />
        <input id="btnAddFolder" type="button" value="添加文件夹" />
    </div>

    <div>
        <table id="table1" class="gridtable">
        </table>
    </div>
</div>

<div id="div_AddFile">
    <form enctype="multipart/form-data" id="form1">
        <table class="editTable">
            <tr>
                <td>名称：</td>
                <td>
                    <input id="txtFileName" name="txtFileName" type="text" /><span id="txtFileNameMsg" class="Error"></span>

                </td>
            </tr>
            <tr>
                <td>上传文件：</td>
                <td>
                    <input id="txtFile" name="txtFile" multiple="multiple" type="file" /><span id="txtFileMsg" class="Error"></span>

                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="submitFile" type="button" value="保存" />
                    <input id="btnCloseAddFile" type="button" value="关闭" onclick="" />

                </td>
            </tr>
        </table>

    </form>
</div>
<div id="div_AddFolder">

    <form>
        <table class="editTable">
            <tr>
                <td>名称：</td>
                <td>
                    <input id="txtFolderName" name="txtFolderName" type="text" /><span id="txtFolderNameMsg" class="Error"></span>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="submitFolder" type="button" value="保存" />
                    <input id="btnCloseAddFolder" type="button" value="关闭" />

                </td>
            </tr>
        </table>
    </form>
</div>

