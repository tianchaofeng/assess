<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评分</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
	 <link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet">
	  <script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
	<%-- <link href="${ctxStatic}/bootstrap/star/star-rating.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/bootstrap/star/star-rating.min.js" type="text/javascript"></script> --%>
	<link href="https://cdn.bootcss.com/bootstrap-star-rating/4.0.2/css/star-rating.min.css" rel="stylesheet">
	 <script src="https://cdn.bootcss.com/bootstrap-star-rating/4.0.2/js/star-rating.min.js"></script>
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
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
			bian("${dbJobSelf.id}");
			<c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
				if( ${not empty dbLevel4.def4}){
					$("#modal_btn${dbLevel4.id}").attr("class","btn btn-success btn-sm btn_margin");
				}
			</c:forEach>
			
		});
		function bian(a){
			var  ztpj= $("#remark"+a).val();
			if(ztpj != ''){
				$("#modal_btn"+a).attr("class","btn btn-success btn-sm btn_margin");
			}else{
				$("#modal_btn"+a).attr("class","btn btn-primary btn-sm btn_margin");
			}
		}
		function save(def2){
			var falg =false;
			 <c:forEach items="${dbLevelList4}" var="dbLevel4" varStatus="varStatus4">
				var a="#input-21b1"+${dbLevel4.def1 };	
			 	var b = $(a).val();
			 	if(b == '' || b == "0"){
			 		$(a).val(0);
			 		falg =true;
			 	}
			 </c:forEach>
			 if(falg){
				 var r=confirm("有评分项未评分，是否继续？");
				 if (r==true)
				   {
				  
				   }
				 else
				   {
				  return false;
				   }
			 }
			 $(".hhh").attr("disabled", true);  
			if(def2==1){
				$("#def2").val(1);
			}else{
				$("#def2").val(2);
			}
			$.ajax({
				type: "post",
				dataType: "json",
				data: $("#inputForm1").serialize(),
				async: false,
				cache: false,
				url: "${ctx}/assess/dbJobSelf/saveJobSelf",
				success: function(data) {
					if(data == true){
						window.close();//关闭窗口
						window.opener.location.reload(true);
					}else{
						alert("未保存成功！！！");
					}
				},
				error: function() {
					alert("系统内部错误！！！");
				}
			});
		}
		function close1(){
			window.close();
		}
		function checkLength(obj,id,maxlength){
		    if(obj.value.length > maxlength)
		    obj.value = obj.value.substring(0,maxlength);
		}
		
	</script>
	<script type="text/javascript">
		function open_win(urls) 
		{
			var url = urls.split("|");
			var size = url.length;
			if( size >0){
				/*   window.open(url[0],'_blank');
				  window.open(url[1],'_blank'); */
				  
		      for(var i = 0;i < size; i++) {
	            window.open(url[i],i+"/"+size);
		      } 
		}
		}
		</script>
</head>
<body>
<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/assess/dbJobSelf/list">个人任务列表</a></li>
		<li class="active"><a href="${ctx}/assess/dbJobSelf/exercise?id=${dbJobSelf.id}">评分</a></li>
	</ul><br/> --%>
	<%-- <table class="table table-bordered">
		<tr  class="active">
			<td>名称：${dbJobSelf.name }</td>
			<td>参考目标：${dbJobSelf.target.name }</td>
			<td>参评人：${dbJobSelf.participant.name }</td>
			<td>总分数：${score}分</td>
		</tr>
	</table> --%>
	<div class='container'>
		<div class='row'>
			<div class='col-sm-12'>
				<div class='Exam_title'>
					<p>课例名称：<span>${dbJobSelf.name }</span></p>
					<p>授课教师：<span>${dbJobSelf.target.name }</span></p>
					<p>参评人：<span>${dbJobSelf.participant.name }</span></p>
					<p>总分数：<span>${score}分</span></p>
					
					<c:if test="${def5 != null && def5 ne ''}">
					<button onclick="open_win('${def5 }')">查看教案</button>
					</c:if>
					<c:if test="${QuestionnaireSurvey eq 'have' }">
					<button onclick="location='${ctx}/assess/dbQuestionnaireSurvey/see?teacher=${dbJobSelf.target.id }'">查看问卷</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	
