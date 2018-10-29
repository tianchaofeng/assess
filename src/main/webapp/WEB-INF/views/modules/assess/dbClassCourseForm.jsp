<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>班级课程信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
		$(document).ready(function() {
			var ii="${dbClassCourse.bookunit}"
			var opt = "<option value=''></option>";
			for(var i=1;i<20;i++){
				if(ii==i){
					opt += "<option value='"+i+"' selected='selected'>" + i+"单元" + "</option>"
				}else{
					opt += "<option value='"+i+"'>" + i+"单元" + "</option>"
				}
			}
			document.getElementById("left").innerHTML = opt;
			
			
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
		<li><a href="${ctx}/assess/dbClassCourse/">班级课程信息列表</a></li>
		<li class="active"><a
			href="${ctx}/assess/dbClassCourse/form?id=${dbClassCourse.id}">班级课程信息<shiro:hasPermission
					name="assess:dbClassCourse:edit">${not empty dbClassCourse.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="assess:dbClassCourse:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#tab-1"
			aria-expanded="true">基础信息</a></li>
		<li class=""><a data-toggle="tab" href="#tab-2"
			aria-expanded="false">详细信息</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="dbClassCourse"
		action="${ctx}/assess/dbClassCourse/save" method="post"
		class="form-horizontal">
		<div class="tabs-container">
			<div class="tab-content">
				<div id="tab-1" class="tab-pane active">
					<form:hidden path="id" />
					<sys:message content="${message}" />
					<div class="control-group">
						<label class="control-label">版本：</label>
						<div class="controls">
							<form:select path="version" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('book_version')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">年级：</label>
						<div class="controls">
							<form:select path="grade" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('student_grade')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">学科：</label>
						<div class="controls">
							
							<sys:gridselect id="discipline" name="discipline.id" value="${dbClassCourse.discipline.id}" labelName="discipline.name" labelValue="${dbClassCourse.discipline.name}"
									title="学科" url="/assess/dbCourseinfo/reference" cssClass="required" />
							
							
							
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">上下册：</label>
						<div class="controls">
							<form:select path="ce" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('up_down')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">单元：</label>
						<div class="controls">
							<select name="bookunit" style="width: 100px" id='left'>
							</select>

						</div>
					</div>

					<div class="control-group">
						<label class="control-label">说明：</label>
						<div class="controls">
							<form:textarea path="remarks" htmlEscape="false" rows="4"
								maxlength="255" class="input-xxlarge " />
						</div>
					</div>

				</div>
				<div id="tab-2" class="tab-pane">
					<p class="text-align">班级课程信息子表：</p>
					<div class="controls">
						<table id="contentTable"
							class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th class="hide"></th>
									<!-- <th>主表id</th> -->
									<th>章节</th>
									<th>附件</th>
									<th>说明</th>
									<shiro:hasPermission name="assess:dbClassCourse:edit">
										<th width="10">&nbsp;</th>
									</shiro:hasPermission>
								</tr>
							</thead>
							<tbody id="dbClassCourseChildList">
							</tbody>
							<shiro:hasPermission name="assess:dbClassCourse:edit">
								<tfoot>
									<tr>
										<td colspan="10"><a href="javascript:"
											onclick="addRow('#dbClassCourseChildList', dbClassCourseChildRowIdx, dbClassCourseChildTpl);dbClassCourseChildRowIdx = dbClassCourseChildRowIdx + 1;"
											class="btn">新增</a></td>
									</tr>
								</tfoot>
							</shiro:hasPermission>
						</table>
						<script type="text/template" id="dbClassCourseChildTpl">//<!--
						<tr id="dbClassCourseChildList{{idx}}">
							<td class="hide">
								<input id="dbClassCourseChildList{{idx}}_id" name="dbClassCourseChildList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="dbClassCourseChildList{{idx}}_delFlag" name="dbClassCourseChildList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="dbClassCourseChildList{{idx}}_chapter" name="dbClassCourseChildList[{{idx}}].chapter" type="text" value="{{row.chapter}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<input id="dbClassCourseChildList{{idx}}_def1" name="dbClassCourseChildList[{{idx}}].def1" type="hidden" value="{{row.def1}}" maxlength="300"/>
								<sys:ckfinder input="dbClassCourseChildList{{idx}}_def1" type="files" uploadPath="/assess/dbClassCourseChild" selectMultiple="true"/>
							</td>
							<td>
								<textarea id="dbClassCourseChildList{{idx}}_remarks" name="dbClassCourseChildList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="assess:dbClassCourse:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#dbClassCourseChildList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
						<script type="text/javascript">
						var dbClassCourseChildRowIdx = 0, dbClassCourseChildTpl = $("#dbClassCourseChildTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(dbClassCourse.dbClassCourseChildList)};
							for (var i=0; i<data.length; i++){
								addRow('#dbClassCourseChildList', dbClassCourseChildRowIdx, dbClassCourseChildTpl, data[i]);
								dbClassCourseChildRowIdx = dbClassCourseChildRowIdx + 1;
							}
						});
					</script>
					</div>
				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="assess:dbClassCourse:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit"
						value="保 存" />&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回"
					onclick="history.go(-1)" />
			</div>
		</div>
	</form:form>
</body>
</html>