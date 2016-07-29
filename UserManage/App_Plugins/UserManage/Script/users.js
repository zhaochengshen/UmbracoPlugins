$(function () {
    GetUser();
    $("#div_AddUser").hide();
    $("#div_UpdateUser").hide();

    //打开 关闭用户添加窗口
    $("#btnAddUser,#btnCloseAdd").click(function () {
        $("#add_txtUserName").val("");
        $("#add_txtUserLogin").val("");
        $("#add_txtUserPassword").val("");
        $("#add_txtUserEmail").val("");
        $("#add_txtUserType").val(""); 
        $("#add_cbDisabled").attr("checked", true);
        $("#add_cbNoConsole").attr("checked", false);
        toggle("div_AddUser");
    });


    //添加用户
    $("#Add_submit").click(function () {
        var userName = $("#add_txtUserName").val();
        var userLogin = $("#add_txtUserLogin").val();
        var userPassword = $("#add_txtUserPassword").val();
        var userEmail = $("#add_txtUserEmail").val();
        if (userName === "") { add_txtUserNameMsg.innerHTML = "不能为空"; return; }
        else { add_txtUserNameMsg.innerHTML = ""; }
        if (userLogin === "") { add_txtUserLoginMsg.innerHTML = "不能为空"; return; }
        else { add_txtUserLoginMsg.innerHTML = ""; }
        if (userPassword === "") { add_txtUserPasswordMsg.innerHTML = "不能为空"; return; }
        else { add_txtUserPasswordMsg.innerHTML = ""; }
        if (userEmail === "") { add_txtUserEmailMsg.innerHTML = "不能为空"; return; }
        else { add_txtUserEmailMsg.innerHTML = ""; }


        $("#form1").ajaxSubmit({
            success: function (data) {
                if (data == "-1") {
                    alert("用户添加失败！");
                }
                GetUser();
                hideDiv("div_AddUser");
            },
            url: "UserHandler.ashx?type=2",
            type: "post",
            dataType: "text"
        });
    });


    //修改用户
    $("#update_submit").click(function () {
        UpdateUser();
    });

    //关闭修改页面
    $("#btnCloseUpdate").click(function () {
        hideDiv("div_UpdateUser");
    });

    ////获取用户类型
    //GetUserType();




    //$("#submitPermission").click(function () {
    //    SetPermission();
    //});
}).keyup(function (event) {
    switch (event.keyCode) {
        case 27:
            hideDiv("div_AddUser");
            hideDiv("div_UpdateUser");
            break;
    }
});

//查询用户
function GetUser() {
    $.getJSON("UserHandler.ashx?type=1", function (data) {
        BindTable(data);
    });
}
//绑定用户
function BindTable(data) {
    $("#table1").html("");
    $("#table1").append('<tr id="th"><th>用户名</th><th>用户登录名</th><th>邮箱</th><th>操作</th></tr>');
    for (var i = 0; i < data.length; i++) {
        var trBegin = "<tr>";
        var td1 = "<td>" + data[i].UserName + "</td>";
        var td2 = "<td>" + data[i].UserLogin + "</td>";
        var td3 = "<td>" + data[i].UserEmail + "</td>";
        var td4 = "<td><input type='button' onclick='DelUser(" + data[i].ID + ")' value='删除'>&nbsp;&nbsp;<input type='button' onclick='openUpdateUser(" + data[i].ID + ")' value='修改'></td>";
        var trEnd = "</tr>";
        var room = trBegin + td1 + td2 + td3 + td4 + trEnd;
        $("#table1").append(room);
    }
}

//删除数据
function DelUser(id) {
    if (!confirm("是否删除该用户，删除用户后会删除关联数据？")) {
        return false;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "UserHandler.ashx?type=3&UserID=" + id,
        dataType: "text",
        success: function (data) {
            if (data == "-1") { alert("用户删除失败！"); }
            GetUser();
        }
    });
}


//打开修改页面窗口
function openUpdateUser(id) {
    $("#lblUserID").html(id);
    $("input:checkbox[name='update_cbarea']").attr("checked", false);

    $.getJSON("UserHandler.ashx?type=4&UserID=" + id, function (data) {
        $("#update_txtUserName").val(data[0].UserName);
        $("#update_txtUserLogin").val(data[0].UserLogin);
        $("#update_txtUserPassword").val(data[0].UserPassword);
        $("#update_txtUserEmail").val(data[0].UserEmail);
        $("#update_txtUserType").val(data[0].UserType);

        $("#update_cbDisabled").attr("checked", data[0].UserDisabled);
        $("#update_cbNoConsole").attr("checked", data[0].UserNoConsole);

    });

    showDiv("div_UpdateUser");

}
//用户修改
function UpdateUser() {
    var userID = $("#lblUserID").html();
    var userName = $("#update_txtUserName").val();
    var userLogin = $("#update_txtUserLogin").val();
    var userPassword = $("#update_txtUserPassword").val();
    var userEmail = $("#update_txtUserEmail").val();

    if (userName === "") { update_txtUserNameMsg.innerHTML = "不能为空"; return; }
    else { update_txtUserNameMsg.innerHTML = ""; }
    if (userLogin === "") { update_txtUserLoginMsg.innerHTML = "不能为空"; return; }
    else { update_txtUserLoginMsg.innerHTML = ""; }
    if (userPassword === "") { update_txtUserPasswordMsg.innerHTML = "不能为空"; return; }
    else { update_txtUserPasswordMsg.innerHTML = ""; }
    if (userEmail === "") { update_txtUserEmailMsg.innerHTML = "不能为空"; return; }
    else { update_txtUserEmailMsg.innerHTML = ""; }

    $("#form2").ajaxSubmit({
        success: function (data) {
            if (data == "-1") {
                alert("用户修改失败！");
            }
            GetUser();
            hideDiv("div_UpdateUser");
        },
        url: "UserHandler.ashx?type=5&UserID=" + userID,
        type: "post",
        dataType: "text"
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
