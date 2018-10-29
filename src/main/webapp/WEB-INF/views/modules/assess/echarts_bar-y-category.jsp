<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人任务管理</title>
	<meta name="decorator" content="default"/>
	<script src="${pageContext.request.contextPath}/static/echarts/js/echarts.min.js" type="text/javascript" charset="utf-8"></script>
<style type="text/css">
@media print {
			  a[href]:after {
			    content: none !important;
			  }
			  .noprint { 
			  	display: none;
			  } 
			}
</style>
<script>
    function iframePrint(){    //添加打印事件
      window.print();
    }
    function printAll() {
        window.location.href="${ctx}/assess/dbJob/print?id=${dbJob.id}"
    }
</script>
</head>
<body>
	<ul class="nav nav-tabs noprint">
		<li><a href="${ctx}/assess/dbJob/">任务创建列表</a></li>
		<shiro:hasPermission name="assess:dbJob:edit"><li class="active"><a href="${ctx}/assess/dbJob/echarts">统计</a></li></shiro:hasPermission>
	</ul>
	</br>
    <ul class="nav nav-tabs noprint">
    	<li><a href="${ctx}/assess/dbJob/table?id=${dbJob.id}">表格图</a></li>
		<li ><a href="${ctx}/assess/dbJobSelf/echarts?jobid=${jobid}">雷达统计图</a></li>
		<li class="active"><a href="${ctx}/assess/dbJobSelf/echartsy?jobid=${jobid}">明细图表</a></li>
		<li><a href="${ctx}/assess/dbJob/comment?id=${dbJob.id}">评语明细</a></li>
		<li>
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print();"/>
			<input id="" class="btn btn-primary" type="button" value="全部打印" onclick="printAll()"/>
		</li>
	</ul>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div class='container'>
		<div class='row'>
			<div class='col-sm-12 col-ms-12 col-lg-12'>
				<div id="main" style="height:600px; margin:20px 0;"></div>
			</div>
		</div>
	</div>
    <script type="text/javascript">
	var series =  ${fns:toJson(series)};
	var yAxis =  ${fns:toJson(yAxis)};
	var legend =  ${fns:toJson(legend)};
	
	
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
    option = {
    title: {
        text: '评分明细'
    },
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'shadow'
        }
    },
    toolbox: {
        show: true,
      
        feature: {
           /*  dataZoom: {
                yAxisIndex: 'none'
            }, */
            dataView: {readOnly: false},
            /* magicType: {type: ['line', 'bar']}, */
            restore: {},
            saveAsImage: {}
        }
    },
    legend: {
    	 type: 'scroll',
         orient: 'vertical',
         right: 10,
         top: 50,
         bottom: 20,
        data:legend /* ['2011年', '2012年'] */
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: {
        type: 'value',
        boundaryGap: [0, 0.01]
    },
    yAxis: yAxis/* {
        type: yAxis.type,
        data: yAxis.date/* ['巴西','印尼','美国','印度','中国','世界人口(万)'] 
     }*/,
    series:series/*  [
        {
            name: series[0].name,
            type: series[0].type,
            data: series[0].date
        },
        {
            name: series[1].name,
            type: series[1].type,
            data: series[1].date
        }
    ]  */
};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
	
</body>
</html>