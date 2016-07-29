$(document).ready(function () {
    $('#breadcrumbs').xBreadcrumbs();
    $("#div_AddFolder").hide();
    $("#div_AddFile").hide();
    GetFiles(1);


    //打开 关闭文件添加窗口
    $("#btnAddFile,#btnCloseAddFile").click(function () { 
        $("#txtFileName").val("");
        $("#txtFile").val("");
        toggle("div_AddFile");
    });
    //打开 关闭文件夹添加窗口
    $("#btnAddFolder,#btnCloseAddFolder").click(function () { 
        $("#txtFolderName").val(""); 
        toggle("div_AddFolder");
    });

    //添加文件夹
    $("#submitFolder").click(function () {
        var FolderName = $("#txtFolderName").val();
        if (FolderName === "") { txtFolderNameMsg.innerHTML = "不能为空"; return; }
        else { txtFolderNameMsg.innerHTML = ""; }
        var id = $("#ID").val();

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "FilesHandler.ashx?type=1&fileName=" + FolderName + "&fileType=0&parentID=" + id,
            dataType: "json",
            success: function () { GetFiles($("#ID").val()); toggle("div_AddFolder");  }
        });
    });

    //添加文件
    $("#submitFile").click(function () {
        var FileName = $("#txtFileName").val();
        var file = $("#txtFile").val();
        if (FileName == "") { txtFileNameMsg.innerHTML = "不能为空"; return; }
        else { txtFileNameMsg.innerHTML = ""; }
        if (file == "") { txtFileMsg.innerHTML = "请选择文件"; return; }
        else { txtFileMsg.innerHTML = ""; }
        var id = $("#ID").val();
        $("#form1").ajaxSubmit({
            success: function (msg) { if (msg === "-1") { alert("请上传文件"); } GetFiles($("#ID").val()); toggle("div_AddFile"); },
            url: "FilesHandler.ashx?type=1&fileName=" + FileName + "&fileType=1&parentID=" + id,
            type: "post",
            dataType: "text"
        });
    });

    //返回上级目录
    $("#goBack").click(function () {
        var id = $("#ID").val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "FilesHandler.ashx?type=4&id=" + id,
            dataType: "json",
            success: function (data) {
                GetFiles(data);
            }
        });
    });


});


//获取导航菜单
function MenuTree() {
    var id = $("#ID").val();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "FilesHandler.ashx?type=2&id=" + id,
        dataType: "json",
        success: function (data) {
            $("#breadcrumbs").html("");
            for (var i = 0; i < data.length; i++) {
                $("#breadcrumbs").append("<a href='#' onclick='GetFiles(" + data[i].ID + ")'><li>" + data[i].FileName + "</li></a>")
            }
        }, error: function () { alert("菜单加载失败！"); }
    });
}

function GetFiles(id) {
    $("#ID").val(id);
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "FilesHandler.ashx?type=3&id=" + id,
        dataType: "json",
        success: function (data) {
            BindTable(data);
        }
    });
    MenuTree();
}

//绑定列表数据
function BindTable(data) {
    $("#table1").html("");
    $("#table1").append('<tr id="th"><th>文件名称</th><th>文件类型</th><th>文件地址</th><th>操作</th></tr>');
    for (var i = 0; i < data.length; i++) {
        var trBegin = "<tr>";
        var td1 = "<td>" + data[i].FileName + "</td>";
        var td2 = "<td>" + GetFileType(data[i].ID, data[i].FileType) + "</td>";
        var td3 = "<td><a href='" + data[i].FilePath + "'>" + data[i].FilePath.substring(data[i].FilePath.lastIndexOf('\\') + 1) + "</a></td>";
        var td4 = "<td><input type='button' onclick='DelFiles(" + data[i].ID + ")' value='删除'></td>";
        var trEnd = "</tr>";
        var room = trBegin + td1 + td2 + td3 + td4 + trEnd;
        $("#table1").append(room);
    }
}
function GetFileType(ID, TypeID) {
    if (TypeID === 1) {
        return "文件";
    } else {
        return "<a href='#' onclick='GetFiles(" + ID + ")'>文件夹</a>";
    }

}
//删除数据
function DelFiles(id) {
    if (!confirm("是否删除？")) {
        return false;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "FilesHandler.ashx?type=5&id=" + id,
        dataType: "text",
        success: function (data) {
            GetFiles($("#ID").val());
        }
    });
}

function toggle(div_id) {

    var $div_obj = $("#" + div_id);
    if ($div_obj.is(":hidden")) {
        showDiv(div_id);
    } else {
        hideDiv(div_id);
    }
}
function showDiv(div_id) {
    var $div_obj = $("#" + div_id);
    var windowWidth = $(window).width();
    var windowHeight = $(window).height();
    var popupHeight = $div_obj.height();
    var popupWidth = $div_obj.width();
    $("<div id='bg'></div>").width(windowWidth)
        .height(windowHeight).click(function () {
        }).appendTo("body").fadeIn(200);

    $div_obj.animate({
        left: windowWidth / 2 - popupWidth / 2,
        top: windowHeight / 2 - popupHeight / 2,
        opacity: "show"
    }, "fast"); 
    $("#" + div_id + " input:first").focus();
}
function hideDiv(div_id) {
    $("#bg").remove();
    $("#" + div_id).animate({
        left: 0,
        top: 0,
        opacity: "hide"
    }, "slow");
}