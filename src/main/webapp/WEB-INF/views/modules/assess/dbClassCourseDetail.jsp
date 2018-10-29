<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级课程信息详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="dbClassCourse" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">版本：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.version}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">年级：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.grade}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学科：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.discipline}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上下册：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.ce}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单元：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.bookunit}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<label class="lbl">${fns:unescapeHtml(dbClassCourse.remarks)}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义1：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.def1}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义2：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.def2}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义3：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.def3}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义4：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.def4}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义5：</label>
			<div class="controls">
				<label class="lbl">${dbClassCourse.def5}</label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>