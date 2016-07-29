$(function () {
    $("#div_AddUserType").hide();
    $("#div_Permission").hide();

    //打开 关闭用户类型添加窗口
    $("#btnAddUserType,#btnCloseAddUserType").click(function () {
        $("#txtUserTypeName").val("");
        toggle("div_AddUserType");
    });

    //关闭权限配置窗口
    $("#btnClosePermission").click(function () {
        hideDiv("div_Permission");
    });

    //获取用户类型
    GetUserType();

    //添加用户类型
    $("#submit").click(function () {
        var UserTypeName = $("#txtUserTypeName").val();
        if (UserTypeName === "") { txtUserTypeMsg.innerHTML = "不能为空"; return; }
        else { txtUserTypeMsg.innerHTML = ""; }
        // var id = $("#ID").val();

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "UserTypeHandler.ashx?type=2&UserTypeName=" + UserTypeName,
            dataType: "json",
            success: function (data) {
                if (data == "-1") { alert("数据添加失败，请重试！"); }
                GetUserType();
                toggle("div_AddUserType");
            }
        });
    });


    $("#submitPermission").click(function () {
        SetPermission();
    });
}).keyup(function (event) {
    switch (event.keyCode) {
        case 27:
            hideDiv("div_AddUserType");
            hideDiv("div_Permission");
            break;
    }
});

//查询用户类型
function GetUserType() {
    $.getJSON("UserTypeHandler.ashx?type=1", function (data) {
        BindTable(data);
    });
}
//查询用户类型
function BindTable(data) {
    $("#table1").html("");
    $("#table1").append('<tr id="th"><th>编号</th><th>用户类型别名</th><th>用户类型名称</th><th>操作</th></tr>');
    for (var i = 0; i < data.length; i++) {
        var trBegin = "<tr>";
        var td1 = "<td>" + data[i].ID + "</td>";
        var td2 = "<td>" + data[i].UserTypeAlias + "</td>";
        var td3 = "<td>" + data[i].UserTypeName + "</td>"; 
        var param1 = "'" + data[i].ID + "'";
        var param2 = "'" + data[i].UserTypeName + "'";
        var param3 = "'" + data[i].UserTypeAlias + "'";
        var click = "openPermission(" + param1 + "," + param2 + "," + param3 + ")";
        var td4 = "<td><input type='button' onclick='DelUserType(" + data[i].ID + ")' value='删除' >&nbsp;<input type='button' onclick=" + click + "  value='权限'></td>";
        var trEnd = "</tr>";
        var room = trBegin + td1 + td2 + td3 + td4  + trEnd;
        $("#table1").append(room);
    }
}

//删除数据
function DelUserType(id) {
    if (!confirm("是否删除？")) {
        return false;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "UserTypeHandler.ashx?type=3&UserTypeID=" + id,
        dataType: "text",
        success: function (data) {
            GetUserType();
        }
    });
}

//打开配置权限窗口  设置已有的权限
function openPermission(ID, name, alias) {
    $("#lblUserTypeID").html(ID);
    $("#lblUserTypeName").html(name);
    $("#lblUserTypeAlias").html(alias);
    $("input:checkbox").attr("checked", false);

    $.ajax({
        type: "post",
        url: "UserTypeHandler.ashx?type=5&UserTypeID=" + ID,
        dataType: "text",
        success: function (data) { 
            var object = data;
            for (var i in object) {
                $("input[name='cbpermission'][value='" + object[i] + "']").attr("checked", true);
            }
        }
    });
    showDiv("div_Permission");

}

function SetPermission() {
    var cb_value = new Array();
    var userTypeID = $("#lblUserTypeID").html();
    $("input[name='cbpermission']:checked").each(function (i) {
        cb_value[i] = $(this).val();
    }); 

    $.ajax({
        type: "post",
        url: "UserTypeHandler.ashx?type=4&UserTypeID=" + userTypeID + "&permission=" + cb_value.join(""),
        dataType: "text",
        success: function (data) {
            if (data == "-1") { alert("权限设置失败！"); }
            GetUserType();
            hideDiv("div_Permission");
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
