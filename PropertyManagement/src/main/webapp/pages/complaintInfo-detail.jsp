<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/29
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>投诉详细信息</title>
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

<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form">

            <div class="layui-form-item">
                <label class="layui-form-label">投诉人</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="complainter" value="${complaintInfo.complainter}"
                           lay-verify="complainters"
                           id="complainter" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">投诉人电话</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="complainPhone" value="${complaintInfo.complainPhone}"
                           lay-verify="complainPhones"
                           id="complainPhone" disabled>
                </div>
            </div>
            <c:forEach items="${complaintTypes}" var="itm">
                <c:if test="${itm.complaintId==complaintInfo.complaintId}">
                    <div class="layui-form-item">
                        <label class="layui-form-label">投诉类型</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="complaintType"
                                   value="${itm.complaintType}"
                                   lay-verify="complaintTypes"
                                   id="complaintType" disabled>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <div class="layui-form-item">
                <label class="layui-form-label">投诉内容</label>
                <div class="layui-input-inline">
                 <textarea id="L_description" name="complaintContent" lay-verify="complaintContents"
                           style="width: 190px;height: 100px;"
                           autocomplete="off"
                           class="layui-textarea" disabled>${complaintInfo.complaintContent}</textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">处理人</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="handlingPerson"
                           value="${complaintInfo.handlingPerson}"
                           lay-verify="handlingPersons"
                           id="handlingPerson" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">处理人电话</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="handlingPhone"
                           value="${complaintInfo.handlingPhone}"
                           lay-verify="handlingPhones"
                           id="handlingPhone" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">状态</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="isComplete"
                           value="${complaintInfo.isComplete}"
                           lay-verify="isCompletes"
                           id="isComplete" disabled>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    layui.use(['form', 'layer', 'laydate'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate;

        //刷新界面 所有元素
        layui.form.render();

    })
</script>
</html>
