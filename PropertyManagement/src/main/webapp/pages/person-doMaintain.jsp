<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/23
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>报修信息</title>
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
              <cite>报修信息</cite></a>
          </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="taskType" placeholder="请输入维修类型" autocomplete="off"
                                   class="layui-input" id="taskType"/>
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <a id="sreachBtn" class="layui-btn" lay-filter="sreach"><i
                                    class="layui-icon">&#xe615;</i></a>
                        </div>
                    </form>
                </div>

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
    layui.use(['table', 'rate'], function () {
        var table = layui.table;
        var rate = layui.rate;
        //第一个实例
        table.render({
            elem: '#demo'
            , toolbar: '#toolbarDemo'//开启自定义工具行，指向自定义工具栏模板选择器
            , defaultToolbar: ['filter', 'print', 'exports']
            , url: '${pageContext.request.contextPath}/owner/getOwnerMainInfo?v=' + new Date().getTime()//数据接口
            , cols: [[
                //表头
                {type: 'checkbox', fixed: 'left'}
                , {field: 'maintainId', title: 'ID', width: 80, sort: true}
                , {field: 'description', title: '描述', width: 200}
                , {field: 'taskId', title: '任务id', width: 80, hide: true}
                , {
                    field: 'taskType',
                    title: '任务类型',
                    width: 95,
                    templet: '<div> {{d.task.taskType}}</div>',
                    sort: true
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
                , {field: 'repairId', title: '维修人员id', width: 140, hide: true}
                , {field: 'userId', title: '报修人员id', width: 90, hide: true}
                , {fixed: 'right', title: '操作', width: 300, toolbar: '#DoTool'}
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
            if (obj.event === 'del') {
                layer.confirm('真的删除么？', function () {
                    $.ajax({
                        // 编写json格式，设置属性和值
                        url: "${pageContext.request.contextPath}/maintain/delMaintainBymaintainId",
                        data: {"maintainId": data.maintainId},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                window.location.href = "${pageContext.request.contextPath}/maintain/maintain-info"
                            } else {
                                layer.alert("删除失败，后端异常", {icon: 6});
                            }
                        }
                    })
                })
            } else if (obj.event === 'showDetail') {
                //iframe层
                parent.layer.open({
                    type: 2,
                    title: '详细信息',
                    shadeClose: true, //点击遮罩关闭
                    area: [800, 600],
                    maxmin: true,
                    closeBtn: 1,
                    content: ['${pageContext.request.contextPath}/maintain/getMainToDetail/' + data.maintainId, 'yes'], //iframe的url，yes是否有滚动条
                    end: function () {
                        location.reload();
                    }
                })
            }else if (obj.event === 'doScore') {
                //iframe层
                parent.layer.open({
                    type: 2,
                    title: '评分',
                    shadeClose: true, //点击遮罩关闭
                    area: [400, 300],
                    maxmin: false,
                    closeBtn: 1,
                    content: ['${pageContext.request.contextPath}/maintain/doScore/' + data.maintainId, 'yes'], //iframe的url，yes是否有滚动条
                    end: function () {
                        location.reload();
                    }
                })
            }
        });
        /*
             * 搜索按钮点击
             * */
        $("#sreachBtn").on('click', function () {
            var taskType = $('#taskType');
            doReSreach(taskType);
        })

        /*
     * 搜索异步请求，并重新加载
     * */
        function doReSreach(taskType) {
            //执行重载
            table.reload('demo', {
                url: '${pageContext.request.contextPath}/maintain/getMainInfo',
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    taskType: taskType.val().trim(),
                }
            });
        }

        /**
         * 删除多行
         */
        $(".del-btn").click(function () {
            var checkStatus = table.checkStatus('demo');
            if (checkStatus.data.length < 1) {
                layer.alert("请选择一条数据操作");
                return false;
            } else {
                var ids = [];
                for (let i = 0; i < checkStatus.data.length; i++) {
                    ids.push(checkStatus.data[i].maintainId)
                }
                layer.confirm('确认要删除吗？' + ids.toString(), function (index) {
                    //获取当前点击对象的用户id
                    $.ajax({
                        // 编写json格式，设置属性和值
                        url: "${pageContext.request.contextPath}/maintain/delMaintainsBymaintainIds",
                        data: {"maintainIds": ids.toString()},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                window.location.href = "${pageContext.request.contextPath}/maintain/getMainInfo"
                            } else {
                                layer.alert("删除失败，后端异常", {icon: 6});
                            }
                        }
                    })
                });
            }
        });

        $("#addMaintain").on("click", function () {
            //iframe层
            parent.layer.open({
                type: 2,
                title: '新增',
                shadeClose: true, //点击遮罩关闭
                area: [800, 600],
                maxmin: true,
                closeBtn: 1,
                content: ['${pageContext.request.contextPath}/maintain/maintain-add'], //iframe的url，yes是否有滚动条
                end: function () {
                    location.reload();
                }
            })
        })
    })
</script>

<%--编辑删除--%>
<script type="text/html" id="DoTool">
    <%--    onclick="xadmin.open('编辑用户','${pageContext.request.contextPath}/user/user-edit',600,400)"--%>
    <%--    <a class="layui-btn layui-btn-xs do-repairPeson" lay-event="repairPeson"--%>
    <%--    >派遣</a>--%>
    <%--    <a class="layui-btn layui-btn-xs do-edit" lay-event="edit"--%>
    <%--    >编辑</a>--%>
    <a class="layui-btn layui-btn-xs do-showDetail" lay-event="showDetail"
    >详细信息</a>


    {{# if(d.finishTime !=null){ }}
    <a class="layui-btn layui-btn-xs do-score" lay-event="doScore">评分</a>
    {{# }else{ }}

    {{# } }}
    <a class="layui-btn layui-btn-danger layui-btn-xs do-del" lay-event="del">删除</a>

</script>
<%--自定义工具栏--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-card-header" style="margin: 0;padding: 0">
        <button class="layui-btn layui-btn-danger del-btn"><i class="layui-icon"></i>批量删除
        </button>
        <button class="layui-btn" lay-even="addMaintain" id="addMaintain"><i
                class="layui-icon"></i>添加
        </button>

    </div>
</script>
</html>

