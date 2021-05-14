<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/21
  Time: 8:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>编辑房屋信息</title>
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
                <label for="L_houseNum" class="layui-form-label">
                    <span class="x-red">*</span>门牌号</label>
                <div class="layui-input-inline">
                    <input type="hidden" id="L_houseId" name="houseId" value="${house.houseId}">
                    <input type="text" id="L_houseNum" name="houseNum" lay-verify="houseNums"
                           class="layui-input" value="${house.houseNum}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_deptNum" class="layui-form-label">
                    <span class="x-red">*</span>楼号</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_deptNum" name="deptNum" lay-verify="deptNums"
                           class="layui-input" value="${house.deptNum}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_houseType" class="layui-form-label">
                    <span class="x-red">*</span>房子类型</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_houseType" name="houseType" lay-verify="houseTypes"
                           class="layui-input" value="${house.houseType}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label for="L_address" class="layui-form-label">
                    <span class="x-red">*</span>地区</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_address" name="address" lay-verify="addresss"
                           class="layui-input" value="${house.address}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: 5px"><span class="x-red">*</span>状态</label>
                <div class="layui-input-inline" style="height: 38px">
                    <c:choose>
                        <c:when test="${house.sellStatus=='待售'}">
                            <input type="radio" name="sellStatus" value="待售" title="待售" checked>
                            <input type="radio" name="sellStatus" value="已售" title="已售">
                        </c:when>
                        <c:otherwise>
                            <input type="radio" name="sellStatus" value="待售" title="待售">
                            <input type="radio" name="sellStatus" value="已售" title="已售" checked>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_direction" class="layui-form-label">
                    <span class="x-red">*</span>朝向</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_direction" name="direction" lay-verify="directions"
                           class="layui-input" value="${house.direction}" autocomplete="off" required=""></div>
            </div>

            <div class="layui-form-item">
                <label for="L_memo" class="layui-form-label">
                    <span class="x-red">*</span>备注</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_memo" name="memo" lay-verify="memos"
                           class="layui-input" value="${house.memo}" autocomplete="off" required=""></div>
            </div>
            <div class="layui-form-item" lay-filter="myDiv">
                <label class="layui-form-label" for="select" style="">户主</label>
                <div class="layui-input-inline">
                    <select id="select" name="userId" lay-filter="mySelect">
                        <option value="0">请选择户主</option>
                        <c:forEach items="${userInfo}" var="ite">
                            <option value="${ite.userId}">${ite.userName}</option>
                        </c:forEach>
                    </select>

                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_phone" class="layui-form-label">
                    <span class="x-red">*</span>户主手机号</label>
                <div class="layui-input-inline">
                    <input type="text" id="L_phone" name="phone" lay-verify="phones"
                           class="layui-input" value="" disabled></div>
            </div>
            <div class="layui-form-item">
                <label for="select" class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="editBtn" lay-submit="" id="editBtn">修改</button>
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
            houseNums: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入门牌号';
                }
            },
            deptNums: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入楼号！';
                }
            },
            houseTypes: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入房屋类型！';
                }
            },
            addresss: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入地址！';
                }
            },
            directions: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入房屋朝向！';
                }
            }, memos: function (value) {
                value = value.trim();
                if (value.length < 0 || value == "") {
                    return '请输入描述内容！';
                }
            }
        });
        //当下拉列表变化时，异步请求数据
        layui.form.on('select(mySelect)', function (data) {
            if (data.value == '0') {
                $("#L_phone").val("")
            } else {
                $.ajax({
                    // 编写json格式，设置属性和值
                    url: "${pageContext.request.contextPath}/user/getUserInfoByUserId",
                    data: {"userId": data.value},
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        if (data.flag == "success") {
                            $("#L_phone").val(data.userInfo.phone)
                        } else {
                            layer.alert("删除失败，后端异常", {icon: 6});
                        }
                    }
                })
            }
        })


        form.on('submit(editBtn)', function (data) {
            var house = data.field;
            //获取当前点击对象的用户id
            $.ajax({
                // 编写json格式，设置属性和值
                url: "${pageContext.request.contextPath}/house/changeHouse",
                data: {
                    "houseId": house.houseId,
                    "houseNum": house.houseNum,
                    "deptNum": house.deptNum,
                    "houseType": house.houseType,
                    "address": house.address,
                    "sellStatus": house.sellStatus,
                    "direction": house.direction,
                    "memo": house.memo,
                    "userId": house.userId
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
    })
</script>
</html>
