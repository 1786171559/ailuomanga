<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/19
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>分配资源</title>
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
<style>
    .layui-table-cell .layui-form-checkbox[lay-skin="primary"] {
        top: 50%;
        transform: translateY(-50%);
    }
    .layui-form-select dl {
        max-height: 200px;
    }
    body {
        overflow-y: scroll;
    }

    .layui-body {
        overflow-y: scroll;
    }
</style>
<body>
<form class="layui-form">
    <div class="layui-form-item" lay-filter="myDiv">
        <label class="layui-form-label" style="">一级目录</label>
        <div class="layui-input-inline">
            <select id="select" name="resId" lay-filter="mySelect">
                <option value="">请选择资源</option>
                <c:forEach items="${resources}" var="ite">
                    <option value="${ite.resId}">${ite.resName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item" pane="">
        <label class="layui-form-label">二级目录：</label>
        <div class="layui-input-block" style="margin: 0;padding: 0;" id="checkBoxBtn">

        </div>
    </div>
    <div class="layui-input-block">
        <button class="layui-btn" id="subminBtn">立即提交</button>
        <button type="reset" class="layui-btn layui-btn-primary" id="resetBtn">重置</button>
    </div>
</form>
</body>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;
        layui.form.render();

        //当下拉列表变化时，异步请求数据
        layui.form.on('select(mySelect)', function (data) {
            console.log(data.value)
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/admin/getRoleResourcesByRoleId",
                data: {
                    "resId": data.value,
                    "roleId":${roleId}
                },
                dataType: "json",
                type: "post",
                async: false,
                success: function (data) {
                    if (data.flag == "success") {
                        var str = ""
                        for (let i = 0; i < data.resources.length; i++) {
                            for (let z = 0; z < data.resources[i].resos.length; z++) {
                                //  console.log(data.resources[i].resos)
                                // alert(data.resources[i].resos[z].resName);
                                for (let j = 0; j < data.RoleReSources.length; j++) {
                                    //如果该一级目录下的子级目录资源id = 该角色具备资源的resId
                                    if (data.resources[i].resos[z].resId == data.RoleReSources[j].resId) {
                                        if (data.RoleReSources[j].roleResource.roleId != null && data.RoleReSources[j].roleResource.roleId != "") {
                                            str += "<input type='checkbox' name='resId' value='" + data.resources[i].resos[z].resId +
                                                "' title='" + data.resources[i].resos[z].resName + "' checked=''/>";
                                        } else {
                                            str += "<input type='checkbox' name='resId' value='" + data.resources[i].resos[z].resId +
                                                "' title='" + data.resources[i].resos[z].resName + "'/>";
                                        }
                                    }
                                }
                            }
                        }
                        $("#checkBoxBtn").html(str)
                        layui.form.render();
                    }
                }
            })
        });

        /**
         * 当重置按钮点击时，重置页面内容
         */
        $("#resetBtn").click(function (){
            $("#checkBoxBtn").html("")
        })


    })

    $(function (){
        $("#subminBtn").click(function (){
            var resId =[];
            $('input[name="resId"]:checked').each(function(){
                resId.push($(this).val());
            });
            //获取当前点击对象的用户id
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/admin/addRoleResource",
                data: {
                    "parentId":$("#select").val(),
                    "resId":resId.toString(),
                    "roleId":${roleId}
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
