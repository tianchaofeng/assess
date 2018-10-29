<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价指标详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="dbAssessIndex" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">一级：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.oneLevel}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">二级：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.twoLevel}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">三级：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.thereLevel}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">内容：</label>
			<div class="controls">
				<label class="lbl">${fns:unescapeHtml(dbAssessIndex.content)}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<label class="lbl">${fns:unescapeHtml(dbAssessIndex.remarks)}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义1：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.def1}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义2：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.def2}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义3：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.def3}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义4：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.def4}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义5：</label>
			<div class="controls">
				<label class="lbl">${dbAssessIndex.def5}</label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>