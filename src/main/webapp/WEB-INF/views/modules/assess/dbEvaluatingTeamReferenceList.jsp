<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价小组管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbEvaluatingTeam/reference");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbEvaluatingTeam/">评价小组列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="dbEvaluatingTeam" action="${ctx}/assess/dbEvaluatingTeam/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<c:if test="${fns:getUser().id eq '1'}">
			<li><label>小组长：</label>
				<sys:gridselect id="temaHeader" name="temaHeader.id" value="${dbEvaluatingTeam.temaHeader.id}" labelName="temaHeader.name" labelValue="${dbEvaluatingTeam.temaHeader.name}"
					title="小组长" url="/sys/user/reference" cssClass="required"/>
			</li>
			</c:if>
			
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
				<th class="sort-column name">名称</th>
				<th class="sort-column temaHeader">小组长</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbEvaluatingTeam">
			<tr>
				<td style="text-align:center;"><input type=radio name="id" value="${dbEvaluatingTeam.id}"/></td>
				<td>
					${dbEvaluatingTeam.name}
				</td>
				<td>
					${dbEvaluatingTeam.temaHeader.name}
				</td>
				<td>
					<fmt:formatDate value="${dbEvaluatingTeam.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbEvaluatingTeam.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>