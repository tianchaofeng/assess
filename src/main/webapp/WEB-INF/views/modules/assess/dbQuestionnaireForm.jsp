<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评课工具管理</title>
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
			if($("#reQuestionnaireAssessList").find('tr').length !=0){
				var shuzu=[];
				$("#reQuestionnaireAssessList").find('tr').each(function(i){ 
			    	var thistrid = $(this).attr("id"); 
			    	var index = thistrid.split("reQuestionnaireAssessList");
					shuzu.push(index[1]);
			    });
			   	//最大值
			    var max = Math.max.apply(null, shuzu)+1;
			   	idx = max;
			}
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
		function dianji(idx){
			var assessId = [];
			for(var i=0;i<$("#reQuestionnaireAssessList").find('tr').length;i++){
				var s =$("#reQuestionnaireAssessList").find('tr').eq(i).find('td').eq(3).find("input:first").val();
				if(s !=''){
					assessId.push(s);
				}
			}
			
			src = "${ctx}/assess/dbAssessIndex/reference?assessids="+assessId;
			jBox.open(
			        "iframe:"+src,
			        "选择评价指标", 820, 420, 
			        {buttons: {'确定': "ok",'关闭': "cancel"}, iframeScrolling: 'yes', showClose: true,
			        	submit:function (v,h,f){
			        		if(v=="ok"){
			        			var shuzu=[];
			        			$("#reQuestionnaireAssessList").find('tr').each(function(i){ 
			        		    	var thistrid = $(this).attr("id");
			        		    	var index = thistrid.split("reQuestionnaireAssessList");
			        		    	shuzu.push(index[1]);
			        		    })
			        		   	//最大值
			        		    var max = Math.max.apply(null, shuzu)+1;
			        			var table =h.find("iframe")[0].contentWindow.$("#contentTable");
								var assessIdId = [], assessId1Id = [],assessId2Id = [],assessIdName = [],assessId1Name = [],assessId2Name = [],content=[];
								var a = h.find("iframe")[0].contentWindow.$("input[name=id]");
								h.find("iframe")[0].contentWindow.$("input[name=id]").each(function(i){
									if($(this).is(':checked')) {
										
										assessIdId.push($(this).val());
										assessId1Id.push($(this).next().val());
										assessId2Id.push($(this).next().next().val());
										assessId1Name.push(table.find("tr").eq(i+1).find("td").eq(1).text());
										assessId2Name.push(table.find("tr").eq(i+1).find("td").eq(2).text());
										assessIdName.push(table.find("tr").eq(i+1).find("td").eq(3).text());
										content.push(table.find("tr").eq(i+1).find("td").eq(4).text());
									}
								});
								$("#reQuestionnaireAssessList"+idx+"_assessId1Id").val(assessId1Id[0].replace(/u_/ig,""));
								$("#reQuestionnaireAssessList"+idx+"_assessId1Name").val(assessId1Name[0].replace(/\s/g,""));
								$("#reQuestionnaireAssessList"+idx+"_assessId2Id").val(assessId2Id[0].replace(/\s/g,""));
								$("#reQuestionnaireAssessList"+idx+"_assessId2Name").val(assessId2Name[0].replace(/\s/g,""));
								$("#reQuestionnaireAssessList"+idx+"_assessIdId").val(assessIdId[0].replace(/\s/g,""));
								$("#reQuestionnaireAssessList"+idx+"_assessIdName").val(assessIdName[0].replace(/\s/g,""));
								$("#reQuestionnaireAssessList"+idx+"_def2").val(content[0].replace(/\s/g,""));
								if(idx == 0){
									$("#reQuestionnaireAssessList"+idx+"_proportion").val(30);
								}else{
									$("#reQuestionnaireAssessList"+idx+"_proportion").val((Number(idx)+1)*30);
									
								}
								var RowIdx = max, reQuestionnaireAssessTpl = $("#reQuestionnaireAssessTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
								for(var i=1;i<assessIdId.length;i++){
									addRow('#reQuestionnaireAssessList', RowIdx, reQuestionnaireAssessTpl);
									$("#reQuestionnaireAssessList"+RowIdx+"_assessId1Id").val(assessId1Id[i].replace(/u_/ig,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_assessId1Name").val(assessId1Name[i].replace(/\s/g,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_assessId2Id").val(assessId2Id[i].replace(/\s/g,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_assessId2Name").val(assessId2Name[i].replace(/\s/g,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_assessIdId").val(assessIdId[i].replace(/\s/g,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_assessIdName").val(assessIdName[i].replace(/\s/g,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_def2").val(content[i].replace(/\s/g,""));
									$("#reQuestionnaireAssessList"+RowIdx+"_proportion").val((Number(RowIdx)+1)*30);
									RowIdx = RowIdx + 1;
								}
			        		}
			            }
			        }
				);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/assess/dbQuestionnaire/">评课工具列表</a></li>
		<li class="active"><a href="${ctx}/assess/dbQuestionnaire/form?id=${dbQuestionnaire.id}">评课工具<shiro:hasPermission name="assess:dbQuestionnaire:edit">${not empty dbQuestionnaire.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="assess:dbQuestionnaire:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">基础信息</a></li>
			<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">评价指标</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="dbQuestionnaire" action="${ctx}/assess/dbQuestionnaire/save" method="post" class="form-horizontal">
		<div class="tabs-container">
		<div class="tab-content">
		<div id="tab-1" class="tab-pane active">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">评课工具名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		
		<%-- <div class="control-group">
			<label class="control-label">score：</label>
			<div class="controls">
				<form:input path="score" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
		</div>
			<div  id="tab-2" class="tab-pane">
				
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<!-- <th>评课工具id</th> -->
								<th>评价指标一级</th>
								<th>评价指标二级</th>
								<th>评价指标</th>
								<th>评分要点</th>
								<th>排序</th>
								<th>说明</th>
								<!-- <th>自定义1</th>
								<th>自定义2</th>
								<th>自定义3</th>
								<th>自定义4</th>
								<th>自定义5</th> -->
								<shiro:hasPermission name="assess:dbQuestionnaire:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="reQuestionnaireAssessList">
						</tbody>
						<shiro:hasPermission name="assess:dbQuestionnaire:edit"><tfoot>
							<tr><td colspan="11"><a href="javascript:" onclick="addRow('#reQuestionnaireAssessList', reQuestionnaireAssessRowIdx, reQuestionnaireAssessTpl);reQuestionnaireAssessRowIdx = reQuestionnaireAssessRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="reQuestionnaireAssessTpl">//<!--
						<tr id="reQuestionnaireAssessList{{idx}}">
							<td class="hide">
								<input id="reQuestionnaireAssessList{{idx}}_id" name="reQuestionnaireAssessList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="reQuestionnaireAssessList{{idx}}_delFlag" name="reQuestionnaireAssessList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								
								<input id="reQuestionnaireAssessList{{idx}}_assessId1Id" name="reQuestionnaireAssessList[{{idx}}].assessId1" type="hidden" value="{{row.assessId1}}" maxlength="64" class="input-small "/>
								<input id="reQuestionnaireAssessList{{idx}}_assessId1Name" name="" type="text" value="{{row.assessId1}}" onclick="dianji({{idx}})" maxlength="64" class="input-small "/>
							</td>
							<td>
								
								<input id="reQuestionnaireAssessList{{idx}}_assessId2Id" name="reQuestionnaireAssessList[{{idx}}].assessId2" type="hidden" value="{{row.assessId2}}" maxlength="64" class="input-small "/>
								<input id="reQuestionnaireAssessList{{idx}}_assessId2Name" name="" type="text" value="{{row.assessId2}}" readonly="true" maxlength="64" class="input-small "/>
							</td>
							<td>
								
								<input id="reQuestionnaireAssessList{{idx}}_assessIdId" name="reQuestionnaireAssessList[{{idx}}].assessId.id" type="hidden" value="{{row.assessId.id}}" maxlength="64" class="input-small "/>
								<input id="reQuestionnaireAssessList{{idx}}_assessIdName" name="" type="text" value="{{row.def1}}" readonly="true" maxlength="64" class="input-small "/>
							</td>
							<td>
								<input id="reQuestionnaireAssessList{{idx}}_def2" name="" type="text" value="{{row.def2}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<input id="reQuestionnaireAssessList{{idx}}_proportion" name="reQuestionnaireAssessList[{{idx}}].proportion" type="text" value="{{row.proportion}}" maxlength="64" class="input-small "/>
							</td>
							<td>
								<textarea id="reQuestionnaireAssessList{{idx}}_remarks" name="reQuestionnaireAssessList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							
							<shiro:hasPermission name="assess:dbQuestionnaire:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#reQuestionnaireAssessList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var reQuestionnaireAssessRowIdx = 0, reQuestionnaireAssessTpl = $("#reQuestionnaireAssessTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(dbQuestionnaire.reQuestionnaireAssessList)};
							for (var i=0; i<data.length; i++){
								addRow('#reQuestionnaireAssessList', reQuestionnaireAssessRowIdx, reQuestionnaireAssessTpl, data[i]);
								reQuestionnaireAssessRowIdx = reQuestionnaireAssessRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="assess:dbQuestionnaire:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>