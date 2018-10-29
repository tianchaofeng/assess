<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
	<style type="text/css">
		label{
			color:#000000;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/info">个人信息</a></li>
		<li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post" class="form-horizontal"><%--
		<form:hidden path="email" htmlEscape="false" maxlength="255" class="input-xlarge"/>
		<sys:ckfinder input="email" type="files" uploadPath="/mytask" selectMultiple="false"/> --%>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">头像:</label>
			<div class="col-sm-9">
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属区域:</label>
			<div class="col-sm-9">
				<label class="lbl">${user.company.name}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属学校:</label>
			<div class="col-sm-9">
				<label class="lbl">${user.office.name}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">姓名:</label>
			<div class="col-sm-9">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required input-lg" readonly="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">邮箱:</label>
			<div class="col-sm-9">
				<form:input path="email" htmlEscape="false" maxlength="50" class="email input-lg"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">电话:</label>
			<div class="col-sm-9">
				<form:input path="phone" htmlEscape="false" maxlength="50" class="input-lg"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">手机:</label>
			<div class="col-sm-9">
				<form:input path="mobile" htmlEscape="false" maxlength="50" class="input-lg"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-9">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户类型:</label>
			<div class="col-sm-9">
				<label class="lbl">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</label>
			</div>
		</div>
		<c:if test="${user.userType eq 1 }">
			
			<div class="form-group">
				<label class="col-sm-2 control-label">学科:</label>
				<div class="col-sm-9">
					<label class="lbl">${user.course.name}</label>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">职称:</label>
				<div class="col-sm-9">
					<label class="lbl">${fns:getDictLabel(user.jobTitle, 'job_title', '无')}</label>
				</div>
			</div>
		</c:if>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户角色:</label>
			<div class="col-sm-9">
				<label class="lbl">${user.roleNames}</label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">上次登录:</label>
			<div class="col-sm-9">
				<label class="lbl">IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
		</div>
	</form:form>
</body>
</html>