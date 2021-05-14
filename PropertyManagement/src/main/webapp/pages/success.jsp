<%--
  Created by IntelliJ IDEA.
  User: chengzhi
  Date: 2021/4/13
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>我的桌面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script type="text/javascript" src="//api.map.baidu.com/api?type=webgl&v=1.0&ak=NLOmk6jzmO3DtVitpijsaHZy93hX6uwu"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        #allmap{
            width: 100%;
            height: 100%;
            padding: 0;
            margin: 0;
            overflow: hidden;
        }
    </style>
</head>
<body>
<div class="layui-bg-gray" style="padding: 30px;">
    <div class="layui-row layui-col-space15">

        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header"><h2>房屋</h2></div>
                <div class="layui-card-body" id="HouseMain" style="width: 500px;height:200px;">

                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header"><h2>人员信息</h2></div>
                <div class="layui-card-body" id="peopleCount" style="width: 500px;height:200px;">

                </div>
            </div>
        </div>
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><h2>待办已办</h2></div>
                <div class="layui-card-body" id="do_done" style="width: 500px;height:600px;">

                </div>
            </div>
        </div>
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><h2>小区位置</h2></div>
                <div class="layui-card-body" id="allmap" >

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<%--房屋统计--%>
<script>
    var myChart = echarts.init(document.getElementById("HouseMain"));
    var option = {
        aria: {
            enabled: true
        }, tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        }, legend: {
            orient: 'vertical',
            left: 'left',
            data: ['已售', '未售']
        },
        series: [
            {
                name: '房屋',
                type: 'pie',
                data: [
                    {value: ${sellOne}, name: '已售'},
                    {value: ${sellTow}, name: '未售'},
                ]
            }
        ]
    };
    myChart.setOption(option);
</script>
<%--人员统计--%>
<script type="text/javascript">

    var myChart2 = echarts.init(document.getElementById("peopleCount"));
    myChart2.clear();
    var names = [];
    var mydata = [];

    $.ajax({
        // 编写json格式，设置属性和值
        url: "${pageContext.request.contextPath}/start/getPeopleCount",
        data: {},
        dataType: "json",
        type: "post",
        success: function (data) {
            var str;
            for (var i = 0; i < data.roleInfos.length; i++) {
                names.push(data.roleInfos[i].roleName);
                mydata[i] = {value: data.roleInfos[i].count, name: data.roleInfos[i].roleName};

            }
            var option = {
                aria: {
                    enabled: true
                }, tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                }, legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: names
                }, series: [{
                    name: '所在小区',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: mydata,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
                ]
            };
            myChart2.setOption(option);
        }, error: function () {
            alert("后端异常")
        }
    })
</script>
<%--待办已办--%>
<script>
    var myChart3 = echarts.init(document.getElementById("do_done"));
    option = {
        legend: {},
        tooltip: {},
        dataset: {
            source: [
                ['product', '待办', '已办'],
                ['投诉', ${doComplaint}, ${doneComplaint}],
                ['报修', ${doThing}, ${doneThing}]

            ]
        },
        xAxis: {type: 'category'},
        yAxis: {},
        // Declare several bar series, each will be mapped
        // to a column of dataset.source by default.
        series: [
            {type: 'bar'},
            {type: 'bar'}
        ]
    };
    myChart3.setOption(option)
</script>

<script>
    // 百度地图API功能
    var map = new BMapGL.Map("allmap");
    map.centerAndZoom(new BMapGL.Point(114.774062,25.655866),15);
    map.enableScrollWheelZoom(true);
    var marker = new BMapGL.Marker(new BMapGL.Point(114.774062,25.655866));  // 创建标注
    map.addOverlay(marker);

    // 用经纬度设置地图中心点
    function theLocation(){
        if(document.getElementById("lng").value != "" && document.getElementById("lat").value != ""){
            map.clearOverlays();
            var new_point = new BMapGL.Point(document.getElementById("lng").value,document.getElementById("lat").value);
            var marker = new BMapGL.Marker(new_point);  // 创建标注
            map.addOverlay(marker);              // 将标注添加到地图中
            map.panTo(new_point);

        }
    }
</script>

<script>
    layui.config({
        base: '${pageContext.request.contextPath}/js/echarts.js'
    }).use(['layer', 'element', 'echarts'], function () {
        var element = layui.element,
            $ = layui.jquery,
            echarts = layui.echarts;

    })
</script>


</html>
