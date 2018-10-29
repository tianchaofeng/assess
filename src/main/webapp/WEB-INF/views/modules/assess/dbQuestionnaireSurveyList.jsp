<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷调查管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出问卷调查数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbQuestionnaireSurvey/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbQuestionnaireSurvey/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbQuestionnaireSurvey/">问卷调查列表</a></li>
		<shiro:hasPermission name="assess:dbQuestionnaireSurvey:edit"><li><a href="${ctx}/assess/dbQuestionnaireSurvey/form">问卷调查添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbQuestionnaireSurvey" action="${ctx}/assess/dbQuestionnaireSurvey/" method="post" class="form-inline form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<%-- <ul class="ul-form">
			<li><label>单元：</label>
				<form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>学科：</label>
				<form:select path="subject" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('subject')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>学校：</label>
				<sys:treeselect id="school" name="school.id" value="${dbQuestionnaireSurvey.school.id}" labelName="school.name" labelValue="${dbQuestionnaireSurvey.school.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul> --%>
		<div >
			<%--  <div class="form-group">
			    <label>单元：</label>
			    <form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-medium"/>
			  </div>
			  <div class="form-group">
			    <label>学科：</label>
			    <form:select path="subject" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('subject')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			  </div> --%>
			  <div class="form-group">
			    <label >学校：</label>
			    <sys:treeselect id="school" name="school" value="${dbQuestionnaireSurvey.school}" labelName="" labelValue="${dbQuestionnaireSurvey.school}"
					title="学校" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			  </div>
			  <div class="form-group">
			    <label>姓名：</label>
			    <form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			  </div>
			  <div class="form-group">
				  <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				  <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			  </div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<!-- <th class="sort-column bookunit">单元</th>
				<th class="sort-column subject">学科</th> -->
				<th class="sort-column name">姓名</th>
				<th class="sort-column school">学校</th>
				<th class="sort-column gender">性别</th>
				<th class="sort-column age">年龄</th>
				<th class="sort-column education">最终学历</th>
				<th class="sort-column years">教学年限</th>
				<th class="sort-column times">准备时间</th>
				<!-- <th class="sort-column reference">参考资料</th>
				<th class="sort-column processingMode">教材内容处理方式</th>
				<th class="sort-column readyOrder">准备顺序</th>
				<th class="sort-column solveOrdedr">解决顺序</th>
				<th class="sort-column questionsOrder">提问顺序</th>
				<th class="sort-column teamOrder">合作顺序</th>
				<th class="sort-column homeworkOrder">作业顺序</th>
				<th class="sort-column correcting">批改方式</th> -->
				<shiro:hasPermission name="assess:dbQuestionnaireSurvey:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbQuestionnaireSurvey" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<%-- <td><a href="${ctx}/assess/dbQuestionnaireSurvey/detail?id=${dbQuestionnaireSurvey.id}">
					${dbQuestionnaireSurvey.bookunit}
				</a></td>
				<td>
					${fns:getDictLabel(dbQuestionnaireSurvey.subject, 'subject', '')}
				</td> --%>
				<td><a href="${ctx}/assess/dbQuestionnaireSurvey/detail?id=${dbQuestionnaireSurvey.id}">
					${dbQuestionnaireSurvey.name}
				</a></td>
				<td>
					${dbQuestionnaireSurvey.school.name}
				</td>
				<td>
					${fns:getDictLabel(dbQuestionnaireSurvey.gender, 'gender', '')}
				</td>
				<td>
					${dbQuestionnaireSurvey.age}
				</td>
				<td>
				${fns:getDictLabel(dbQuestionnaireSurvey.education, 'education', '')}
				</td>
				<td>
					${dbQuestionnaireSurvey.years}
				</td>
				<td>
					${dbQuestionnaireSurvey.times}
				</td>
				<%-- <td>
					${dbQuestionnaireSurvey.reference}
				</td>
				<td>
					${dbQuestionnaireSurvey.processingMode}
				</td>
				<td>
					${dbQuestionnaireSurvey.readyOrder}
				</td>
				<td>
					${dbQuestionnaireSurvey.solveOrdedr}
				</td>
				<td>
					${dbQuestionnaireSurvey.questionsOrder}
				</td>
				<td>
					${dbQuestionnaireSurvey.teamOrder}
				</td>
				<td>
					${dbQuestionnaireSurvey.homeworkOrder}
				</td>
				<td>
					${dbQuestionnaireSurvey.correcting}
				</td> --%>
				<shiro:hasPermission name="assess:dbQuestionnaireSurvey:edit"><td>
    				<a href="${ctx}/assess/dbQuestionnaireSurvey/form?id=${dbQuestionnaireSurvey.id}">修改</a>
					<a href="${ctx}/assess/dbQuestionnaireSurvey/delete?id=${dbQuestionnaireSurvey.id}" onclick="return confirmx('确认要删除该问卷调查吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-md-12 col-lg-12">${page}</div>
</body>
</html>