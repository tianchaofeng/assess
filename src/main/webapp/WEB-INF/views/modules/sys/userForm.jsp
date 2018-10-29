<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			if("${user.userType}"=="2"){
				$("#SchoolId").hide();
				$("#userGradeId").hide();
				$("#courseId1").hide();
				$("#jobTitle1").hide();
			}
			
			
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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
		
		function getSchool(){
			
			var companyId =  $("#companyId").val();
			src = "${ctx}/sys/office/reference?type=2";
			if(companyId==undefined){
				alert("请先选择区域");
			}else{
				
				jBox.open(
				        "iframe:"+src,
				        "选择学校", 820, 420, 
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
									$("#officeId").val(ids.join(",").replace(/u_/ig,""));
									$("#officeName").val(names.join(",").replace(/\s/g,""));
				        		}
				            }
				        }
					);
			}
			
		}
		
		
		
	</script>
	
	
	<script type="text/javascript">
	
		function hideShow(vv){
			if(vv=="1"){//教师
				$("#SchoolId").show();
				$("#userGradeId").show();
				$("#courseId1").show();
				$("#jobTitle1").show();
				
			}else if(vv=="2"){ //评分着
				$("#SchoolId").hide();
				$("#officeId").val("");
				$("#userGradeId").hide();
				$("#userGradeId1").val("");
				$("#courseId1").hide();
				$("#course").val("");
				$("#jobTitle1").hide();
				$("#jobTitle").val("");
				
			}
		}
	</script>
</head>
<body class="no-skin">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/user/list">用户列表</a></li>
		<li class="active"><a href="${ctx}/sys/user/form?id=${user.id}">用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">头像:</label>
			<div class="controls">
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">用户类型:</label>
			<div class="controls">
				<form:select path="userType" class="input-xlarge required" onchange="hideShow(this.value)">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"  />
				</form:select>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">归属区域:</label>
			<div class="controls">
                <sys:gridselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
					title="区域" url="/sys/office/reference?type=1" cssClass="required"/>
			</div>
		</div>
		<div class="control-group" id="SchoolId">
			<label class="control-label">归属学校:</label>
			<div class="controls">
					<form:input path="office.id" id="officeId"  type="hidden" />
					<form:input path="office.name" id="officeName"  onclick="getSchool()"/>
			</div>
		</div>
		
		<div class="control-group" id="userGradeId">
			<label class="control-label">用户等级:</label>
			<div class="controls">
				<form:select path="userGrade" id="userGradeId1" class="input-xlarge">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('user_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		
		<div class="control-group" id="courseId1">
			<label class="control-label" >学科:</label>
			<div class="controls">
				<sys:gridselect id="course" name="course.id" value="${user.course.id}" labelName="course.name" labelValue="${user.course.name}"
					title="学科" url="/assess/dbCourseinfo/reference" cssClass="required"/>
			</div>
		</div>
		<div class="control-group" id="jobTitle1">
			<label class="control-label" >职称:</label>
			<div class="controls">
				<form:select path="jobTitle" id="jobTitle" class="input-xlarge">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('job_title')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		
		<%-- <div class="control-group">
			<label class="control-label">工号:</label>
			<div class="controls">
				<form:input path="no" htmlEscape="false" maxlength="50" class="required"/>
				
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
				<c:if test="${not empty user.id}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="100" class="email"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否允许登录:</label>
			<div class="controls">
				<form:select path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
			</div>
		</div>
		
		
		<div class="control-group">
			<label class="control-label">用户角色:</label>
			<div class="controls">
				<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="control-group">
				<label class="control-label">创建时间:</label>
				<div class="controls">
					<label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">最后登陆:</label>
				<div class="controls">
					<label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-default" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>