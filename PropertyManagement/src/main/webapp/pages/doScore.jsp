<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/27
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>维修评分</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"] {
            top: 50%;
            transform: translateY(-50%);
        }

        .layui-form-select dl {
            max-height: 200px;
        }

    </style>
</head>
<body>
<div id="test" style="margin-left: 20px"></div>
<br/>
<a class="layui-btn layui-btn-xs do-scoreSubmit" lay-event="doScoreSubmit" id="doScoreSubmit" style="margin-left: 20px">提交</a>


</body>

<script>
    layui.use(['table', 'rate'], function () {
        var score;
        var table = layui.table;
        var rate = layui.rate;
        rate.render({
            elem: '#test'
            , value: ${score}
            , half: true
            , text: true
            , setText: function (value) {
                this.span.text(value);
                score = value;
            }
        });

        /**
         * 提交评价
         */
        $("#doScoreSubmit").click(function () {

            layer.confirm('请确实是否进行评分？', function (index) {
                //获取当前点击对象的用户id
                $.ajax({
                    // 编写json格式，设置属性和值
                    url: "${pageContext.request.contextPath}/maintain/doScoreSubmit",
                    data: {
                        "score": score, "maintainId": ${maintainId}
                    },
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        if (data.flag == "success") {
                            //重新加载父页面
                            window.parent.location.reload();
                            //关闭弹出层
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        } else {
                            layer.alert("删除失败，后端异常", {icon: 6});
                        }
                    }
                })
            })
        })


    })
    ;
</script>
</html>
