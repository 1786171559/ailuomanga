<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/18
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户分配角色</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<%--action="${pageContext.request.contextPath}/privilege/userDoRole"--%>
<form class="layui-form" >
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">分配角色：</label>
        <input type="hidden" id="userId" name="userId" value="${userId}">
        <div class="layui-input-block" style="margin: 0;padding: 0;">
            <c:forEach items="${userRole}" var="ite">
                <c:choose>
                    <c:when test="${ite.privilege.userId!=null && ite.privilege.userId!=''}">

                        <input type="checkbox" name="roleId" value="${ite.roleId}"
                               title="${ite.roleName}" checked=""/>
                    </c:when>
                    <c:otherwise>
                        <input type="checkbox" name="roleId" value="${ite.roleId}"
                               title="${ite.roleName}"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
    <div class="layui-input-block">
        <button class="layui-btn"  id="subminBtn">立即提交</button>
        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
</form>
</body>
<script>
    layui.use(['form', 'upload'], function () {
        var form = layui.form;
        form.render();  // 渲染界面

    });

    $(function (){
        $("#subminBtn").click(function (){
            var roleId =[];
            $('input[name="roleId"]:checked').each(function(){
                roleId.push($(this).val());
            });
            alert(roleId)
            //获取当前点击对象的用户id
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/privilege/userDoRole",
                data: {
                    "userId":$("#userId").val(),
                    "roleId":roleId.toString()
                },
                dataType: "json",
                type: "post",
                async: false,
                success: function (data) {
                    if (data.flag == "success") {
                        alert("修改成功！！！");
                        window.parent.location.reload();
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                    }
                }
            })
        })
    })
</script>
</html>
