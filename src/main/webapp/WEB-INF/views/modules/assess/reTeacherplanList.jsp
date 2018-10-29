<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教案管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出教案数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/reTeacherplan/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/reTeacherplan/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/reTeacherplan/">教案列表</a></li>
		<shiro:hasPermission name="assess:reTeacherplan:edit"><li><a href="${ctx}/assess/reTeacherplan/form">教案添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="reTeacherplan" action="${ctx}/assess/reTeacherplan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
				<shiro:hasPermission name="assess:reTeacherplan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="reTeacherplan" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><a href="${ctx}/assess/reTeacherplan/detail?id=${reTeacherplan.id}">
					<fmt:formatDate value="${reTeacherplan.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${reTeacherplan.remarks}
				</td>
				<shiro:hasPermission name="assess:reTeacherplan:edit"><td>
    				<a href="${ctx}/assess/reTeacherplan/form?id=${reTeacherplan.id}">修改</a>
					<a href="${ctx}/assess/reTeacherplan/delete?id=${reTeacherplan.id}" onclick="return confirmx('确认要删除该教案吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>