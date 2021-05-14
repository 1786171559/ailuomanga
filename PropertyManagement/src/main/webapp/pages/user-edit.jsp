<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/18
  Time: 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>编辑用户信息</title>
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
                <label for="L_userName" class="layui-form-label">
                    <span class="x-red">*</span>用户名</label>
                <div class="layui-input-inline">
                    <input type="hidden" id="L_userId" name="userId" value="${userInfo.userId}">
                    <input type="text" id="L_userName" name="userName" lay-verify="userNames"
                           class="layui-input" value="${userInfo.userName}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_password" class="layui-form-label">
                    <span class="x-red">*</span>密码</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_password" name="password" lay-verify="password"
                           class="layui-input" value="${userInfo.password}"></div>
                <div class="layui-form-mid layui-word-aux" autocomplete="off" required="">6到16个字符</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: 5px"><span class="x-red">*</span>性别</label>
                <div class="layui-input-inline" style="height: 38px">
                    <c:choose>
                        <c:when test="${userInfo.sex=='男'}">
                            <input type="radio" name="sex" value="男" title="男" checked>
                            <input type="radio" name="sex" value="女" title="女">
                        </c:when>
                        <c:otherwise>
                            <input type="radio" name="sex" value="男" title="男">
                            <input type="radio" name="sex" value="女" title="女" checked>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="layui-form-item">
                <label for="L_age" class="layui-form-label">
                    <span class="x-red">*</span>年龄</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_age" name="age" lay-verify="age"
                           class="layui-input" value="${userInfo.age}" autocomplete="off" required=""></div>
            </div>

            <div class="layui-form-item">
                <label for="L_phone" class="layui-form-label">
                    <span class="x-red">*</span>手机号</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_phone" name="phone" lay-verify="phone"
                           class="layui-input" value="${userInfo.phone}" autocomplete="off" required=""></div>
            </div>

            <div class="layui-form-item">
                <label for="L_address" class="layui-form-label">
                    <span class="x-red">*</span>地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_address" name="address" lay-verify="addresss"
                           class="layui-input" value="${userInfo.address}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_carId" class="layui-form-label">
                    <span class="x-red">*</span>车牌号</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_carId" name="carId" lay-verify="carIds"
                           class="layui-input" value="${userInfo.carId}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: 5px"><span class="x-red">*</span>状态</label>
                <div class="layui-input-inline" style="height: 38px">
                    <c:choose>
                        <c:when test="${userInfo.isEnable=='1'}">
                            <input type="radio" name="isEnable" value="1" title="可用" checked>
                            <input type="radio" name="isEnable" value="0" title="禁用">
                        </c:when>
                        <c:otherwise>
                            <input type="radio" name="isEnable" value="1" title="可用">
                            <input type="radio" name="isEnable" value="0" title="禁用" checked>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_carId" class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="editBtn" lay-submit="" id="editBtn">修改</button>
            </div>

        </form>
    </div>
</div>
</body>


<script>
</script>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //自定义验证规则
        form.verify({
            password: [/(.+){6,16}$/, '密码必须6到16位'],
            age: [/^(?:[1-9][0-9]?|1[01][0-9]|120)$/, '年龄在1-120之间'],
            phone: [/^[1][3,4,5,6,7,8,9][0-9]{9}$/, '请正确输入手机号！！！'],
            userNames: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入用户名';
                }
            },
            addresss: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入用户居住地址！';
                }
            },
            carIds: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入用户车牌号码！';
                }
            }
        });
        //刷新界面 所有元素
        form.render();

        form.on('submit(editBtn)', function (data) {
            var users = data.field;
            //获取当前点击对象的用户id
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/user/changeUser",
                data: {
                    "userId": users.userId.trim(),
                    "userName": users.userName.trim(),
                    "password": users.password.trim(),
                    "sex": users.sex.trim(),
                    "age": users.age.trim(),
                    "phone": users.phone.trim(),
                    "address": users.address,
                    "carId": users.carId.trim(),
                    "isEnable": users.isEnable
                },
                async: false,
                dataType: "json",
                type: "post",
                success: function (data) {
                    if (data.flag == "success") {
                        window.parent.location.reload();
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                    } else {
                        alert("删除失败，后端异常", {icon: 5});
                    }
                }
            })
        });


    });
</script>
</html>