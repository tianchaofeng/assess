<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/viewJob/reference");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/viewJob/">任务统计列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="viewJob" action="${ctx}/assess/viewJob/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>任务名称：</label>
				<form:input path="job" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>学科：</label>
				<form:input path="course" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>教师：</label>
				<form:input path="teacher" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>区域：</label>
				<form:input path="area" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>学校：</label>
				<form:input path="school" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>考评开始时间：</label>
				<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${viewJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>考评结束时间：</label>
				<input name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${viewJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
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
				<th class="sort-column job">任务名称</th>
				<th class="sort-column course">学科</th>
				<th class="sort-column teacher">教师</th>
				<th class="sort-column area">区域</th>
				<th class="sort-column school">学校</th>
				<th class="sort-column startDate">考评开始时间</th>
				<th class="sort-column endDate">考评结束时间</th>
				<th class="sort-column score">分数</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="viewJob">
			<tr>
				<td style="text-align:center;"><input type=radio name="id" value="${viewJob.id}"/></td>
				<td><a href="${ctx}/assess/viewJob/detail?id=${viewJob.id}">
					${viewJob.job}
				</a></td>
				<td>
					${viewJob.course}
				</td>
				<td>
					${viewJob.teacher}
				</td>
				<td>
					${viewJob.area}
				</td>
				<td>
					${viewJob.school}
				</td>
				<td>
					<fmt:formatDate value="${viewJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${viewJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${viewJob.score}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>