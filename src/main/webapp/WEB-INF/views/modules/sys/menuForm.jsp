\<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
		var smstemplateidentifier =	document.getElementById("smstemplateidentifier");
		if(smstemplateidentifier.value != ""){
			smstemplateidentifier.setAttribute('disabled',true);
		}	
		});
		
		function theonly(stef){
			if(stef != ""){
			 $.ajax({
	    		 url:'${ctx}/sys/menu/getBysmsidentifier?identifier='+stef,
	    		 type:'GET',
	    		 dataType:'TEXT',
	    		 success:function(data){
	    			 if(data == "NO"){
	    				document.getElementById("smsidentifier").innerText="该标识已被占用！";
	    				document.getElementById("btnSubmit").setAttribute('disabled',true);
	    			 }else{
	    				 document.getElementById("smsidentifier").innerText="*";
	    				 document.getElementById("btnSubmit").removeAttribute('disabled');
	    			 }
	    		 },
	    		 error:function(XMLHttpRequest, textStatus, errorThrown){
	    		 }
	    	 });
			}else{
				document.getElementById("smsidentifier").innerText="*";
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/menu/">菜单列表</a></li>
		<li class="active"><a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">菜单<shiro:hasPermission name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级菜单:</label>
			<div class="controls">
                <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
					title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">短信模板选择:</label>
			<div class="controls">
			   <sys:gridselect id="smstemplateid" name="smstemplateid" value="${recordMessageTemplate.id}" labelName="recordMessageTemplate.id" labelValue="${recordMessageTemplate.id}"
					title="短信模板选择" url="/mclms/recordMessageTemplate/reference"  cssStyle="width:150px"                                              
					allowClear="true" cssClass="" notAllowSelectParent="true" />	
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">短信注解标识:</label>
			<div class="controls">
				<form:input path="smstemplateidentifier" id="smstemplateidentifier" htmlEscape="false" maxlength="50" onblur="theonly(this.value)"  class="required input-xlarge"/>
				<span class="help-inline"><font id="smsidentifier" color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required input-xlarge"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">链接:</label>
			<div class="controls">
				<form:input path="href" htmlEscape="false" maxlength="2000" class="input-xxlarge"/>
				<span class="help-inline">点击菜单跳转的页面</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标:</label>
			<div class="controls">
				<form:input path="target" htmlEscape="false" maxlength="10" class="input-small input-sm"/>
				<span class="help-inline">链接地址打开的目标窗口，默认：mainFrame</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图标:</label>
			<div class="controls">
				<sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="50" class="required digits input-small input-sm"/>
				<span class="help-inline">排列顺序，升序。</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">可见:</label>
			<div class="controls">
				<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">该菜单或操作是否显示到系统菜单中</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">权限标识:</label>
			<div class="controls">
				<form:input path="permission" htmlEscape="false" maxlength="100" class="input-xxlarge"/>
				<span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:menu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-default" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>