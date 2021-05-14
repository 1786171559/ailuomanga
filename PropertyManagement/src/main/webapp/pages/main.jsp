<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/13
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
%>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台登录-X-admin2.2</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes,
          minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>

    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        // 是否开启刷新记忆tab功能
        // var is_remember = false;
    </script>
</head>
<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/pages/main.jsp">物业管理</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
    </div>
    <%--    <ul class="layui-nav left fast-add" lay-filter="">--%>
    <%--        <li class="layui-nav-item">--%>
    <%--            <a href="javascript:;">+新增</a>--%>
    <%--            <dl class="layui-nav-child">--%>
    <%--                <!-- 二级菜单 -->--%>
    <%--                <dd>--%>
    <%--                    <a onclick="xadmin.open('最大化','http://www.baidu.com','','',true)">--%>
    <%--                        <i class="iconfont">&#xe6a2;</i>弹出最大化</a></dd>--%>
    <%--                <dd>--%>
    <%--                    <a onclick="xadmin.open('弹出自动宽高','http://www.baidu.com')">--%>
    <%--                        <i class="iconfont">&#xe6a8;</i>弹出自动宽高</a></dd>--%>
    <%--                <dd>--%>
    <%--                    <a onclick="xadmin.open('弹出指定宽高','http://www.baidu.com',500,300)">--%>
    <%--                        <i class="iconfont">&#xe6a8;</i>弹出指定宽高</a></dd>--%>
    <%--                <dd>--%>
    <%--                    <a onclick="xadmin.add_tab('在tab打开','member-list.html')">--%>
    <%--                        <i class="iconfont">&#xe6b8;</i>在tab打开</a></dd>--%>
    <%--                <dd>--%>
    <%--                    <a onclick="xadmin.add_tab('在tab打开刷新','member-del.html',true)">--%>
    <%--                        <i class="iconfont">&#xe6b8;</i>在tab打开刷新</a></dd>--%>
    <%--            </dl>--%>
    <%--        </li>--%>
    <%--    </ul>--%>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">${sessionScope.userName}</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="xadmin.open('个人信息','${pageContext.request.contextPath}/user/getPesonalInformation/${sessionScope.userId}')">个人信息</a>
                </dd>
                <dd>
                    <a onclick="xadmin.open('修改密码','${pageContext.request.contextPath}/pages/changePassword.jsp')">修改密码</a>
                </dd>
                <c:if test="${count!=0}">
                    <dd>
                        <a onclick="xadmin.open('个人房产','${pageContext.request.contextPath}/house/MyHouse',600,400)">个人房产</a>
                    </dd>
                </c:if>
                <dd>
                    <a data-type="closeall" id="loginOutToIndex" href="">退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index">
            <a href="/">前台首页</a></li>
    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">

            <%--            <li class="">--%>
            <%--                <a href="javascript:;">--%>
            <%--                    <i class="iconfont left-nav-li " lay-tips="订单管理">&#xe723;</i>--%>
            <%--                    <cite>订单管理</cite>--%>
            <%--                    <i class="iconfont nav_right">&#xe697;</i></a>--%>
            <%--                <ul class="sub-menu ">--%>
            <%--                    <li>--%>
            <%--                        <a onclick="xadmin.add_tab('订单列表','${pageContext.request.contextPath}/pages/success.jsp')">--%>
            <%--                            <i class="iconfont">&#xe6a7;</i>--%>
            <%--                            <cite>订单列表</cite></a>--%>
            <%--                    </li>--%>
            <%--                    <li>--%>
            <%--                        <a onclick="xadmin.add_tab('订单列表1','order-list1.html')">--%>
            <%--                            <i class="iconfont">&#xe6a7;</i>--%>
            <%--                            <cite>订单列表1</cite></a>--%>
            <%--                    </li>--%>
            <%--                </ul>--%>
            <%--            </li>--%>

            <c:forEach items="${resources}" var="ite">
                <c:if test="${ite.resId!=null}">
                    <li>
                        <a href="javascript:;">
                            <c:choose>
                                <c:when test="${ite.resName=='管理员'}">
                                    <i class="iconfont left-nav-li" lay-tips="${ite.resName}">&#xe726;</i>
                                </c:when>
                                <c:when test="${ite.resName=='用户管理'}">
                                    <i class="layui-icon layui-icon-user" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:when test="${ite.resName=='房产管理'}">
                                    <i class="layui-icon layui-icon-home" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:when test="${ite.resName=='公告管理'}">
                                    <i class="layui-icon layui-icon-notice" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:when test="${ite.resName=='业主界面'}">
                                    <i class="layui-icon layui-icon-group" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:when test="${ite.resName=='保安界面'}">
                                    <i class="layui-icon layui-icon-friends" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:when test="${ite.resName=='维修管理'}">
                                    <i class="layui-icon layui-icon-util" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:when test="${ite.resName=='维修界面'}">
                                    <i class="layui-icon layui-icon-util" lay-tips="${ite.resName}"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="layui-icon layui-icon-star" lay-tips="${ite.resName}"></i>
                                </c:otherwise>
                            </c:choose>
                            <cite>${ite.resName}</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <c:forEach items="${ite.resos}" var="res">
                                <li>
                                    <a onclick="xadmin.add_tab('${res.resName}','${pageContext.request.contextPath}/${ite.resUrl}/${res.resUrl}')">
                                        <i class="iconfont">&#xe6a7;</i>
                                        <cite>${res.resName}</cite></a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>


            <c:if test="${sessionScope.landingType=='管理人员'}">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont left-nav-li" lay-tips="管理员管理">&#xe726;</i>
                        <cite>管理员管理</cite>
                        <i class="iconfont nav_right">&#xe697;</i></a>
                    <ul class="sub-menu">
                        <li>
                            <a onclick="xadmin.add_tab('管理员列表','${pageContext.request.contextPath}/admin/initializeAdminInfo')">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>管理员列表</cite></a>
                        </li>
                        <li>
                            <a onclick="xadmin.add_tab('角色管理','admin-role.html')">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>角色管理</cite></a>
                        </li>
                        <li>
                            <a onclick="xadmin.add_tab('权限分类','admin-cate.html')">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>权限分类</cite></a>
                        </li>
                        <li>
                            <a onclick="xadmin.add_tab('权限管理','admin-rule.html')">
                                <i class="iconfont">&#xe6a7;</i>
                                <cite>权限管理</cite></a>
                        </li>
                    </ul>
                </li>
            </c:if>

        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home">
                <i class="layui-icon">&#xe68e;</i>我的桌面
            </li>
        </ul>
        <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
            <dl>
                <dd data-type="this">关闭当前</dd>
                <dd data-type="other">关闭其它</dd>
                <dd data-type="all">关闭全部</dd>
            </dl>
        </div>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='${pageContext.request.contextPath}/start/success' frameborder="0" scrolling="yes"
                        class="x-iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
<script>//百度统计可去掉
var _hmt = _hmt || [];
(function () {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>

<script>
    layui.use('element', function(){

        var $ = layui.jquery
            ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        element.init();
        element.render("tab")

        var active = {
            //在这里给active绑定事件，后面可通过active调用这些事件
            tabDeleteAll:function(ids){//删除所有
                $.each(ids,function(i,item){
                    element.tabDelete("xbs_tab",item);//ids是一个数组，里面存放了多个id，调用tabDelete方法分别删除
                })
            }
        };
        /*
          * 搜索按钮点击
          * */
        $("#loginOutToIndex").on('click', function () {
            if ($(this).attr("data-type") == "closeall") {
                var tabtitle = $(".layui-tab-title li");
                var ids = new Array();
                $.each(tabtitle, function (i) {
                    ids[i] = $(this).attr("lay-id");
                });
                active.tabDeleteAll(ids);
            }
            $(this).attr("href","${pageContext.request.contextPath}/login/index");
        })
    })
</script>
</body>
</html>
