<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>快捷入口</title>
	<meta name="decorator"content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			var list = ${fns:toJson(list)};
			for(var i=0;i<list.length;i++){
				
				$("#"+list[i]).removeAttr("href");//添加disabled属性 
				document.getElementById(list[i]).setAttribute("onclick","alert('您无权限操作!')");
			}
		});
		function show(){
			alert("asdfasdas");
		}
		</script>
		<style>
		.index_box .col-sm-3 a img{
			width:100%;
			padding:15px 0;
		}
		</style>
</head>

<body>
<%-- <div style="width: 100%;margin: auto;padding-top: 1%;padding-left:7%">
<a id="1" href="${ctx}/assess/dbEvaluatingTeam/"><img style="width: 23%;padding: 2%;" src="${ctxStatic}/images/1.png"></a>
<a id="2" href="${ctx}/assess/dbJob/form"><img style="width: 23%;padding: 2%;" src="${ctxStatic}/images/2.png"></a>
<a id="3" href="${ctx}/assess/dbJob/list"><img style="width: 23%;padding: 2%;" src="${ctxStatic}/images/3.png"></a>    
</div>
<div  style="width: 100%;margin: auto;padding-left:7%">
<a id="4" href="${ctx}/assess/dbQuestionnaireSurvey/"><img style="width: 23%;padding: 2%;" src="${ctxStatic}/images/4.png"></a>
<a id="5" href="${ctx}/assess/dbJobSelf/list"><img style="width: 23%;padding: 2%;" src="${ctxStatic}/images/5.png"></a>
<a id="6" href="${ctx}/assess/dbJob/list"><img style="width: 23%;padding: 2%;" src="${ctxStatic}/images/6.png"></a>
</div> --%>
<div class='index_box'>
	<div class='container'>
		<div class='col-sm-12'>
			<%-- <div class='col-sm-3'><a id="1" href="${ctx}/assess/dbEvaluatingTeam/form" target="mainFrame" data-href=".menu3-6028b800ce4c45b5ab1ad7af8c66619d"><img src="${ctxStatic}/images/1.png"></a></div> --%>
			<div class='col-sm-3'><a id="1" href="${ctx}/assess/dbEvaluatingTeam/form"><img src="${ctxStatic}/images/1.png"></a></div>
			<div class='col-sm-3'><a id="2" href="${ctx}/assess/dbJob/form"><img src="${ctxStatic}/images/2.png"></a></div>
			<div class='col-sm-3'><a id="3" href="${ctx}/assess/dbJob/list"><img src="${ctxStatic}/images/3.png"></a></div>
		</div>
		<div class='col-sm-12'>
			<div class='col-sm-3'><a id="4" href="${ctx}/assess/dbQuestionnaireSurvey/" ><img src="${ctxStatic}/images/4.png"></a></div>
			<div class='col-sm-3'><a id="5" href="${ctx}/assess/dbJobSelf/list"><img src="${ctxStatic}/images/5.png"></a></div>
			<div class='col-sm-3'><a id="6" href="${ctx}/assess/dbJob/list"><img src="${ctxStatic}/images/6.png"></a></div>
		</div>	
	</div>
</div>

</body>
</html>