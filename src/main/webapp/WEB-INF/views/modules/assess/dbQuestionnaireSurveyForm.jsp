<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷调查管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".checkbox_2:checked").each(function(){
				if($(this).val()=="5"){
					$("#other_input").show();
				}
			})
			
			
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
		
		
		function hide(other){
			var i=0;
			if($(".checkbox_2:checked").length<=3){
				$(".checkbox_2").each(function(){
					
					if($(this).attr('checked')=="checked"){
						if($(this).val()=="5"){
							$("#other_input").show();
						}else if(other=="5"){
							$("#other_input").hide();
							$("#other_input").val("");
						}
						i=(i+1);
					}
				})
				
				if(i=="0"){
					$("#other_input").hide();
					$("#other_input").val("");
				}
				
			}
			
			
		}
	</script>
	<style>
		#other_input{
			display:none;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/assess/dbQuestionnaireSurvey/">问卷调查列表</a></li>
		<li class="active"><a href="${ctx}/assess/dbQuestionnaireSurvey/form?id=${dbQuestionnaireSurvey.id}">问卷调查<shiro:hasPermission name="assess:dbQuestionnaireSurvey:edit">${not empty dbQuestionnaireSurvey.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="assess:dbQuestionnaireSurvey:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<%-- <form:form id="inputForm" modelAttribute="dbQuestionnaireSurvey" action="${ctx}/assess/dbQuestionnaireSurvey/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">单元：</label>
			<div class="controls">
				<form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学科：</label>
			<div class="controls">
				<form:select path="subject" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('subject')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学校：</label>
			<div class="controls">
				<sys:treeselect id="school" name="school.id" value="${dbQuestionnaireSurvey.school.id}" labelName="school.name" labelValue="${dbQuestionnaireSurvey.school.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:select path="gender" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gender')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">年龄：</label>
			<div class="controls">
				<form:input path="age" htmlEscape="false" maxlength="3" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最终学历：</label>
			<div class="controls">
				<form:select path="education" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('education')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">教学年限：</label>
			<div class="controls">
				<form:input path="years" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">准备时间：</label>
			<div class="controls">
				<form:input path="times" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考资料：</label>
			<div class="controls">
				<form:checkboxes path="reference" items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">教材内容处理方式：</label>
			<div class="controls">
				<form:input path="processingMode" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">准备顺序：</label>
			<div class="controls">
				<form:input path="readyOrder" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">解决顺序：</label>
			<div class="controls">
				<form:input path="solveOrdedr" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提问顺序：</label>
			<div class="controls">
				<form:input path="questionsOrder" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合作顺序：</label>
			<div class="controls">
				<form:input path="teamOrder" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">作业顺序：</label>
			<div class="controls">
				<form:input path="homeworkOrder" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">批改方式：</label>
			<div class="controls">
				<form:checkboxes path="correcting" items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="assess:dbQuestionnaireSurvey:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form> --%>
	
	
	
	<form:form id="inputForm" modelAttribute="dbQuestionnaireSurvey" action="${ctx}/assess/dbQuestionnaireSurvey/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		
	<div class='p_center'>
		<p class='text-center '>指向理想教育文化教学评课工具—教师教学基本信息问卷</p>
		<p>尊敬的老师：</p>
		<p class='text_index'>您好！</p>
		<p class='text_index'>在这份问卷中，您将看到一些与本单元教学准备有关的问题。<span>请您认真地阅读每一道题目，找到最接近自己真实情况的答案，在选择题的选项号上划“√”，在填空题的括号里面填上适当的内容。</span>注意除非特殊说明，每题只有一个答案，请勿漏题！</p>
		<p class='text_index'>问卷中的每个问题都没有正确与错误之分，所有结果仅为科学研究所用。感谢您的热情参与！</p>
		<h6>一、基本信息</h6>
		    <div class="form-group">
			    <label class="col-sm-2 control-label">1. 您所在的学校：</label>
			    <div class="col-sm-4">
			       <sys:treeselect id="school" name="school.id" value="${dbQuestionnaireSurvey.school.id}" labelName="school.name" labelValue="${dbQuestionnaireSurvey.school.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
			    </div>
		    </div><!-- 1 -->
		    <div class="form-group">
			    <label class="col-sm-2 control-label">2. 您的姓名：</label>
			    <div class="col-sm-4">
			    	<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			    </div>
		    </div><!-- 2 -->
		    <div class="form-group">
			    <label class="col-sm-2 control-label">3．您的性别：</label>
			    <div class="col-sm-4">
				    <form:select path="gender" class="input-xlarge " style='width:100px'>
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('gender')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
			    </div>
		    </div><!-- 3 -->
		    <div class="form-group">
			    <label class="col-sm-2 control-label">4．您的年龄：</label>
			    <div class="col-sm-4">
			    	<form:input path="age" htmlEscape="false" maxlength="2" class="input-xlarge age"/>
			    	<span>（20岁70岁）</span>
			    </div>
		    </div><!-- 4 --><div class="form-group">
			    <label class="col-sm-2 control-label">5. 您最终的学历：</label>
			    <div class="col-sm-4">
				    <form:select path="education" class="input-xlarge " style='width:100px'>
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('education')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
			    </div>
		    </div><!-- 5 -->
		     <div class="form-group">
			    <label class="col-sm-2 control-label">6．到本学期期末，您教学的年限约为：</label>
			    <div class="col-sm-4">
				    <form:input path="years" htmlEscape="false" maxlength="5" class="input-xlarge isFloatGteZero"/>
				    <span>（保留一位小数）</span>
			    </div>
		    </div><!-- 6 -->
		
		<h6>二、备课与作业情况</h6>
			<div class='form-group'>
				<label class="col-sm-4 control-label">1．准备本单元的课，您平均每节课花费了多长时间？(分钟)</label>
				<div class="col-sm-2">
					<form:input path="times" htmlEscape="false" maxlength="5" class="input-xlarge  isIntGteZero" style='width:100px'/>
					
				</div>
			</div><!-- 1 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">2.备课时，除了课程标准、教材和教参以外，您还参考了哪些资料？（限选3项）</label>
				<div class="col-sm-8">
					<form:checkboxes path="referenceList" items="${fns:getDictList('reference')}" itemLabel="label" itemValue="value" onclick="hide(this.value)" htmlEscape="false" class="checkbox_2"/>
					<form:input path="def1" id='other_input' placeholder="请输入您的其他参考资料"/>
					<%-- (<form:input path="def1"/>) --%>
				</div>
			</div><!-- 2 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">3.您对于本单元教材内容的处理方式是(可多选)</label>
				<div class="col-sm-8">
					<form:checkboxes path="processingModeList" items="${fns:getDictList('processingMode')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
				</div>
			</div><!-- 3 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">4.准备本单元的课,可能会考虑到以下因素，请您按照重要程度进行排序:</label>
				<div class="col-sm-8">
					<label class="radio-inline">①学生整体认知水平 </label>
					<label class="radio-inline">②学生容易出现困难或问题的地方 </label>
					<label class="radio-inline">③兴趣和动机 </label>
					<label class="radio-inline">④学生之间的差异  </label>
					<label class="radio-inline">⑤课程标准要求</label>
					<label class="radio-inline"> ⑥教材内容和顺序</label>
					<label class="radio-inline">⑦本单元与相关单元内容的联系</label>
					<label class="radio-inline">⑧单元内各节课内容之间的联系</label>
					<form:input path="readyOrder" htmlEscape="false" maxlength="64" class="input-xlarge " placeholder="请输入您的排序顺序"/>
				</div>
			</div><!-- 4 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">5.设计本单元问题解决活动时，可能会考虑以下因素，请您按照重要程度排序：</label>
				<div class="col-sm-8">
					<label class="radio-inline"> ①本单元教学目标  </label>
					<label class="radio-inline"> ②问题的现实情境</label>
					<label class="radio-inline"> ③问题解决的思路 </label>
					<label class="radio-inline"> ④问题解决方式或方法</label>
					<label class="radio-inline"> ⑤问题解决过程中用到的工具和材料</label>
					<label class="radio-inline"> ⑥问题解决中的困难</label>
					<label class="radio-inline"> ⑦学生问题解决中的困难</label>
					<label class="radio-inline"> ⑧问题解决过程中学生思维的差异性</label>
					<label class="radio-inline"> ⑨问题解决中的多种指导方案</label>
					<form:input path="solveOrdedr" htmlEscape="false" maxlength="64" class="input-xlarge " placeholder="请输入您的排序顺序"/>
				</div>
			</div><!-- 5 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">6.设计本单元课堂提问的问题时，可能会考虑以下因素，请您按照重要程度排序：</label>
				<div class="col-sm-8">
					<label class="radio-inline"> ①本单元教学目标  </label>
					<label class="radio-inline"> ②学生可能的答案 </label>
					<label class="radio-inline"> ③问题之间的内在联系 </label>
					<label class="radio-inline"> ④问题之间的层次 </label>
					<label class="radio-inline"> ⑤问题的现实情境</label>
					<form:input path="questionsOrder" htmlEscape="false" maxlength="64" class="input-xlarge " placeholder="请输入您的排序顺序"/>
				</div>
			</div><!-- 6 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">7.设计本单元合作学习时，可能会考虑以下因素，请您按照重要程度排序：</label>
				<div class="col-sm-8">
					<label class="radio-inline"> ①本单元教学目标  </label>
					<label class="radio-inline"> ②学生之间的差异</label>
					<label class="radio-inline"> ③学习内容的适宜性 </label>
					<label class="radio-inline"> ④合作学习时间 </label>
					<label class="radio-inline"> ⑤小组成员的构成</label>
					<label class="radio-inline"> ⑥设备与材料等用具</label>
					<form:input path="teamOrder" htmlEscape="false" maxlength="64" class="input-xlarge " placeholder="请输入您的排序顺序"/>
				</div>
			</div><!-- 7 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">8.设计本单元的作业时，可能会考虑以下因素,请您按照重要程度排序：</label>
				<div class="col-sm-8">
					<label class="radio-inline"> ①本单元教学目标  </label>
					<label class="radio-inline"> ②学生未来发展目标 </label>
					<label class="radio-inline"> ③学生的差异 </label>
					<label class="radio-inline"> ④学生的兴趣 </label>
					<label class="radio-inline"> ⑤作业的形式</label>
					<label class="radio-inline"> ⑥完成作业的时间 </label>
					<label class="radio-inline"> ⑦学生的负担</label>
					<form:input path="homeworkOrder" htmlEscape="false" maxlength="64" class="input-xlarge " placeholder="请输入您的排序顺序"/>
				</div>
			</div><!-- 8 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">9．本单元您采用了哪些批改作业的方式：（限选3项）</label>
				<div class="controls">
					<form:checkboxes path="correctingList" items="${fns:getDictList('correcting')}" itemLabel="label" itemValue="value" htmlEscape="false" class="checkbox_1"/>
				</div>
			</div><!-- 6 -->
			<div class="form-group text-right">
			    <div class="col-sm-offset-2 col-sm-10">
			      	<shiro:hasPermission name="assess:dbQuestionnaireSurvey:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			    </div>
			</div>
	</div>
	</form:form>
	<script>
		$(document).ready(function(){
			$(".checkbox_2").click(function(){
				if($(".checkbox_2:checked").length>3){
					alert("只能选3个");return false;
				}
			});
			$(".checkbox_1").click(function(){
				if($(".checkbox_1:checked").length>3){
					alert("只能选3个");return false;
				}
			}); 
			
			
			
		});
	</script>
</body>
</html>