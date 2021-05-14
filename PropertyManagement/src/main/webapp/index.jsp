<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/13
  Time: 8:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="<%=path%>/css/login.css" rel="stylesheet" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="css/style.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/img_ver.js"></script>
    <style>
        .loginOne {
            display: inline-block;
        }

        .loginTow {

            display: none;
        }
    </style>
    <script>
        $(function () {
            var loginName;
            var password;
            /**
             * 登录按钮点击
             * 用户名 userName
             * 密码 password
             * 登录类型 landingType
             */
            $("#landing").click(function () {
                loginName = $("#loginName").val();
                password = $("#password").val();
                if (loginName == "" || loginName == null) {
                    alert("请输入用户名")
                } else if (password == "" || password == null) {
                    alert("请输入密码")
                } else {
                    $(".loginOne").css({
                        "display": "none",
                        "opacity": "0"
                    });
                    $(".loginTow").css({
                        "display": "inline-block",
                        "opacity": "1"
                    })
                }
            });

            /**
             * 登录前通过异步请求判断账户和密码是否正确。
             * 如果不正确，提示错误。否则跳转页面
             * 用户名 userName
             * 密码 password
             * 登录类型 landingType
             */
            function landingJudge(loginName, password) {
                $.ajax({
                    // 编写json格式，设置属性和值
                    url: "<%=path%>/login/logingJudge",
                    data: {"loginName": loginName, "password": password},
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        if (data.flag == "success") {
                            $("#langingSubmit").submit();
                        } else if (data.flag == "userIsForbidden"){
                            alert("用户已被禁用，请联系管理员")
                        }else {
                            alert("账户或者密码错误！！！请重新输入")
                        }
                    }, error: function () {
                        alert("你大爷")
                    }
                })
            }

            imgVer({
                el: '$("#imgVer")',
                width: '260',
                height: '116',
                img: [
                    'images/ver.png',
                    'images/ver-1.png',
                    'images/ver-2.png',
                    'images/ver-3.png'
                ],
                success: function () {
                    //登录
                    landingJudge(loginName, password)
                    //alert('执行登录函数');
                    $(".loginOne").css({
                        "display": "inline-block",
                        "opacity": "1"
                    });
                    $(".loginTow").css({
                        "display": "none",
                        "opacity": "0"
                    });
                    $(".tips").html('你是不是不知道账号密码！？？？');
                    $("#logo").attr("src", 'images/login-err.png')
                },
                error: function () {
                    //alert('错误什么都不执行')
                }
            });
        })
    </script>
</head>
<body>
<div class="login_box">
    <div class="login_l_img"><img src="<%=path%>/images/login-img.png"/></div>
    <div class="login loginOne">
        <div class="login_logo"><a href="#"><img src="${pageContext.request.contextPath}/images/login_logo.png"/></a>
        </div>
        <div class="login_name">
            <p>物业管理系统</p>
        </div>

        <form method="post" action="login/Logining" id="langingSubmit">
            <input id="loginName" name="loginName" type="text" placeholder="账户">
            <input name="password" type="password" id="password" placeholder="密码"/>
            <input value="登录" style="width:100%;" type="button" id="landing">

        </form>

    </div>
    <div class="login loginTow">
        <div class="login_logo"><a href="#"><img src="${pageContext.request.contextPath}/images/login_logo.png"/></a>
        </div>
        <div class="login_name">
            <p>物业管理系统</p>
        </div>
        <div class="verBox" style="margin-top: 80px">
            <div id="imgVer" style=""></div>
        </div>
    </div>
    <div class="copyright">陈大大有限公司 版权所有©2021-20000 技术支持电话：13340171615</div>
</div>
<div style="text-align:center;">

</div>
</body>
</html>