<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/22
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>维修详细信息</title>
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
                <label for="L_description" class="layui-form-label">
                    <span class="x-red"></span>描述</label>
                <div class="layui-input-inline">
                    <input type="hidden" id="L_maintainId" name="maintainId" value="${maintain.maintainId}">
                    <textarea id="L_description" name="description" lay-verify="descriptions" style="width: 775px;"
                              placeholder="请输入描述" autocomplete="off"
                              class="layui-textarea" disabled>${maintain.description}</textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">发生时间</label>
                <div class="layui-input-inline">
                    <fmt:formatDate value="${maintain.occurredTime}" pattern="yyyy-MM-dd HH:mm:ss" var="occurredTime"/>
                    <input type="text" class="layui-input" name="occurredTime" value="${occurredTime} "
                           lay-verify="occurredTimes"
                           id="occurredTime" placeholder="yyyy-MM-dd HH:mm:ss" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">派遣时间</label>
                <div class="layui-input-inline">
                    <fmt:formatDate value="${maintain.processingTime}" pattern="yyyy-MM-dd HH:mm:ss" var="processingTime"/>
                    <input type="text" class="layui-input" name="processingTime" value="${processingTime}"
                           lay-verify="processingTimes"
                           id="processingTime" placeholder="yyyy-MM-dd HH:mm:ss" disabled>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">完成时间</label>
                <div class="layui-input-inline">
                    <fmt:formatDate value="${maintain.finishTime}" pattern="yyyy-MM-dd HH:mm:ss" var="finishTime"/>
                    <input type="text" class="layui-input" name="finishTime"
                           lay-verify="finishTimes" id="finishTime" value="${finishTime}"
                           placeholder="yyyy-MM-dd HH:mm:ss" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">报修人员</label>
                <div class="layui-input-inline">
                    <input type="hidden" name="userId" value="${userInfo.userId}" >
                    <input type="text" class="layui-input" name="ownerName"
                           lay-verify="ownerNames" id="ownerName" value="${userInfo.userName}"
                           placeholder="报修人员" disabled>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系方式</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="ownerPhone"
                           lay-verify="ownerPhones" id="ownerPhone" value="${userInfo.phone}"
                           placeholder="报修人员联系方式" disabled>
                </div>
            </div>
            <c:if test="${repairInfo!='null'}">
                <div class="layui-form-item">
                    <label class="layui-form-label">维修人员</label>
                    <div class="layui-input-inline">
                        <input type="hidden" name="repairId" value="${repairInfo.userId}">
                        <input type="text" class="layui-input" name="repairName"
                               lay-verify="repairNames" id="repairName" value="${repairInfo.userName}"
                               placeholder="维修人员" disabled>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">联系方式</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="repairPhone"
                               lay-verify="repairPhones" id="repairPhone" value="${repairInfo.phone}"
                               placeholder="维修人员联系方式" disabled>
                    </div>
                </div>
            </c:if>
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