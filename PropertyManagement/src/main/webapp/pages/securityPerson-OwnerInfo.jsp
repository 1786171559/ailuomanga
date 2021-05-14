<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/25
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>业主信息</title>
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
              <cite>业主信息</cite></a>
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
            , url: '${pageContext.request.contextPath}/securityPerson/getOwnerInfo?v=' + new Date().getTime()//数据接口
            , cols: [[
                //表头
                {type: 'checkbox', fixed: 'left'}
                , {field: 'userId', title: 'ID', width: 100, sort: true}
                , {field: 'userName', title: '用户名', width: 120}
                , {field: 'sex', title: '性别', width: 120, sort: true}
                , {field: 'age', title: '年龄', width: 120, sort: true}
                , {field: 'phone', title: '手机号', width: 180}
                , {field: 'address', title: '地址', width: 200}
                , {field: 'carId', title: '车牌号', width: 150, templet: "#carIdTemplet", sort: true}
            ]]
            , page: true //开启分页
            , done: function (res, curr, count) {
                bindTableToolbarFunction()

            }
        });

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
                url: '${pageContext.request.contextPath}/securityPerson/getOwnerInfo',
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





<%--初始化界面：车牌号码为空时，显示无，如果有，则显示该车牌号码--%>
<script type="text/html" id="carIdTemplet">

    {{# if(d.carId != null){ }}{{d.carId}}{{# }else{ }}无{{# } }}
</script>


</html>
