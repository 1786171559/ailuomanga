<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/29
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>投诉编辑</title>
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

            <div class="layui-form-item" pane="">
                <label class="layui-form-label">投诉类型：</label>
                <div class="layui-input-block" style="margin: 0;padding: 0;" id="checkBoxBtn">
                    <c:forEach items="${complaintTypes}" var="ite">
                        <c:choose>
                            <c:when test="${ite.complaintId==complaintInfo.complaintId}">
                                <input type='radio' name='complaintId' value='  ${ite.complaintId} '
                                       title=' ${ite.complaintType}  ' checked=''/>
                            </c:when>
                            <c:otherwise>
                                <input type='radio' name='complaintId' value='  ${ite.complaintId} '
                                       title=' ${ite.complaintType} '/>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                </div>
            </div>
            <div class="layui-form-item" pane="">
                <label class="layui-form-label" id="isComplete">状态：</label>
                <div class="layui-input-block" style="margin: 0;padding: 0;" id="checkBoxBtn2">
                    <c:if test="${complaintInfo.isComplete=='处理中'}">
                        <input type='radio' name='isComplete' value='待处理'
                               title='待处理'/>
                        <input type='radio' name='isComplete' value='处理中'
                               title='处理中' checked=''/>
                        <input type='radio' name='isComplete' value='已处理'
                               title='已处理'/>
                    </c:if>
                    <c:if test="${complaintInfo.isComplete=='待处理'}">
                        <input type='radio' name='isComplete' value='待处理'
                               title='待处理' checked=''/>
                        <input type='radio' name='isComplete' value='处理中'
                               title='处理中'/>
                        <input type='radio' name='isComplete' value='已处理'
                               title='已处理'/>
                    </c:if>
                    <c:if test="${complaintInfo.isComplete=='已处理'}">
                        <input type='radio' name='isComplete' value='待处理'
                               title='待处理'/>
                        <input type='radio' name='isComplete' value='处理中'
                               title='处理中'/>
                        <input type='radio' name='isComplete' value='已处理'
                               title='已处理' checked=''/>
                    </c:if>
                </div>
            </div>
            <div class="layui-form-item">
                <label for="isComplete" class="layui-form-label"></label>
                <a class="layui-btn" lay-filter="subminBtn" lay-submit="" id="subminBtn">立即提交</a>
                <a type="reset" class="layui-btn layui-btn-primary">重置</a>
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


    })
    $(function () {
        $("#subminBtn").click(function () {
            layer.confirm('确认要修改吗？', function (index) {
                $.ajax({
                    // 编写json格式，设置属性和值
                    url: "${pageContext.request.contextPath}/intelligenceService/editComplaintInfo",
                    data: {
                        "complaintId": $('input[name="complaintId"]:checked').val(),
                        "isComplete": $('input[name="isComplete"]:checked').val(),
                        "doComplaintId":${complaintInfo.doComplaintId}
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
            })

        })
    })
</script>
</html>
