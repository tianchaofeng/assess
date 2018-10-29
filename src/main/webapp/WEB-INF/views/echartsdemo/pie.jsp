﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta content='text/html;charset=utf-8' http-equiv='content-type'>
 <title>Echarts图表Demo</title>
<!-- 引入echarts文件 -->
<script src="${pageContext.request.contextPath}/static/echartsdemo/js/esl/esl.js" type="text/javascript" ></script>
 

</head>

<body>

<div id="pie" style="width:800px;height:600px;">  </div>
 <script type="text/javascript">

 var fileLocation ='${pageContext.request.contextPath}/static/echartsdemo/js/echarts';
require.config({
   
    paths:{ 
         echarts: fileLocation,
            'echarts/chart/line': fileLocation,
            'echarts/chart/bar': fileLocation,
            'echarts/chart/pie': fileLocation
 
    }
});

// 作为入口
require(
    [
        'echarts',
        'echarts/chart/pie'
    ], 
	
	displayChart
    
);

function displayChart(ec) {
    	//饼图
		var pieChart = ec.init(document.getElementById('pie'));
		var pieChartOtion = getPieChartOption();	
        pieChart.setOption(pieChartOtion);
    }
	
	//获得Pie图的选项和数据
	function getPieChartOption(){
	  var pieChartOption = {
    tooltip : {
        show: true,
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient : 'vertical',
        x : 'left',
        data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他']
    },
    toolbox: {
        show : true,
        feature : {
            mark : true,
            dataView : {readOnly: false},
            restore : true,
            saveAsImage : true
        }
    },
    calculable : true,
    series : [
        {
            name:'访问来源',
            type:'pie',
            center : ['35%', 200],
            radius : 80,
            itemStyle : {
                normal : {
                    label : {
                        position : 'inner',
                        formatter : function(a,b,c,d) {return (d - 0).toFixed(0) + ' %'},
                    },
                    labelLine : {
                        show : false
                    }
                }
            },
            data:[
                {value:335, name:'直达'},
                {value:679, name:'营销广告'},
                {
                    value:1548,
                    name:'搜索引擎',
                    itemStyle : {
                        normal : {
                            label : {
                                show : false
                            }
                        },
                        emphasis : {
                            label : {
                                show : true,
                                formatter : "{b} : {d}%",
                                position : 'inner'
                            }
                        }
                    }
                }
            ]
        },
        {
            name:'访问来源',
            type:'pie',
            center : ['35%', 200],
            radius : [110, 140],
            data:[
                {value:335, name:'直达'},
                {value:310, name:'邮件营销'},
                {value:234, name:'联盟广告'},
                {value:135, name:'视频广告'},
                {
                    value:1048,
                    name:'百度',
                    itemStyle : {
                        normal : {
                            color : (function(){
                                var zrColor = require('zrender/tool/color');
                                return zrColor.getRadialGradient(
                                    300, 200, 110, 300, 200, 140,
                                    [[0, 'rgba(255,255,0,1)'],[1, 'rgba(30,144,250,1)']]
                                )
                            })(),
                            label : {
                                textStyle : {
                                    color : 'rgba(30,144,255,0.8)',
                                    align : 'center',
                                    baseline : 'middle',
                                    fontFamily : '微软雅黑',
                                    fontSize : 30,
                                    fontWeight : 'bolder'
                                }
                            },
                            labelLine : {
                                length : 40,
                                lineStyle : {
                                    color : '#f0f',
                                    width : 3,
                                    type : 'dotted'
                                }
                            }
                        }
                    }
                },
                {value:251, name:'谷歌'},
                {
                    value:102,
                    name:'必应',
                    itemStyle : {
                        normal : {
                            label : {
                                show : false
                            },
                            labelLine : {
                                show : false
                            }
                        },
                        emphasis : {
                            label : {
                                show : true
                            },
                            labelLine : {
                                show : true,
                                length : 50
                            }
                        }
                    }
                },
                {value:147, name:'其他'}
            ]
        },
        {
            name:'访问来源',
            type:'pie',
            startAngle: 90,
            center : ['75%', 200],
            radius : [80, 120],
            itemStyle :　{
                normal : {
                    label : {
                        show : false
                    },
                    labelLine : {
                        show : false
                    }
                },
                emphasis : {
                    color: (function(){
                        var zrColor = require('zrender/tool/color');
                        return zrColor.getRadialGradient(
                            650, 200, 80, 650, 200, 120,
                            [[0, 'rgba(255,255,0,1)'],[1, 'rgba(255,0,0,1)']]
                        )
                    })(),
                    label : {
                        show : true,
                        position : 'center',
                        formatter : "{d}%",
                        textStyle : {
                            color : 'red',
                            fontSize : '30',
                            fontFamily : '微软雅黑',
                            fontWeight : 'bold'
                        }
                    }
                }
            },
            data:[
                {value:335, name:'直达'},
                {value:310, name:'邮件营销'},
                {value:234, name:'联盟广告'},
                {value:135, name:'视频广告'},
                {value:1548, name:'搜索引擎'}
            ]
        }
    ]
};
                    
	
	
	return pieChartOption;
	}
</script>
</body>
</html>
