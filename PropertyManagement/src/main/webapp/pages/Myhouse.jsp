<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/27
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>个人房产</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>

    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>

    <![endif]--></head>

<body>

<div class="layui-bg-gray" style="padding: 30px;">
    <div class="layui-row layui-col-space15">
        <c:forEach items="${houses}" var="ite">
            <div class="layui-col-md6">
                <div class="layui-card">
                    <div class="layui-card-header">${ite.deptNum}&nbsp;${ite.houseNum}号</div>
                    <div class="layui-card-body">
                        房子类型：${ite.houseType}<br>
                        详细地址：${ite.address}<br>
                        描述：${ite.memo}
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
