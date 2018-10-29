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
			if("${type}"!=""){
				$("#searchForm").attr("action","${ctx}/sys/user/reference?type=${type}");
				$("#searchForm").submit();
			}else{
				$("#searchForm").attr("action","${ctx}/sys/user/reference");
				$("#searchForm").submit();
				
			}
	    	return false;
	    }
	
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/assess/dbEvaluatingTeam/getTeamUser" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><span>区域：</span>
				<form:input path="company.name" htmlEscape="false" maxlength="64" class="input-medium"/>
			<span>学校：</span>
				<form:input path="office.name" htmlEscape="false" maxlength="64" class="input-medium"/>
			<span>用户名称：</span>
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
				<th>用户名称</th>
				<th>登录名</th>
				<th>用户类型</th>
				<th>所属区域</th>
				<th>所属学校</th>
				<th>修改时间</th>
				<th>说明</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td style="text-align:center;"><input type=radio name="id" value="${user.id}"/></td>
				<td>
					${user.name}
				</td>
				<td>
					${user.loginName}
				</td>
				<td>
					${fns:getDictLabel(user.userType, 'sys_user_type', '')}
				</td>
				<td>
					${user.company.name}
				</td>
				<td>
					${user.office.name}
				</td>
				
				<td>
					<fmt:formatDate value="${user.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${user.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>