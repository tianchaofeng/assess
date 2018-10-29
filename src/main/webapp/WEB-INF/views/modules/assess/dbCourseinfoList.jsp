<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学科管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出学科添加数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbCourseinfo/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbCourseinfo/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbCourseinfo/">学科列表</a></li>
		<shiro:hasPermission name="assess:dbCourseinfo:edit"><li><a href="${ctx}/assess/dbCourseinfo/form">学科添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbCourseinfo" action="${ctx}/assess/dbCourseinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li> -->
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<th class="sort-column name">名称</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
				<shiro:hasPermission name="assess:dbCourseinfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbCourseinfo" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><a href="${ctx}/assess/dbCourseinfo/detail?id=${dbCourseinfo.id}">
					${dbCourseinfo.name}
				</a></td>
				<td>
					<fmt:formatDate value="${dbCourseinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbCourseinfo.remarks}
				</td>
				<shiro:hasPermission name="assess:dbCourseinfo:edit"><td>
    				<a href="${ctx}/assess/dbCourseinfo/form?id=${dbCourseinfo.id}">修改</a>
					<a href="${ctx}/assess/dbCourseinfo/delete?id=${dbCourseinfo.id}" onclick="return confirmx('确认要删除该学科添加吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-md-12 col-lg-12">${page}</div>
</body>
</html>