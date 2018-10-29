<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价小组详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="dbEvaluatingTeam" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.name}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">小组长：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.temaHeader}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<label class="lbl">${fns:unescapeHtml(dbEvaluatingTeam.remarks)}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义1：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.def1}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义2：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.def2}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义3：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.def3}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义4：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.def4}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义5：</label>
			<div class="controls">
				<label class="lbl">${dbEvaluatingTeam.def5}</label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>