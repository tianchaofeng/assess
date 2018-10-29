<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评分</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
	 <%-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
	  <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
	<link href="${ctxStatic}/bootstrap/star/star-rating.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/bootstrap/star/star-rating.min.js" type="text/javascript"></script>
	<link href="https://cdn.bootcss.com/bootstrap-star-rating/4.0.2/css/star-rating.min.css" rel="stylesheet">
	 <script src="https://cdn.bootcss.com/bootstrap-star-rating/4.0.2/js/star-rating.min.js"></script> --%>
	<style type="text/css">
	.caption span{
    		display:none;
    	}
	.tablist_top li{ display: inline-block;width: 23%;text-align: center;border:1px solid #333:border-right:none}
			.table{
				margin:0;
				table-layout:fixed
			}
			.table tr td{
				/*width: 24%;*/
				word-wrap:break-word;
				text-align: center;
			}
			.icon-th-list{
				display:none
			}
			
	/* 文字超出长度用省略号代替
	 * title 鼠标悬浮显示所有文字
	 */
	#contentTable { table-layout: fixed;}
	.remarks1 {
	    overflow:hidden;
	    white-space:nowrap;
	    text-overflow:ellipsis;
	    -o-text-overflow:ellipsis;
	    -moz-text-overflow: ellipsis;
	    -webkit-text-overflow: ellipsis;
		}

@media print {
    /* body {transform: scale(.59);}
 	table {page-break-inside: avoid;}  */
			  a[href]:after {
			    content: none !important;
			  }
			  .noprint { 
			  	display: none;
			  } 
			}
	
</style>
	<style>html,body
{
    top:50px;
    border:50px;
   /*  transform: scale(.59); */
  /*   margin: 0;
    padding: 0;
    border: 0;
    overflow: hidden;
    height: 100%; */
}
		.table{
			font-size: 20px;
		}
</style>
	<script type="text/javascript">
	$(document).ready(function() {
		
		var type = ${fns:getUser().userType};
		if(type == '1'){
		    $(".td2").hide();
		} else {
			$(".td2").show();
			$(".td1").show();
		}
	});
	</script>
	<script>
    function iframePrint(){    //添加打印事件
      window.print();
    }
</script>
<!-- <style>html,body
{
    margin: 0;
    padding: 0;
    border: 0;
    overflow: hidden;
    height: 100%;
}</style> -->

</head>
<body id="jju"><%-- <c:forEach items="${dbLevelList1}" var="dbLevel1" varStatus="varStatus1">--%>
<%-- <ul id="yin" class="nav nav-tabs noprint">
		<li><a href="${ctx}/assess/dbJob/">任务创建列表</a></li>
		<shiro:hasPermission name="assess:dbJob:edit"><li class="active"><a href="${ctx}/assess/dbJob/table?id=${dbJob.id}">统计</a></li></shiro:hasPermission>
	</ul>
	</br>
	<ul id="yin1" class="nav nav-tabs noprint">
		<li class="active"><a href="${ctx}/assess/dbJob/table?id=${dbJob.id}">表格图</a></li>
		<li><a href="${ctx}/assess/dbJobSelf/echarts?jobid=${dbJob.id}">雷达统计图</a></li>
		<li><a href="${ctx}/assess/dbJobSelf/echartsy?jobid=${dbJob.id}">明细图表</a></li>
		<li><a href="${ctx}/assess/dbJob/comment?id=${dbJob.id}">评语明细</a></li>
		<!-- <li>
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print();"/>
		</li> -->
	</ul> --%>
				        	<table class="table table-bordered">
					         	<tr class="active">
					         		<td id="llk">一级</td>
					         		<td>二级</td>
					         		<td>评价指标</td>
									<td>评价要点</td>
									<c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus">
									<c:if test="${dbJobSelfList.participant.userType eq 1 }">
									<td class="td1">
									<a href="${ctx}/assess/dbJobSelf/exercise?id=${dbJobSelfList.id}" target="_blank">
									${dbJobSelfList.participant.name }</a></td>
									</c:if>
									<c:if test="${dbJobSelfList.participant.userType eq 2 }">
									<td class = "td2" >
									<a href="${ctx}/assess/dbJobSelf/exercise?id=${dbJobSelfList.id}" target="_blank">
									${dbJobSelfList.participant.name }</a></td>
									</c:if>
									</c:forEach>
									<td>平均分</td>
					         	</tr>
					         </table> 
					<c:forEach items="${dbLevelList1}" var="dbLevel1" varStatus="varStatus1">  
					 
			        <c:forEach items="${dbLevelList2}" var="dbLevel2" varStatus="varStatus2">
			        <c:if test="${dbLevel1.id eq dbLevel2.parent.id}">
				        <table class="table table-bordered"> 
				        	<c:if test=""></c:if>
				        	<tr>
							 	<td rowspan="${dbLevel2.def1+dbLevel2.def1 }" id="qq">${dbLevel1.name}</td>
							 	<td rowspan="${dbLevel2.def1+dbLevel2.def1 }" id="">${dbLevel2.name}</td>
					        	<c:forEach items="${dbLevelList3}" var="dbLevel3" varStatus="varStatus3">
					        	 <c:if test="${dbLevel2.id eq dbLevel3.parent.id}">
					        	 <c:if test="${dbLevel3.def1 eq 1}">
					        	  <tr>
							            <td rowspan="${dbLevel3.def1}">${dbLevel3.name}</td>
							        
						        	 <c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
						        	 <c:if test="${dbLevel4.levelId.id eq dbLevel3.id}">
							            <td>${dbLevel4.content }</td>
							            <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus5">
							            <c:forEach items="${dbJobSelfList.reJobSelefAssessList}" var="reJobSelefAssessList" varStatus="varStatus6">
								            	<c:if test="${reJobSelefAssessList.assessId.id eq dbLevel4.id}">
													<td class="td${dbJobSelfList.participant.userType}" >${reJobSelefAssessList.score }</td>
												</c:if>
											</c:forEach>
										</c:forEach>
							            <td>${dbLevel4.def4 }</td>
							        </c:if>
							        </c:forEach>
							       </tr> 
							       </c:if>
					        	 <c:if test="${dbLevel3.def1 ne 1}">
					        	  <tr>
							            <td rowspan="${dbLevel3.def1+1}">${dbLevel3.name}</td>
							        
						        	 <c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
						        	 <c:if test="${dbLevel4.levelId.id eq dbLevel3.id}">
							           <tr>
							            <td>${dbLevel4.content }</td>
							            	
							           <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus5">
							            	<c:forEach items="${dbJobSelfList.reJobSelefAssessList}" var="reJobSelefAssessList" varStatus="varStatus6">
								            	<c:if test="${reJobSelefAssessList.assessId.id eq dbLevel4.id}">
													<td class="td${dbJobSelfList.participant.userType}">${reJobSelefAssessList.score }</td>
												</c:if>
											</c:forEach>
									</c:forEach>
							            <td>${dbLevel4.def4 }</td>
							            </tr>
							        </c:if>
							        </c:forEach>
							       </tr> 
							       </c:if>
					        	</c:if>
					        </c:forEach> 
					        </tr>
					    </table>
					    
					   </c:if>
 			        </c:forEach>
			    	</c:forEach>
			<table class="table table-bordered">
					         	<tr>
					         		<td colspan="3"></td>
					         		<td>合计：</td>
					         		 <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus5">
					         		<td class="td${dbJobSelfList.participant.userType}">${dbJobSelfList.def1}</td>
					         		</c:forEach>
					         		<td>${average }</td>
					         	</tr>
					         </table> 
		   
	<%-- <table class="table table-bordered">
     	<tr class="active">
      		<td>一级</td>
      		<td>二级</td>
      		<td>三级</td>
			<td>评价要点</td>
			<td>评价人</td>
			<td>平均分</td>
    	</tr>
      	 <c:forEach items="${dbLevelList1}" var="dbLevel1" varStatus="varStatus1">
      	<tr>
			<td rowspan="${dbLevel1.def1 *dbLevel1.def1}">${dbLevel1.name}</td>
			     <c:forEach items="${dbLevelList2}" var="dbLevel2" varStatus="varStatus2">
				     <c:if test="${dbLevel1.id eq dbLevel2.parent.id}">
						<tr>
						<td rowspan="${dbLevel2.def1 +dbLevel2.def1}" id="">${dbLevel2.name}</td>
						<c:forEach items="${dbLevelList3}" var="dbLevel3" varStatus="varStatus3">
						<c:if test="${dbLevel2.id eq dbLevel3.parent.id}">
						<c:if test="${dbLevel3.def1 eq 1}">
					 		<tr>
								<td rowspan="${dbLevel3.def1}">${dbLevel3.name}</td>
					        	 <c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
						        	 <c:if test="${dbLevel4.levelId.id eq dbLevel3.id}">
							            <td>${dbLevel4.content }</td>
							            <td>
							            	${dbLevel4.def2 }
							            </td> 
							            <td><textarea ></textarea></td>
							        </c:if>
						        </c:forEach>
							</tr> 
						</c:if>
					    <c:if test="${dbLevel3.def1 ne 1}">
					        <tr>
							    <td rowspan="${dbLevel3.def1+dbLevel3.def1}">${dbLevel3.name}</td>
						        	 <c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
							        	 <c:if test="${dbLevel4.levelId.id eq dbLevel3.id}">
								            <tr>
								            <td>${dbLevel4.content }</td>
								            <td>
												${dbLevel4.def2 }
								            </td>
								            <td><input type="text"></td>
								            </tr>
								        </c:if>
							        </c:forEach>
							       </tr> 
							       </c:if>
					        	</c:if>
					        </c:forEach> 
					        </tr>
					    
					   </c:if>
			        </c:forEach>
			        </tr> 
			    	</c:forEach>
		</table> --%>
		
	<br><br><br><br>	
</body>
	 
</html>