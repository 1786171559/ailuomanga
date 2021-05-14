<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/14
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>用户信息</title>
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
              <cite>用户信息</cite></a>
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
                            <input type="text" name="userName" placeholder="请输入用户名" autocomplete="off"
                                   class="layui-input" id="userName">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="sex" placeholder="请输入性别" autocomplete="off"
                                   class="layui-input" id="sex">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <input type="text" name="phone" placeholder="请输入手机号" autocomplete="off"
                                   class="layui-input" id="phone">
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


    layui.use('table', function () {
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            , toolbar: '#toolbarDemo'//开启自定义工具行，指向自定义工具栏模板选择器
            , defaultToolbar: ['filter', 'print', 'exports']
            , url: '${pageContext.request.contextPath}/user/GetUserInfo?v=' + new Date().getTime()//数据接口
            , cols: [[
                //表头
                {type: 'checkbox', fixed: 'left'}
                , {field: 'userId', title: 'ID', width: 80, sort: true}
                , {field: 'userName', title: '用户名', width: 80}
                , {field: 'loginName', title: '账户', width: 80}
                , {field: 'password', title: '密码', width: 95}
                , {field: 'sex', title: '性别', width: 80, sort: true}
                , {field: 'age', title: '年龄', width: 80, sort: true}
                , {field: 'phone', title: '手机号', width: 120}
                , {field: 'address', title: '地址', width: 140,}
                , {field: 'carId', title: '车牌号', width: 90, templet: "#carIdTemplet", sort: true}
                , {field: 'isEnable', title: '状态', width: 90, templet: "#isEnableTemplet"}
                , {fixed: 'right', title: '操作', width: 230, toolbar: '#DoTool'}
            ]]
            , page: true //开启分页
            , done: function (res, curr, count) {
                bindTableToolbarFunction()

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
                        url: "${pageContext.request.contextPath}/user/delUserByUserId",
                        data: {"userId": data.userId},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                window.location.href = "${pageContext.request.contextPath}/user/user-info"
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
                    content: ['${pageContext.request.contextPath}/user/getOneUserById/' + data.userId, 'yes'], //iframe的url，yes是否有滚动条
                    end: function () {
                        location.reload();
                    }
                })
            } else if (obj.event === 'do_roles') {
                //iframe层
                parent.layer.open({
                    type: 2,
                    title: '分配角色',
                    shadeClose: true, //点击遮罩关闭
                    area: [600, 400],
                    maxmin: true,
                    closeBtn: 1,
                    content: ['${pageContext.request.contextPath}/userRole/do_role/' + data.userId, 'yes'], //iframe的url，yes是否有滚动条
                    end: function () {
                        location.reload();
                    }
                })
            }
        });

        $("#addUser").on("click", function () {
            //iframe层
            parent.layer.open({
                type: 2,
                title: '新增',
                shadeClose: true, //点击遮罩关闭
                area: [600, 400],
                maxmin: true,
                closeBtn: 1,
                content: ['${pageContext.request.contextPath}/pages/user-add.jsp'], //iframe的url，yes是否有滚动条
                end: function () {
                    location.reload();
                }
            })
        })
        /*
        * 搜索按钮点击
        * */
        $("#sreachBtn").on('click', function () {
            var userName = $('#userName');
            var sex = $('#sex');
            var phone = $('#phone');
            doReSreach(userName, sex, phone);
        })

        /*
        * 搜索异步请求，并重新加载
        * */
        function doReSreach(userName, sex, phone) {
            //执行重载
            table.reload('demo', {
                url: '${pageContext.request.contextPath}/user/GetUserInfo',
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    userName: userName.val(),
                    sex: sex.val(),
                    phone: phone.val()
                }
            });
        }


        /*
        * 绑定事件，单行删除
        *
        * */
        function bindTableToolbarFunction() {

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
                    ids.push(checkStatus.data[i].userId)
                }
                layer.confirm('确认要删除吗？' + ids.toString(), function (index) {
                    //获取当前点击对象的用户id
                    $.ajax({
                        // 编写json格式，设置属性和值
                        url: "${pageContext.request.contextPath}/user/delUsersByUserIds",
                        data: {"userIds": ids.toString()},
                        dataType: "json",
                        type: "post",
                        success: function (data) {
                            if (data.flag == "success") {
                                window.location.href = "${pageContext.request.contextPath}/user/user-info"
                            } else {
                                layer.alert("删除失败，后端异常", {icon: 6});
                            }
                        }
                    })
                });
            }
        });
    });


    layui.use(['laydate', 'form'], function () {
        var form = layui.form;
        // 监听全选
        form.on('checkbox(checkall)', function (data) {

            if (data.elem.checked) {
                $('tbody input').prop('checked', true);
            } else {
                $('tbody input').prop('checked', false);
            }
            form.render('checkbox');
        });
    });

</script>


<script type="text/html" id="isEnableTemplet">
    {{# if(d.isEnable == 1){ }}
    <span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span>
    {{# }else{ }}
    <span class="layui-btn layui-btn-normal layui-btn-mini layui-btn-disabled">已停用</span>
    {{# } }}
</script>


<%--编辑删除--%>
<script type="text/html" id="DoTool">
    <%--    onclick="xadmin.open('编辑用户','${pageContext.request.contextPath}/user/user-edit',600,400)"--%>
    <a class="layui-btn layui-btn-xs do-edit" lay-event="edit"
    >编辑</a>
    <a class="layui-btn layui-btn-xs do-edit" lay-event="do_roles">分配角色</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs do-del" lay-event="del">删除</a>
</script>
<%--自定义工具栏--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-card-header" style="margin: 0;padding: 0" >
        <button class="layui-btn layui-btn-danger del-btn"><i class="layui-icon"></i>批量删除
        </button>
        <button class="layui-btn" lay-even="addUser" id="addUser"><i
                class="layui-icon"></i>添加
        </button>
    </div>
</script>
<%--初始化界面：车牌号码为空时，显示无，如果有，则显示该车牌号码--%>
<script type="text/html" id="carIdTemplet">

    {{# if(d.carId != null){ }}{{d.carId}}{{# }else{ }}无{{# } }}
</script>


</html>