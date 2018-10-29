<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务创建详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
	if("${dbJob.type}"=="0"){
		$("#uyt").show();
		$("#nnnn").show();
		$("#er").hide();
	}else{
		$("#uyt").hide();
		$("#er").show();
	}
	$("#uyt").show();
	$("#nnnn").show();
    $("#er").hide();
	if("${dbJob.id}"!=""){
		 $("#chapter").empty();
		var data=${fns:toJson(dbClassCourse.dbList)};
		var opt = "<option value=''></option>";
		 for(var i=0;i<data.length;i++){
			 if("${dbJob.chapter}"==data[i].id){
				 opt += "<option value='"+data[i].id+"'selected='selected'>" +data[i].chapter + "</option>"
			 }else{ 
				 opt += "<option value='"+data[i].id+"'>" +data[i].chapter + "</option>"
			 } 
		 }
		 document.getElementById("chapter").innerHTML = opt;
	}
	});
	
	function gettarg(){
		var type = $("#typeId").val();
		src = "${ctx}/sys/user/reference";
		src+="?type=1";
		jBox.open(
		        "iframe:"+src,
		        "选择授课教师", 820, 420, 
		        {buttons: {'确定': "ok",'关闭': "cancel"}, iframeScrolling: 'yes', showClose: true,
		        	submit:function (v,h,f){
		        		if(v=="ok"){ 
		        			var table =h.find("iframe")[0].contentWindow.$("#contentTable");
							var ids = [], names = []
							h.find("iframe")[0].contentWindow.$("input[name=id]").each(function(i){
								if($(this).is(':checked')) {
									ids.push($(this).val());
									names.push(table.find("tr").eq(i+1).find("td").eq(1).text());
								}
							});
							$("#evaluationTargetId").val(ids.join(",").replace(/u_/ig,""));
							$("#evaluationTargetName").val(names.join(",").replace(/\s/g,""));
		        		}
		            }
		        }
			);
	}
	
	function hideShow(v){
		if(v=="0"){//评分者评价老师
			$("#uyt").show();
			$("#nnnn").show();
		    $("#er").hide();
		}else{
			$("#uyt").hide();
			$("#nnnn").hide();
			$("#er").show();
			$("#teamIdId").val("");
			
		}
	}
	
	
	function sad(){
		var type = $("#typeId").val();
		src = "${ctx}/sys/user/reference";
		if(type==undefined){
			alert("请先选择考评类型");
		}else if(type=="1"){//教师评价评分者
			src+="?type=1";
			jBox.open(
			        "iframe:"+src,
			        "选择参评人", 820, 420, 
			        {buttons: {'确定': "ok",'关闭': "cancel"}, iframeScrolling: 'yes', showClose: true,
			        	submit:function (v,h,f){
			        		if(v=="ok"){ 
			        			var table =h.find("iframe")[0].contentWindow.$("#contentTable");
								var ids = [], names = []
								h.find("iframe")[0].contentWindow.$("input[name=id]").each(function(i){
									if($(this).is(':checked')) {
										ids.push($(this).val());
										names.push(table.find("tr").eq(i+1).find("td").eq(1).text());
									}
								});
								$("#participantId").val(ids.join(",").replace(/u_/ig,""));
								$("#participantName").val(names.join(",").replace(/\s/g,""));
			        		}
			            }
			        }
				);
		}
	}
	
	function outof(id){
		
		$.post('${ctx}/assess/dbClassCourse/getById', {ids:id}, function(data) {
	    	 $("#version").val(data.version);
			 $("#grade").val(data.grade);
			 $("#discipline").val(data.discipline);
			 $("#ce").val(data.ce);
			 $("#bookunit").val(data.bookunit);
			 $("#chapter").empty();
			 var opt = "<option value=''></option>";
			 for(var i=0;i<data.dbList.length;i++){
				 var cc=data.dbList;
				 opt += "<option value='"+cc[i]+"'>" +cc[i] + "</option>"
			 }
			 document.getElementById("chapter").innerHTML = opt;
			 
			 
			}, 'JSON');
	}
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="dbJob" action="${ctx}/assess/dbJob/teacheingPlan" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id  ="def3"  path="def3"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">课例名称：</label>
			<div class="controls">
			    <c:if test="${empty dbJob.id}">
					<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			    </c:if>
			    <c:if test="${not empty dbJob.id}">
					<form:input path="name" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge required"/>
			    </c:if>
			    <span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考评类型：</label>
			<div class="controls">
			  <%--   <c:if test="${empty dbJob.id}">
				<form:select path="type" id="typeId" cssStyle="width:150px" onchange="hideShow(this.value)">
				    <form:option value=""></form:option>
				    <form:options items="${fns:getDictList('grade_type')}" itemLabel="label" itemValue="value" htmlEscape="false" cssClass="required"/>
				</form:select>
			    </c:if>
			    <c:if test="${not empty dbJob.id}">
				<form:select path="type" id="typeId" cssStyle="width:150px" disabled="true" onchange="hideShow(this.value)">
				    <form:option value=""></form:option>
				    <form:options items="${fns:getDictList('grade_type')}" itemLabel="label" itemValue="value" htmlEscape="false" cssClass="required"/>
				</form:select>
			    </c:if> 
				<span class="help-inline"><font color="red">*</font> </span>--%>
				<input readonly="readonly" value="${fns:getDictLabel('0','grade_type','')}" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评课工具：</label>
			<div class="controls">
			   <c:if test="${empty dbJob.id}">
				<sys:gridselect id="questionnaireId" name="questionnaireId.id" value="${dbJob.questionnaireId.id}" labelName="questionnaireId.name" labelValue="${dbJob.questionnaireId.name}"
					title="评课工具" url="/assess/dbQuestionnaire/reference" cssClass="required"/>
			    </c:if>
			    <c:if test="${not empty dbJob.id}">
				<sys:gridselect id="questionnaireId" disabled="disabled" name="questionnaireId.id" value="${dbJob.questionnaireId.id}" labelName="questionnaireId.name" labelValue="${dbJob.questionnaireId.name}"
					title="评课工具" url="/assess/dbQuestionnaire/reference" cssClass="required"/>
			    </c:if>
			<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">授课教师：</label>
			<div class="controls">
				<form:input path="evaluationTarget.id" id="evaluationTargetId" type="hidden" />
				<form:input path="evaluationTarget.name" id="evaluationTargetName" htmlEscape="false" maxlength="64" class="input-xlarge required" onclick="gettarg()" disabled="true"/>
			</div>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		<div class="control-group" id="uyt">
			<label class="control-label">评课小组：</label>
			<div class="controls">
			    <c:if test="${empty dbJob.id}">
					<sys:gridselect id="teamId" name="teamId.id" value="${dbJob.teamId.id}" labelName="teamId.name" labelValue="${dbJob.teamId.name}"
							title="选择小组" url="/assess/dbEvaluatingTeam/reference" cssClass="required"/>
			    </c:if>
			    <c:if test="${not empty dbJob.id}">
					<sys:gridselect id="teamId" name="teamId.id" disabled="disabled" value="${dbJob.teamId.id}" labelName="teamId.name" labelValue="${dbJob.teamId.name}"
							title="选择小组" url="/assess/dbEvaluatingTeam/reference" cssClass="required"/>
			    </c:if>
			</div>
		</div>
		
		<div id="nnnn" style="display: none;">
		
		<div class="control-group">
			<label class="control-label">学科：</label>
			<div class="controls">
		      <sys:gridselect id="discipline" name="discipline.id" value="${dbJob.discipline.id}" labelName="discipline.def1" labelValue="${dbJob.discipline.def1}"
					title="学科" url="/assess/dbClassCourse/reference" cssClass="required" onchange="outof(this.value)" disabled="disabled"/>
			</div>
		</div>
		
		<c:if test="${empty dbJob.id }">
		<div class="control-group" >
			<label class="control-label">班级信息：</label>
			<div class="controls">
			 <form:input path="grade" id="grade" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge required"/>
			 </div>
		</div>
		<div class="control-group">
			<label class="control-label">版本：</label>
			<div class="controls">
				<form:input path="version" id="version" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上下册：</label>
			<div class="controls">
				<form:input path="ce" id="ce" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		</c:if>
		<c:if test="${not empty dbJob.id }">
		<div class="control-group" >
			<label class="control-label">班级信息：</label>
			<div class="controls">
			 <input name="grade" id="grade" value="${fns:getDictLabel(dbJob.grade,'student_grade','') }" readonly="true" maxlength="64" class="input-xlarge required"/>
			 </div>
		</div>
		<div class="control-group">
			<label class="control-label">版本：</label>
			<div class="controls">
				<input name="version" value="${fns:getDictLabel(dbJob.version,'book_version','') }" id="version"  readonly="true" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上下册：</label>
			<div class="controls">
				<input name="ce" id="ce" value="${fns:getDictLabel(dbJob.ce,'up_down','') }" readonly="true" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		</c:if>
		
		<div class="control-group">
			<label class="control-label">单元：</label>
			<div class="controls">
				<form:input path="bookunit" id="bookunit" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">章节：</label>
			<div class="controls">
				<form:input path="chapter" id="chapter" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge required"/>
			</div>
			<!-- <div class="controls">
			    <select id="chapter" name="chapter" style="width: 150px" disabled="true">
			    </select>
			</div> -->
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">教案:</label>
			   <c:if test="${dbJob.evaluationTarget.id eq fns:getUser().id}">
			<div class="col-sm-9">
				<form:hidden id="teacheing_plan" path="def5" htmlEscape="false" maxlength="255" class="form-control"/>
				<sys:ckfinder  input="teacheing_plan" type="files" uploadPath="/files" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
			    </c:if>
			   <c:if test="${dbJob.evaluationTarget.id ne fns:getUser().id}">
			<div class="col-sm-9">
				<form:hidden id="teacheing_plan" path="def5" htmlEscape="false" maxlength="255" class="form-control"/>
				<sys:ckfinder  readonly="true" input="teacheing_plan" type="files" uploadPath="/files" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
			</c:if>
		</div>
		</div>
		
		<div class="control-group" id="er">
			<label class="control-label">参评人：</label>
			<div class="controls">
				<form:input path="participantId.id" id="participantId" type="hidden"/>
				<form:input path="participantId.name" id="participantName" htmlEscape="false" maxlength="64" class="input-xlarge required " onclick="sad()"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考评开始时间：</label>
			<div class="controls">
				<c:if test="${empty dbJob.id}">
					<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${dbJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			    </c:if>
			    <c:if test="${not empty dbJob.id}">
					<input name="startDate" type="text" disabled="disabled" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${dbJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			    </c:if>
			<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考评结束时间：</label>
			<div class="controls">
				<c:if test="${empty dbJob.id}">
					<input name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${dbJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			    </c:if>
			    <c:if test="${not empty dbJob.id}">
					<input name="endDate" type="text" disabled="disabled" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${dbJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			    </c:if>
			<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="64" class="input-xxlarge " disabled="true"/>
			</div>
		</div>
		<div class="form-actions">
		    <c:if test="${dbJob.evaluationTarget.id eq fns:getUser().id}">
		    <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
		    </c:if>
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>