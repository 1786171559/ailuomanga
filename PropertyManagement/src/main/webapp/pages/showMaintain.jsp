<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/25
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>维修信息</title>
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
<div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">首页</a>
            <a href="">演示</a>
            <a>
              <cite>维修信息</cite></a>
          </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">

                <div class="layui-card-body layui-table-body layui-table-main">
                    <%--                    <table class="layui-table layui-form" lay-data="{id: 'demo'}" lay-filter="member" id="demo">--%>
                    <table class="layui-table layui-form" lay-filter="demo" id="demo">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['table','rate'], function () {
        var table = layui.table;
        var rate=layui.rate;
        //第一个实例
        table.render({
            elem: '#demo'
            , toolbar: '#toolbarDemo'//开启自定义工具行，指向自定义工具栏模板选择器
            , defaultToolbar: ['filter', 'print', 'exports']
            , url: '${pageContext.request.contextPath}/maintainer/getMainInfoByRepairId?v=' + new Date().getTime()//数据接口
            , cols: [[
                //表头
                {type: 'checkbox', fixed: 'left'}
                , {field: 'maintainId', title: 'ID', width: 80, sort: true}
                , {field: 'description', title: '描述', width: 200}
                , {
                    field: 'userName',
                    title: '报修人',
                    width: 120,
                    templet: '<div> {{d.userInfo.userName}}</div>',
                }
                , {
                    field: 'phone',
                    title: '报修人联系方式',
                    width: 150,
                    templet: '<div> {{d.userInfo.phone}}</div>',
                }
                , {field: 'occurredTime', title: '发生时间', width: 160, sort: true}
                , {field: 'processingTime', title: '派遣时间', width: 160, sort: true}
                , {field: 'finishTime', title: '完成时间', width: 160, sort: true}
                , {
                    field: "score", title: "评分", width: 200, sort: true, id: 'rate',
                    templet: function (d) {
                        //在设置星级的列中用templet函数转义，其中d.id代表该行的id值.第一行的评分的id=start1，第二行的评分的id=star2.....用在后面循环赋值。很重要！
                        return '<div id="star' + d.maintainId + '" style="font-size: 13px;line-height: 13px"></div>'
                    }
                }
                , {fixed: 'right', title: '操作', width: 120, toolbar: '#DoTool'}
            ]]
            , page: true //开启分页
            , done: function (res, curr, count) {
                var data = res.data;//返回的json中data数据
                table_data = data;//全局变量，用在后面排序，与这个循环无关。
                for (var item in data) {
                    //星级
                    rate.render({//循环设置评分
                        elem: '#star' + data[item].maintainId + ''//给不同的id的rate绑定不同的值
                        , length: 5            //星星个数
                        , value: data[item].score        //初始化值
                        , theme: '#009688'     //颜色
                        , half: true           //支持半颗星
                        , text: false           //显示文本，默认显示 '3.5星'
                        , readonly: true      //只读
                    });

                }
                table.on('sort(demo)', function (obj) {
                    for (var item in data) {
                        //星级
                        rate.render({//循环设置评分
                            elem: '#star' + data[item].maintainId + ''//给不同的id的rate绑定不同的值
                            , length: 5            //星星个数
                            , value: data[item].score        //初始化值
                            , theme: '#009688'     //颜色
                            , half: true           //支持半颗星
                            , text: false           //显示文本，默认显示 '3.5星'
                            , readonly: true      //只读
                        });

                    }
                    ;
                });

            }
        });


        //头工具栏事件
        table.on('tool(demo)', function (obj) {
            // 绑定删除用户事件
            var data = obj.data;
            if (obj.event === 'completeRepair') {
                layer.confirm('请确认是否完成修理？', function () {
                    $.ajax({
                        // 编写json格式，设置属性和值
                        url: "${pageContext.request.contextPath}/maintainer/completeRepair",
                        data: {"maintainId": data.maintainId},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                location.reload()
                            } else {
                                layer.alert("删除失败，后端异常", {icon: 6});
                            }
                        }
                    })
                })
            }
        });




    })
</script>

<%--编辑删除--%>
<script type="text/html" id="DoTool">
    <%--    onclick="xadmin.open('编辑用户','${pageContext.request.contextPath}/user/user-edit',600,400)"--%>
    <a class="layui-btn layui-btn-xs completeRepair" lay-event="completeRepair"
    >完成</a>
</script>
<%--自定义工具栏--%>
<script type="text/html" id="toolbarDemo">

</script>
</html>
