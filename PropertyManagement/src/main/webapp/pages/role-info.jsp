<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/19
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>角色信息</title>
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

        body {
            overflow-y: scroll;
        }

        .layui-body {
            overflow-y: scroll;
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
            <a>
              <cite>角色信息</cite></a>
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

    layui.use('table', function () {
        var table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            , toolbar: '#toolbarDemo'//开启自定义工具行，指向自定义工具栏模板选择器
            , defaultToolbar: ['filter', 'print', 'exports']
            , url: '${pageContext.request.contextPath}/admin/getRoleInfo?v=' + new Date().getTime()//数据接口
            , cols: [[
                //表头
                {type: 'checkbox', fixed: 'left'}
                , {field: 'roleId', title: 'ID', width: 80, sort: true}
                , {field: 'roleName', title: '角色名称', width: 480}
                , {title: '操作', toolbar: '#DoTool', fixed: 'right', width: 230}
            ]]
            , page: true //开启分页
            , done: function (res, curr, count) {

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
                        url: "${pageContext.request.contextPath}/admin/delRoleByRoleId",
                        data: {"roleId": data.roleId},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                window.location.href = "${pageContext.request.contextPath}/admin/role-info"
                            } else {
                                layer.alert("删除失败，后端异常", {icon: 6});
                            }
                        }
                    })
                })
            } else if (obj.event === 'edit') {
                //iframe层
                parent.layer.open({
                    type: 2,
                    title: '修改',
                    shadeClose: true, //点击遮罩关闭
                    area: [600, 400],
                    maxmin: true,
                    closeBtn: 1,
                    content: ['${pageContext.request.contextPath}/admin/getOneRoleInfoById/' + data.roleId, 'yes'], //iframe的url，yes是否有滚动条
                    end: function () {
                        location.reload();
                    }
                })
            } else if (obj.event === 'resource') {
                //iframe层
                parent.layer.open({
                    type: 2,
                    title: '分配资源',
                    shadeClose: true, //点击遮罩关闭
                    area: [600, 400],
                    maxmin: true,
                    closeBtn: 1,
                    content: ['${pageContext.request.contextPath}/admin/getParentResource/' + data.roleId, 'yes'], //iframe的url，yes是否有滚动条
                    end: function () {
                        location.reload();
                    }
                })
            }
        });

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
                    ids.push(checkStatus.data[i].roleId)
                }
                layer.confirm('确认要删除吗？' + ids.toString(), function (index) {
                    //获取当前点击对象的用户id
                    $.ajax({
                        // 编写json格式，设置属性和值
                        url: "${pageContext.request.contextPath}/admin/delRoleByRoleIds",
                        data: {"roleIds": ids.toString()},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                window.location.href = "${pageContext.request.contextPath}/admin/role-info"
                            } else {
                                layer.alert("删除失败，后端异常", {icon: 6});
                            }
                        }
                    })
                });
            }
        });

        $("#addRole").on("click", function () {
            //iframe层
            parent.layer.open({
                type: 2,
                title: '新增',
                shadeClose: true, //点击遮罩关闭
                area: [600, 400],
                maxmin: true,
                closeBtn: 1,
                content: ['${pageContext.request.contextPath}/pages/role-add.jsp'], //iframe的url，yes是否有滚动条
                end: function () {
                    location.reload();
                }
            })
        })

    })
</script>
<%--编辑删除--%>
<script type="text/html" id="DoTool">
    <a class="layui-btn layui-btn-xs do-edit" lay-event="edit"
    >编辑</a>
    <a class="layui-btn layui-btn-xs do-resource" lay-event="resource">分配资源</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs do-del" lay-event="del">删除</a>
</script>
<%--自定义工具栏--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-card-header" style="margin: 0;padding: 0">
        <button class="layui-btn layui-btn-danger del-btn"><i class="layui-icon"></i>批量删除
        </button>
        <button class="layui-btn" lay-even="addRole" id="addRole"><i
                class="layui-icon"></i>添加
        </button>
    </div>
</script>
</html>
