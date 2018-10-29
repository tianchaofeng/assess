<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价小组管理</title>
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
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/assess/dbEvaluatingTeam/">评价小组列表</a></li>
		<li class="active"><a href="${ctx}/assess/dbEvaluatingTeam/form?id=${dbEvaluatingTeam.id}">评价小组<shiro:hasPermission name="assess:dbEvaluatingTeam:edit">${not empty dbEvaluatingTeam.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="assess:dbEvaluatingTeam:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<!-- <ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">基础信息</a></li>
			<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">详细信息</a></li>
	</ul> -->
	
		<form:form id="inputForm" modelAttribute="dbEvaluatingTeam" action="${ctx}/assess/dbEvaluatingTeam/save" method="post" class="form-horizontal">
			<div class="tabs-container">
			<div class="tab-content">
			<!-- <div id="tab-1" class="tab-pane active"> -->
			<form:hidden path="id"/>
			<div class='col-sm-12'>
			<sys:message content="${message}"/>		
			<p class="text-align">小组信息：</p>
			<div class="control-group">
				<label class="control-label">名称：</label>
				<div class="controls">
					<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label">小组长：</label>
				<div class="controls">
					<sys:gridselect id="temaHeader" name="temaHeader.id" value="${dbEvaluatingTeam.temaHeader.id}" labelName="temaHeader.name" labelValue="${dbEvaluatingTeam.temaHeader.name}"
						title="小组长" url="/sys/user/reference" cssClass="required"/>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label">说明：</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
				</div>
			</div>
			
			<!-- <a data-toggle="tab" href="#tab-2" aria-expanded="false">增加组员信息</a> -->
			
			<!-- </div> -->
				<!-- <div  id="tab-2" class="tab-pane"> -->
				<div class="row margin_left">
					<div class="col-sm-12 ">
						<p class="text-align">评价小组组员：</p>
						<table id="contentTable" class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th class="hide"></th>
									<th>组员</th>
									<th>说明</th>
									<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody id="dbEvaluatingTeamMemberList">
							</tbody>
							<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><tfoot>
								<tr><td colspan="10"><a href="javascript:" onclick="addRow('#dbEvaluatingTeamMemberList', dbEvaluatingTeamMemberRowIdx, dbEvaluatingTeamMemberTpl);dbEvaluatingTeamMemberRowIdx = dbEvaluatingTeamMemberRowIdx + 1;" class="btn">新增</a></td></tr>
							</tfoot></shiro:hasPermission>
						</table>
						<script type="text/template" id="dbEvaluatingTeamMemberTpl">//<!--
						<tr id="dbEvaluatingTeamMemberList{{idx}}">
							<td class="hide">
								<input id="dbEvaluatingTeamMemberList{{idx}}_id" name="dbEvaluatingTeamMemberList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="dbEvaluatingTeamMemberList{{idx}}_delFlag" name="dbEvaluatingTeamMemberList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
 								<sys:gridselect id="dbEvaluatingTeamMemberList{{idx}}_memberId" name="dbEvaluatingTeamMemberList[{{idx}}].memberId.id" value="{{row.memberId.id}}" labelName="dbEvaluatingTeamMemberList[{{idx}}].memberId.name" labelValue="{{row.memberId.name}}"
									title="用户" url="/sys/user/reference?type=2" cssClass="required"/>
							</td>
							<td>
								<textarea id="dbEvaluatingTeamMemberList{{idx}}_remarks" name="dbEvaluatingTeamMemberList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#dbEvaluatingTeamMemberList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
						<script type="text/javascript">
							var dbEvaluatingTeamMemberRowIdx = 0, dbEvaluatingTeamMemberTpl = $("#dbEvaluatingTeamMemberTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
							$(document).ready(function() {
								var data = ${fns:toJson(dbEvaluatingTeam.dbEvaluatingTeamMemberList)};
								for (var i=0; i<data.length; i++){
									addRow('#dbEvaluatingTeamMemberList', dbEvaluatingTeamMemberRowIdx, dbEvaluatingTeamMemberTpl, data[i]);
									dbEvaluatingTeamMemberRowIdx = dbEvaluatingTeamMemberRowIdx + 1;
								}
							});
						</script>
					</div>
					</div>
				</div>
				</div>
			<div class="form-actions">
				<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
			<!-- </div> -->
			</div>	
		</form:form>
	
</body>
</html>