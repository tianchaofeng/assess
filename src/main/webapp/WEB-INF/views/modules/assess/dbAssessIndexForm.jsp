<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价指标管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/assess/dbAssessIndex/list">评价指标列表</a></li>
		<li class="active"><a href="${ctx}/assess/dbAssessIndex/form?id=${dbAssessIndex.id}">评价指标<shiro:hasPermission name="assess:dbAssessIndex:edit">${not empty dbAssessIndex.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="assess:dbAssessIndex:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dbAssessIndex" action="${ctx}/assess/dbAssessIndex/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">评价指标：</label>
			<div class="controls">
				<%-- <form:input path="levelId" htmlEscape="false" maxlength="64" class="input-xlarge "/> --%>
				<sys:treeselect id="levelId" name="levelId.id" value="${dbAssessIndex.levelId.id}" labelName="levelId.name" labelValue="${dbAssessIndex.levelId.name}"
					title="父级名称" url="/assess/dbLevel/treeData"  cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评分要点：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="64" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">自定义1：</label>
			<div class="controls">
				<form:input path="def1" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义2：</label>
			<div class="controls">
				<form:input path="def2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义3：</label>
			<div class="controls">
				<form:input path="def3" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义4：</label>
			<div class="controls">
				<form:input path="def4" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义5：</label>
			<div class="controls">
				<form:input path="def5" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="assess:dbAssessIndex:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>