<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评分</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
	<style type="text/css">
	.icon-th-list{
		display:none
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
   /*  body {transform: scale(.59);}
 	table {page-break-inside: avoid;} */
			  a[href]:after {
			    content: none !important;
			  }
			  .noprint { 
			  	display: none;
			  } 
			}


	.table{
		font-size: 20px;
	}
	</style>
	
</head>
<script>
    function iframePrint(){    //添加打印事件
      window.print();
    }
</script>
<style>html,body
{
    top:50px;
    border:50px;
    
  /*   margin: 0;
    padding: 0;
    border: 0;
    overflow: hidden;
    height: 100%; */
}</style>
<body>
	<%-- <ul class="nav nav-tabs noprint">
		<li><a href="${ctx}/assess/dbJob/">任务创建列表</a></li>
		<shiro:hasPermission name="assess:dbJob:edit"><li class="active"><a href="${ctx}/assess/dbJob/table?id=${dbJob.id}">统计</a></li></shiro:hasPermission>
	</ul>
	</br>
	<ul class="nav nav-tabs noprint">
		<li><a href="${ctx}/assess/dbJob/table?id=${dbJob.id}">表格图</a></li>
		<li><a href="${ctx}/assess/dbJobSelf/echarts?jobid=${dbJob.id}">雷达统计图</a></li>
		<li><a href="${ctx}/assess/dbJobSelf/echartsy?jobid=${dbJob.id}">明细图表</a></li>
		<li  class="active"><a href="${ctx}/assess/dbJob/comment?id=${dbJob.id}">评语明细</a></li>
		<!-- <li>
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print();"/>
		</li> -->
	</ul> --%>
<!-- <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
		    <div class="panel panel-default"> -->
		    <c:forEach items="${dbLevelList1}" var="dbLevel1" varStatus="varStatus1">
			   <%--  <div role="tab" id="headingOne${dbLevel1.id}">
				    <h4 class="panel-title">
				      	<div class="table-responsive" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne${dbLevel1.id}" aria-expanded="true" aria-controls="collapseOne${dbLevel1.id}"> --%>
				        	<table class="table table-bordered">
					         	<tr class="active">
					         		<td>${dbLevel1.name}</td>
					         		<td>评价指标</td>
									<td>评价要点</td>
									<%-- <c:choose>
									    <c:when test="${varStatus1.first}"> --%>
									     <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatuss">
										
											<td id="${dbJobSelfList.participant.id }">
											<%-- <a href="${ctx}/assess/dbJobSelf/exercise?id=${dbJobSelfList.id}" target="_blank"> --%>
											评语（${dbJobSelfList.participant.name }）
											<!-- </a> -->
											</td>
									</c:forEach>
									    <%-- </c:when>
									   <c:otherwise> 
									    <td  colspan="${fn:length(dbLevelList1)}"></td>
									   </c:otherwise>
									  </c:choose> --%>
									
					         	</tr>
					         </table>
				        <%-- </div>
				    </h4>
				</div>
			    <div id="collapseOne${dbLevel1.id}" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne${dbLevel1.id}"> --%>
			        <c:forEach items="${dbLevelList2}" var="dbLevel2" varStatus="varStatus2">
			        <c:if test="${dbLevel1.id eq dbLevel2.parent.id}">
			       <!--  <div class="table-responsive"> -->
				        <table id="contentTable" class="table table-bordered"> 
				        	<tr>
							 	<td rowspan="${dbLevel2.def1+dbLevel2.def1 }" id="">${dbLevel2.name}</td>
					        	<c:forEach items="${dbLevelList3}" var="dbLevel3" varStatus="varStatus3">
					        	 <c:if test="${dbLevel2.id eq dbLevel3.parent.id}">
					        	 <c:if test="${dbLevel3.def1 eq 1}">
					        	  <tr>
							            <td rowspan="${dbLevel3.def1}">${dbLevel3.name}</td>
							        
						        	 <c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
						        	 <c:if test="${dbLevel4.levelId.id eq dbLevel3.id}">
						        	 <input type="hidden" name="reJobSelefAssessList[${dbLevel4.def1 }].assessId.id" value="${dbLevel4.id }"/>
						        	 <input type="hidden" name="reJobSelefAssessList[${dbLevel4.def1 }].id" value="${dbLevel4.def3 }"/>
							            <td title="${dbLevel4.remarks }">${dbLevel4.content }</td>
							            <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus5">
							            <c:forEach items="${dbJobSelfList.reJobSelefAssessList}" var="reJobSelefAssessList" varStatus="varStatus6">
								            	<c:if test="${reJobSelefAssessList.assessId.id eq dbLevel4.id}">
													<td class="remarks1" title="${reJobSelefAssessList.remarks}">${reJobSelefAssessList.remarks }</td>
												</c:if>
											</c:forEach>
										</c:forEach>
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
							            <td title="${dbLevel4.remarks }">${dbLevel4.content }</td>
							             <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus5">
							            <c:forEach items="${dbJobSelfList.reJobSelefAssessList}" var="reJobSelefAssessList" varStatus="varStatus6">
								            	<c:if test="${reJobSelefAssessList.assessId.id eq dbLevel4.id}">
													<td class="remarks1" title="${reJobSelefAssessList.remarks}">${reJobSelefAssessList.remarks }</td>
												</c:if>
											</c:forEach>
										</c:forEach>
							            </tr>
							        </c:if>
							        </c:forEach>
							       </tr> 
							       </c:if>
					        	</c:if>
					        </c:forEach> 
					        </tr> 
					    </table>
					    
			     <!--    </div> -->
					   </c:if>
			        </c:forEach>
			   <!--  </div> -->
			    	</c:forEach>
			    	<table class= "table table-bordered">
			    		<tr class="active">
			    			<td colspan="2"></td>
			         		<td>整体评语：</td>
			         		 <c:forEach items="${dbJobSelfList}" var="dbJobSelfList" varStatus="varStatus5">
			         		<td>${dbJobSelfList.remarks}</td>
			         		</c:forEach>
			    		</tr>
			    	</table>
			    	<br><br><br>
			<!-- </div>
			
		</div> -->
		
		
</body>
	 
</html>