<form:form id="inputForm1" modelAttribute="dbJobSelf" action="${ctx}/assess/dbJobSelf/saveJobSelf" method="post" class="form-horizontal" >
	<input type="hidden" name="id" value="${dbJobSelf.id }"/>
	<input type="hidden" id = "def2" name="def2" value=""/>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
		    <div class="panel panel-default">
		    <c:forEach items="${dbLevelList1}" var="dbLevel1" varStatus="varStatus1">
			    <div role="tab" id="headingOne${dbLevel1.id}">
				    <h4 class="panel-title">
				      	<div class="table-responsive" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne${dbLevel1.id}" aria-expanded="true" aria-controls="collapseOne${dbLevel1.id}">
				        	<table class="table table-bordered">
					         	<tr class="active">
					         		<td>${dbLevel1.name}</td>
					         		<td>评价指标</td>
									<td>评价要点</td>
									<td>评价分数</td>
									<td>评语</td>
					         	</tr>
					         </table>
				        </div>
				    </h4>
				</div>
			    <div id="collapseOne${dbLevel1.id}" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne${dbLevel1.id}">
			        <c:forEach items="${dbLevelList2}" var="dbLevel2" varStatus="varStatus2">
			        <c:if test="${dbLevel1.id eq dbLevel2.parent.id}">
			        <div class="table-responsive">
				        <table class="table table-bordered"> 
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
							            <td>
							            	<%-- <c:forEach items="${fns:getDictList('score')}" var="a">
												<input type="radio" name="reJobSelefAssessList[${dbLevel4.def1 }].score" value="${fns:getDictValue(a,'score','')}"><span style="color: red">${a }</span>
											</c:forEach> --%>
							            	<input id="input-21b1${dbLevel4.def1 }" name="reJobSelefAssessList[${dbLevel4.def1 }].score"   value="${dbLevel4.def2 }" type="number" class="rating" min=0 max=5 step=0.5 data-size="xs">
							            </td>
							            <td>
							            	<%-- <button type="button" class="btn btn-primary" data-toggle="modal${dbLevel4.def1 }" data-target=".bs-example-modal-lg${dbLevel4.def1 }">评论</button> --%>
							            		<a class="btn btn-primary btn-sm btn_margin" data-toggle="modal" id="modal_btn${dbLevel4.id}" data-target="#myModal${dbLevel4.def1}">评论</a>
							            </td>
							            <div class="modal fade" id="myModal${dbLevel4.def1}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" id="clo${dbLevel4.def1}" class="close" data-dismiss="modal" aria-hidden="true">
															&times;
														</button>
													       <textarea title="最多输入50字" onpropertychange="checkLength(this,'${dbLevel4.id }',50);" oninput="checkLength(this,'${dbLevel4.id }',50);" id="remark${dbLevel4.id }" name="reJobSelefAssessList[${dbLevel4.def1 }].remarks"  class="form-control" rows="10" placeholder="请输入您的评论信息……">${dbLevel4.def4 }</textarea>
													    <div class="modal-footer">
													        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="bian('${dbLevel4.id }')">确定</button>
													    </div>
													</div>
												</div>
											</div>
										</div>
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
						        	 <input type="hidden" name="reJobSelefAssessList[${dbLevel4.def1 }].assessId.id" value="${dbLevel4.id }"/>
						        	 <input type="hidden" name="reJobSelefAssessList[${dbLevel4.def1 }].id" value="${dbLevel4.def3 }"/>
							            <td title="${dbLevel4.remarks }">${dbLevel4.content }</td>
							            <td>
							            	<%-- <c:forEach items="${fns:getDictList('score')}" var="a">
												<input type="radio" name="reJobSelefAssessList[${dbLevel4.def1 }].score" value="${fns:getDictValue(a,'score','')}"><span style="color: red">${a }</span>
											</c:forEach> --%>
											<input id="input-21b1${dbLevel4.def1 }" name="reJobSelefAssessList[${dbLevel4.def1 }].score"   value="${dbLevel4.def2 }" type="number" class="rating" min=0 max=5 step=0.5 data-size="xs">
							            	
							            </td>
							            
							            <td>
							            	<%-- <button type="button" class="btn btn-primary" data-toggle="modal${dbLevel4.def1 }" data-target=".bs-example-modal-lg${dbLevel4.def1 }">评论</button> --%>
							            	<a class="btn btn-primary btn-sm btn_margin" data-toggle="modal" id="modal_btn${dbLevel4.id}" data-target="#myModal${dbLevel4.def1}">评论</a>
							            </td>
							            <div class="modal fade" id="myModal${dbLevel4.def1}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" id="clo${dbLevel4.def1}" class="close" data-dismiss="modal" aria-hidden="true">
															&times;
														</button>
													       <textarea  title="最多输入50字" onpropertychange="checkLength(this,'${dbLevel4.id }',50);" oninput="checkLength(this,'${dbLevel4.id }',50);" id="remark${dbLevel4.id }" name="reJobSelefAssessList[${dbLevel4.def1 }].remarks"  class="form-control" rows="10" placeholder="请输入您的评论信息……">${dbLevel4.def4 }</textarea>
													    <div class="modal-footer">
													        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="bian('${dbLevel4.id }')">确定</button>
													    </div>
													</div>
												</div>
											</div>
										</div>
							            </tr>
							        </c:if>
							        </c:forEach>
							       </tr> 
							       </c:if>
					        	</c:if>
					        </c:forEach> 
					        </tr> 
					    </table>
					    
			        </div>
					   </c:if>
			        </c:forEach>
			    </div>
			    	</c:forEach>
			</div>
			
		</div>
		
		<div class="modal fade" id="myModal${dbJobSelf.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
					       <textarea  title="最多输入200字" onpropertychange="checkLength(this,'${dbJobSelf.id}',200);" oninput="checkLength(this,'${dbJobSelf.id}',200);" id="remark${dbJobSelf.id}" name="remarks"  class="form-control" rows="10" placeholder="请输入您的评论信息……">${dbJobSelf.remarks }</textarea>
					    <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal"  onclick="bian('${dbJobSelf.id}')">确定</button>
					    </div>
					</div>
				</div>
			</div>
		</div>
		 <td>
			<a class="btn btn-primary btn-sm btn_margin" data-toggle="modal" id="modal_btn${dbJobSelf.id}" data-target="#myModal${dbJobSelf.id}">整体评价</a>
		</td>
		
			<shiro:hasPermission name="assess:dbJobSelf:edit">
			<c:choose>
			    <c:when test="${fns:getUser().id eq dbJobSelf.participant && dbJobSelf.def2 eq 1}">
			     <input id="btnSubmit" class="btn btn-primary hhh" type="button" onclick="save('1')" value="保 存"/>&nbsp;
				 <input id="btnSubmit" class="btn btn-primary hhh"  type="button" onclick="save('2')" value="提交"/>&nbsp;
			    </c:when>
			    <c:when test="${fns:getUser().id eq dbJobSelf.participant && empty dbJobSelf.def2}">
			      <input id="btnSubmit" class="btn btn-primary hhh" type="button" onclick="save('1')" value="保 存"/>&nbsp;
				  <input id="btnSubmit" class="btn btn-primary hhh"  type="button" onclick="save('2')" value="提交"/>&nbsp;
			    </c:when>  
			     
			   <c:otherwise>  
			      <a class="btn btn-primary btn-sm btn_margin disabled" ><!-- <p style="font-weight: bolder;"> -->该任务已无法保存或提交<!-- </p> --></a>
			   </c:otherwise>
			  </c:choose>
			
			</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-primary pull-right" type="button" value="返 回" onclick="close1()"/>
		
		</form:form>
</body>
	 
</html>