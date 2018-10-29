<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷调查详细</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="dbQuestionnaireSurvey"  class="form-horizontal">
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
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"  disabled="disabled"/>
			    </div>
		    </div><!-- 1 -->
		    <div class="form-group">
			    <label class="col-sm-2 control-label">2. 您的姓名：</label>
			    <div class="col-sm-4" >
			    	<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge" disabled="true"/>
			    </div>
		    </div><!-- 2 -->
		    <div class="form-group">
			    <label class="col-sm-2 control-label">3．您的性别：</label>
			    <div class="col-sm-4">
				    <form:select path="gender" class="input-xlarge " disabled="true">
						<form:option value="" label="" />
						<form:options items="${fns:getDictList('gender')}" itemLabel="label" itemValue="value" htmlEscape="false" />
					</form:select>
			    </div>
		    </div><!-- 3 -->
		    <div class="form-group">
			    <label class="col-sm-2 control-label">4．您的年龄：</label>
			    <div class="col-sm-4">
			    	<form:input path="age" htmlEscape="false" maxlength="3" class="input-xlarge" disabled="true"/>
			    </div>
		    </div><!-- 4 --><div class="form-group">
			    <label class="col-sm-2 control-label">5. 您最终的学历：</label>
			    <div class="col-sm-4">
				    <form:select path="education" class="input-xlarge " disabled="true">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('education')}" itemLabel="label" itemValue="value" htmlEscape="false" />
					</form:select>
			    </div>
		    </div><!-- 5 -->
		     <div class="form-group">
			    <label class="col-sm-2 control-label">6．到本学期期末，您教学的年限约为：</label>
			    <div class="col-sm-4">
				    <form:input path="years" htmlEscape="false" maxlength="5" class="input-xlarge " disabled="true"/>
			    </div>
		    </div><!-- 6 -->
		
		<h6>二、备课与作业情况</h6>
			<div class='form-group'>
				<label class="col-sm-4 control-label">1．准备本单元的课，您平均每节课花费了多长时间？</label>
				<div class="col-sm-2">
					<form:input path="times" htmlEscape="false" maxlength="5" class="input-xlarge " disabled="true"/>
				</div>
			</div><!-- 1 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">2.备课时，除了课程标准、教材和教参以外，您还参考了哪些资料？（限选3项）</label>
				<div class="col-sm-8">
					<form:checkboxes path="referenceList" items="${fns:getDictList('reference')}" itemLabel="label" itemValue="value" onclick="hide(this.value)" htmlEscape="false" class="checkbox_2" disabled="true"/>
					<form:input path="def1" id='other_input'/>
				</div>
			</div><!-- 2 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">3.您对于本单元教材内容的处理方式是(可多选)</label>
				<div class="col-sm-8">
					<form:checkboxes path="processingModeList" items="${fns:getDictList('processingMode')}" itemLabel="label" itemValue="value" htmlEscape="false" class="" disabled="true"/>
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
					<form:input path="readyOrder" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/>
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
					<form:input path="solveOrdedr" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/>
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
					<form:input path="questionsOrder" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/>
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
					<form:input path="teamOrder" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/>
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
					<form:input path="homeworkOrder" htmlEscape="false" maxlength="64" class="input-xlarge " disabled="true"/>
				</div>
			</div><!-- 8 -->
			<div class='form-group'>
				<label class="col-sm-4 control-label">9．本单元您采用了哪些批改作业的方式：（限选3项）</label>
				<div class="controls">
					<form:checkboxes path="correctingList" items="${fns:getDictList('correcting')}" itemLabel="label" itemValue="value" htmlEscape="false" class="checkbox_1" disabled="true"/>
				</div>
			</div><!-- 6 -->
			
		<div class="form-actions">
			<input id="btnPrint" class="btn btn-primary" type="button" value="打印" onclick="window.print()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>