<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务创建管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出任务创建数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbJob/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbJob/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbJob/">任务创建列表</a></li>
		<shiro:hasPermission name="assess:dbJob:edit"><li><a href="${ctx}/assess/dbJob/form">任务创建添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbJob" action="${ctx}/assess/dbJob/" method="post" class="breadcrumb form-inline form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<%-- <ul class="ul-form">
			<li><span>名称：</span>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
				<span>授课教师：</span>
				<form:input path="discipline.def2" htmlEscape="false" maxlength="64" class="input-medium"/>
				<span>学科：</span>
				<form:input path="discipline.def1" htmlEscape="false" maxlength="64" class="input-medium"/>
				<span>版本：</span>
				
				<form:select path="version" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('book_version')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
				
				<span>年级：</span>
				
				<form:select path="grade" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('student_grade')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
				<span>单元：</span>
				<form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-medium"/>
				<span>上下册：</span>
				
				<form:select path="ce" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('up_down')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/> --></li>
			<li class="clearfix"></li>
		</ul> --%>
		<div>
		 <div class="form-group">
		 	<label>课例名称：</label>
		    <form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
		 </div>
		 <div class="form-group">
		 	<label>授课教师：</label>
		    <form:input path="discipline.def2" htmlEscape="false" maxlength="64" class="input-medium"/>
		 </div>
		 <div class="form-group">
		 	<label>学科：</label>
		    <form:input path="discipline.def1" htmlEscape="false" maxlength="64" class="input-medium"/>
		 </div>
		 <div class="form-group">
		 	<label>单元：</label>
		    <form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-medium"/>
		 </div>
		 
		 </div>
		 <div style='margin-top:15px'>
		 	<div class="form-group">
			 	<label>版本：</label>
			    <form:select path="version" style="width:100px;">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('book_version')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			 </div>
		 	<div class="form-group">
			 	<label>年级：</label>
			    <form:select path="grade" style="width:100px;">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('student_grade')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			 </div>
			 <div class="form-group">
			 	<label>上下册：</label>
			    <form:select path="ce" style="width:100px;">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('up_down')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
			<div class="form-group">
			 	<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</div>	
		 </div>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">序号</th>
				<th >名称</th>
				<th >考评类型</th>
				<th >评课工具</th>
				<th >授课教师</th>
				<th >评课小组</th>
				<th >学科</th>
				<th >版本</th>
				<th >年级</th>
				<th >上下册</th>
				<th >单元</th>
				<th >章节</th>
				<th >参评人</th>
				<th class="sort-column startDate">考评开始时间</th>
				<th class="sort-column endDate">考评结束时间</th>
				<!-- <th class="sort-column updateDate">修改时间</th> -->
				<th class="">平均分</th>
			<!-- 	<th >说明</th> -->
				<th><shiro:hasPermission name="assess:dbJob:edit">操作</shiro:hasPermission>
				<shiro:hasPermission name="assess:dbJob:view">操作</shiro:hasPermission>
				</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbJob" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><%-- <a href="${ctx}/assess/dbJob/detail?id=${dbJob.id}"> --%>
					${dbJob.name}
				<!-- </a> --></td>
				<td>
					${fns:getDictLabel(dbJob.type, 'grade_type', '')}
				</td>
				<td>
					${dbJob.questionnaireId.name}
				</td>
				<td>
					${dbJob.evaluationTarget.name}
				</td>
				<td>
					${dbJob.teamId.name}
				</td>
				
				
				<td>
					${dbJob.discipline.def1}
				</td>
				<td>
					${fns:getDictLabel(dbJob.version,'book_version','')}
				</td>
				<td>
					${fns:getDictLabel(dbJob.grade,'student_grade','')}
				</td>
				<td>
					${fns:getDictLabel(dbJob.ce,'up_down','')}
				</td>
				<td>
					${dbJob.bookunit}
				</td>
				<td>
					${dbJob.chapter}
				</td>
				
				
				
				<td>
					${dbJob.participantId.name}
				</td>
				<td>
					<fmt:formatDate value="${dbJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${dbJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<%-- <td>
					<fmt:formatDate value="${dbJob.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> --%>
				<td>
					${dbJob.def2}
				</td>
				<%-- <td>
					${dbJob.remarks}
				</td> --%>
				<td>
					<%-- <a href="${ctx}/assess/dbJobSelf/echarts?jobid=${dbJob.id}">统计</a> --%>
    				<shiro:hasPermission name="assess:dbJob:view">
    				<c:if test="${dbJob.def1 ne 0}">
    				<a style="font-size: 16px;" href="${ctx}/assess/dbJob/table?id=${dbJob.id}">统计</a>
    				</c:if>
    				<%-- <a href="${ctx}/assess/dbJob/table?id=${dbJob.id}">表格</a> --%>
    				<a href="${ctx}/assess/dbJob/detail?id=${dbJob.id}">查看</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="assess:dbJob:edit">
    				
    				<c:if test="${dbJob.createBy.id eq fns:getUser().id }">
    				<a href="${ctx}/assess/dbJob/form?id=${dbJob.id}">修改</a>
					<a href="${ctx}/assess/dbJob/delete?id=${dbJob.id}" onclick="return confirmx('确认要删除该任务创建吗？', this.href)">删除</a>
    				</c:if>
    				
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>