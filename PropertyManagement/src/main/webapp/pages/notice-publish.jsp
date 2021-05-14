<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/23
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>发布公告</title>
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
                <label for="L_title" class="layui-form-label">
                    <span class="x-red">*</span>标题</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_title" name="title" lay-verify="titles"
                           class="layui-input" value="" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_content" class="layui-form-label">
                    <span class="x-red">*</span>内容</label>
                <div class="layui-input-inline">
                    <textarea type="text" id="L_content"  style="max-width: 190px;height:60px;resize: none;"
                              name="content" lay-verify="contents"
                              class="layui-input" value="" autocomplete="off" required=""></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_title" class="layui-form-label"></label>
                <a class="layui-btn" lay-filter="editBtn" lay-submit="" id="editBtn">新增</a>
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
        //刷新界面 所有元素
        layui.form.render();
        //自定义验证规则
        form.verify({
            titles: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入标题';
                }
            },
            contents: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入公告内容！';
                }
            }
        });


        form.on('submit(editBtn)', function (data) {
            var notice = data.field;
            //获取当前点击对象的用户id
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/notice/addNotice",
                data: {
                    "title": notice.title,
                    "content": notice.content,
                    "userId":${sessionScope.userId}
                },
                async: false,
                dataType: "json",
                type: "post",
                success: function (data) {
                    if (data.flag == "success") {
                       // alert("新增成功")
                        window.location.href = "${pageContext.request.contextPath}/notice/notice-info?v="+new Date().getTime();
                    } else {
                        alert("删除失败，后端异常", {icon: 5});
                    }
                }
            })
        });
    })
</script>
</html>

