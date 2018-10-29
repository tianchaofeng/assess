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
		<li class="active"><a href="${ctx}/assess/dbJobSelf/echarts?jobid=${dbJob.id}">雷达统计图</a></li>
		<li><a href="${ctx}/assess/dbJobSelf/echartsy?jobid=${jobid}">明细图表</a></li>
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
				<div id="main" style='height:600px; margin:20px 0;'></div>
			</div>
		</div>
	</div>
    <!-- <div class="text-right" style='padding:20px 100px 0 0;border-top:1px solid #ccc'>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div> -->
    <script type="text/javascript">
	var series =  ${fns:toJson(series)};
	console.log("series:"+series);
	var indicator =  ${fns:toJson(indicator)};
	console.log("indicator:"+indicator);
	var legend =  ${fns:toJson(legend)};
	
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
    var option = {
    title: {
        text: '基础雷达图'
    },
    tooltip: {
    	 //  trigger: 'axis'
    },
    legend: {
    	 type: 'scroll',
         orient: 'vertical',
         right: 10,
         top: 50,
         bottom: 20,
        data: legend
        	/* ['预算分配（Allocated Budget）', '实际开销（Actual Spending）','哈哈哈!!!!!'] */
    },toolbox: {
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
    radar: {
        // shape: 'circle',
        name: {
            textStyle: {
                color: '#fff',
                backgroundColor: '#999',
                borderRadius: 3,
                padding: [3, 5]
           }
        },
        indicator:indicator /* [
           { name: '销售（sales）', max: 6500},
           { name: '管理（Administration）', max: 16000},
           { name: '信息技术（Information Techology）', max: 30000},
           { name: '客服（Customer Support）', max: 38000},
           { name: '研发（Development）', max: 52000},
           { name: '市场（Marketing）', max: 25000},
           { name: '人脉（Friends）', max: 100}
        ] */
    },
    series: [{
        name: '预算 vs 开销（Budget vs spending）',
        type: 'radar',
        // areaStyle: {normal: {}},
        data : series
        	/* [
            {
                value : [4, 1, 2, 3, 5, 5,3],
                name : '预算分配（Allocated Budget）'
            },
             {
                value : [5, 1, 2, 3, 4, 2,4],
                name : '实际开销（Actual Spending）'
            },
             {
                value : [3, 1, 2, 2, 4, 1,4],
                name : '哈哈哈!!!!!'
            }
        ] */
    }]
   };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
	
	<%-- <a href="${ctx}/assess/dbJobSelf/echartsy?jobid=${jobid}">明细图表</a> --%>
</body>
</html>