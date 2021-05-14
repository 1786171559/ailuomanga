<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/22
  Time: 18:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>公告信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.all.js" charset="utf-8"></script>
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

<form class="layui-form layui-col-space5">
    <div class="flow-default" id="demo">
        <%--    <c:forEach items="${noticeInfo}" var="ite">--%>
        <%--        <div class="layui-colla-item">--%>
        <%--            <h2 class="layui-colla-title">${ite.title}</h2>--%>
        <%--            <div class="layui-colla-content layui-show">--%>
        <%--                    ${ite.content}--%>
        <%--                <br/>--%>
        <%--                <div class=" layui-show" style="text-align: right">--%>
        <%--                    <a class="layui-btn layui-btn-danger layui-btn-xs do-del" lay-event="del">删除</a>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <%--    </c:forEach>--%>

    </div>
</form>

<script>


    layui.use('flow', function () {
        var $ = layui.jquery; //不用额外加载jQuery，flow模块本身是有依赖jQuery的，直接用即可。
        var flow = layui.flow;

        flow.load({
            elem: '#demo' //指定列表容器
            , isAuto: true
            , mb: 100
            , done: function (page, next) { //到达临界点（默认滚动触发），触发下一页
                var list = [];
                //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                $.post('${pageContext.request.contextPath}/notice/getNoticeInfo', {
                    page: page,
                    limit: 4
                }, function (res) {
                    //假设你的列表返回在data集合中
                    layui.each(res.data, function (index, item) {
                        var html = " <div class='layui-colla-item'><h2 class='layui-colla-title'>" + item.title

                            + "<span style='margin-left:10px;margin-top: 10px;text-align: right;font-size: 8px;color: #9F9F9F'>" +
                            item.userInfo.userName + "</span>"
                            + "<span style='font-size: 8px ;margin-left:10px;color: #9F9F9F'>" + item.publishDate + "</span>"
                            + "</h2> <div class='layui-colla-content layui-show'>" + item.content
                            + " <br/> <div class=' layui-show' style='text-align: right'> "
                            + "<input type='hidden' name='noticeId' value='" + item.noticeId + "'/>"
                            + "<a class='layui-btn layui-btn-danger layui-btn-xs do-del' lay-event='del' >" +
                            "删除</a></div></div></div>"
                        list.push(html);
                    });
                    //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                    //count为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                    next(list.join(''), page < res.count);
                }, 'json');
            }
        });
        $(document).on('click', '.do-del', function () {
            var noticeId=$(this).parent().find("input:eq(0)").val();
            layer.confirm("是否删除该通知?", function () {
                $.ajax({
                    // 编写json格式，设置属性和值
                    url: "${pageContext.request.contextPath}/notice/delNoticeByNoticeId",
                    data: {"noticeId": noticeId},
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        if (data.flag == "success") {
                            alert("成功")
                            window.location.href="${pageContext.request.contextPath}/notice/notice-info"
                        } else {
                            layer.alert("删除失败，后端异常", {icon: 6});
                        }
                    }
                })
            })

        });


    });

</script>
</body>
</html>
