<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/20
  Time: 8:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>资源新增</title>
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
                <label for="L_resName" class="layui-form-label">
                    <span class="x-red">*</span>资源名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_resName" name="resName" lay-verify="resNames"
                           class="layui-input" value="" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_resUrl" class="layui-form-label">
                    <span class="x-red">*</span>资源地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_resUrl" name="resUrl" lay-verify="resUrls"
                           class="layui-input" value="" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item" lay-filter="myDiv">
                <label class="layui-form-label" style="">目录</label>
                <div class="layui-input-inline">
                    <select id="select" name="resId" lay-filter="mySelect">
                        <option value="0">请选择父级目录</option>
                        <c:forEach items="${resources}" var="ite">
                            <option value="${ite.resId}">${ite.resName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_resName" class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="editBtn" lay-submit="" id="editBtn">新增</button>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;
        layui.form.render();

        //自定义验证规则
        form.verify({
            resNames: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入资源名称';
                }
            }, resUrls: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入资源地址';
                }
            }
        });
        //当修改按钮点击时，异步请求修改角色信息
        form.on('submit(editBtn)', function (data) {
            var resource = data.field;
            //获取当前点击对象的用户id
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/admin/addResource",
                data: {
                    "resName": resource.resName.trim(),
                    "resUrl": resource.resUrl.trim(),
                    "parentId": resource.resId
                },
                async: false,
                dataType: "json",
                type: "post",
                success: function (data) {
                    if (data.flag == "success") {
                        //重新加载父页面
                        window.parent.location.reload();
                        //关闭弹出层
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                    } else if (data.flag == "resNameIsExit") {
                        alert("资源名称存在，请重新输入")
                    } else if (data.flag == "resUrlIsExit") {
                        alert("资源地址存在，请重新输入")
                    } else {
                        alert("删除失败，后端异常", {icon: 5});
                    }
                }
            })
        });

    })
</script>
</html>
