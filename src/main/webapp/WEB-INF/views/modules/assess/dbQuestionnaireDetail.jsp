<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评课工具详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="dbQuestionnaire" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">评课工具名称：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.name}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">score：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.score}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<label class="lbl">${fns:unescapeHtml(dbQuestionnaire.remarks)}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义1：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.def1}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义2：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.def2}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义3：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.def3}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义4：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.def4}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义5：</label>
			<div class="controls">
				<label class="lbl">${dbQuestionnaire.def5}</label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>