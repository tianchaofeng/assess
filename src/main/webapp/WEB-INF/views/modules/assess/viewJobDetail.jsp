<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务统计详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="viewJob" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">任务名称：</label>
			<div class="controls">
				<label class="lbl">${viewJob.job}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学科：</label>
			<div class="controls">
				<label class="lbl">${viewJob.course}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">教师：</label>
			<div class="controls">
				<label class="lbl">${viewJob.teacher}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区域：</label>
			<div class="controls">
				<label class="lbl">${viewJob.area}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学校：</label>
			<div class="controls">
				<label class="lbl">${viewJob.school}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考评开始时间：</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${viewJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考评结束时间：</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${viewJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分数：</label>
			<div class="controls">
				<label class="lbl">${viewJob.score}</label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>