<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评课工具管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出评课工具数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbQuestionnaire/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbQuestionnaire/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbQuestionnaire/">评课工具列表</a></li>
		<shiro:hasPermission name="assess:dbQuestionnaire:edit"><li><a href="${ctx}/assess/dbQuestionnaire/form">评课工具添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbQuestionnaire" action="${ctx}/assess/dbQuestionnaire/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>评课工具名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/> --></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<th class="sort-column name">评课工具名称</th>
				<th class="sort-column score">总分数</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
				<shiro:hasPermission name="assess:dbQuestionnaire:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbQuestionnaire" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><%-- <a href="${ctx}/assess/dbQuestionnaire/detail?id=${dbQuestionnaire.id}"> --%>
					${dbQuestionnaire.name}
				<!-- </a> --></td>
				<td>
					${dbQuestionnaire.score}
				</td>
				<td>
					<fmt:formatDate value="${dbQuestionnaire.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbQuestionnaire.remarks}
				</td>
				<shiro:hasPermission name="assess:dbQuestionnaire:edit"><td>
    				<a href="${ctx}/assess/dbQuestionnaire/form?id=${dbQuestionnaire.id}">修改</a>
					<a href="${ctx}/assess/dbQuestionnaire/delete?id=${dbQuestionnaire.id}" onclick="return confirmx('确认要删除该评课工具吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>