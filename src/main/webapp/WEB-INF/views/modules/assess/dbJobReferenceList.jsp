<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务创建管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbJob/reference");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbJob/">任务创建列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="dbJob" action="${ctx}/assess/dbJob/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>课例名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="5%">选择</th>
				<th class="sort-column name">课例名称</th>
				<th class="sort-column type">考评类型</th>
				<th class="sort-column questionnaireId">评课工具</th>
				<th class="sort-column evaluationTarget">授课教师</th>
				<th class="sort-column teamId">评课小组</th>
				<th class="sort-column participantId">参评人</th>
				<th class="sort-column startDate">考评开始时间</th>
				<th class="sort-column endDate">考评结束时间</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbJob">
			<tr>
				<td style="text-align:center;"><input type=radio name="id" value="${dbJob.id}"/></td>
				<td><a href="${ctx}/assess/dbJob/detail?id=${dbJob.id}">
					${dbJob.name}
				</a></td>
				<td>
					${dbJob.type}
				</td>
				<td>
					${dbJob.questionnaireId}
				</td>
				<td>
					${dbJob.evaluationTarget}
				</td>
				<td>
					${dbJob.teamId}
				</td>
				<td>
					${dbJob.participantId}
				</td>
				<td>
					<fmt:formatDate value="${dbJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${dbJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${dbJob.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbJob.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>