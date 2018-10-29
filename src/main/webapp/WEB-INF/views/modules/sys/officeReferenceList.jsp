<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/office/reference");
			$("#searchForm").submit();
	    	return false;
	    }
	
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="office" action="${ctx}/pccw/dbSupplier/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>机构名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-medium" />
				<input name="type"  value="${type }" type="hidden" maxlength="50" class="input-medium" />
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
				<th>机构名称</th>
				<th>机构类型</th>
				<th>是否可用</th>
				<th>邮政编码</th>
				<th>修改时间</th>
				<th>说明</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="office">
			<tr>
				<td style="text-align:center;"><input type=radio name="id" value="${office.id}"/></td>
				<td>
					${office.name}
				</td>
				<td>
					${fns:getDictLabel(office.type,'sys_office_type','')}
				</td>
				<td>
					${fns:getDictLabel(office.useable,'sys_office_useable','')}
				</td>
				<td>
					${office.zipCode}
				</td>
				<td>
					<fmt:formatDate value="${office.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${office.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>