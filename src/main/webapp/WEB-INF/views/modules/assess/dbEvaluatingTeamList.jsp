<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价小组管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出评价小组数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbEvaluatingTeam/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbEvaluatingTeam/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbEvaluatingTeam/">评价小组列表</a></li>
		<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><li><a href="${ctx}/assess/dbEvaluatingTeam/form">评价小组添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbEvaluatingTeam" action="${ctx}/assess/dbEvaluatingTeam/" method="post" class="form-inline form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<%-- <ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>小组长：</label>
				<form:input path="temaHeader" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<c:if test="${fns:getUser().id eq '1'}">
			<li><label>小组长：</label>
				<sys:gridselect id="temaHeader" name="temaHeader.id" value="${dbEvaluatingTeam.temaHeader.id}" labelName="temaHeader.name" labelValue="${dbEvaluatingTeam.temaHeader.name}"
					title="小组长" url="/sys/user/reference" cssClass="required"/>
			</li>
			</c:if>
			
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/> --></li>
			<li class="clearfix"></li>
		</ul> --%>
		<div class='ul-form form_left'>
			<div class='form-group'>
				<label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</div>
			<c:if test="${fns:getUser().id eq '1'}">
			<div class='form-group'>
				<label>小组长：</label>
				<sys:gridselect id="temaHeader" name="temaHeader.id" value="${dbEvaluatingTeam.temaHeader.id}" labelName="temaHeader.name" labelValue="${dbEvaluatingTeam.temaHeader.name}"
					title="小组长" url="/sys/user/reference" cssClass="required"/>
			</div>
			</c:if>
			<div class='form-group'>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/> -->
			</div>
		</div>
		
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<th class="sort-column name">名称</th>
				<th class="sort-column temaHeader">小组长</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
				<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbEvaluatingTeam" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><%-- <a href="${ctx}/assess/dbEvaluatingTeam/detail?id=${dbEvaluatingTeam.id}"> --%>
					${dbEvaluatingTeam.name}
				<!-- </a> --></td>
				<td>
					${dbEvaluatingTeam.temaHeader.name}
				</td>
				<td>
					<fmt:formatDate value="${dbEvaluatingTeam.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbEvaluatingTeam.remarks}
				</td>
				<shiro:hasPermission name="assess:dbEvaluatingTeam:edit"><td>
    				<a href="${ctx}/assess/dbEvaluatingTeam/form?id=${dbEvaluatingTeam.id}">修改</a>
					<a href="${ctx}/assess/dbEvaluatingTeam/delete?id=${dbEvaluatingTeam.id}" onclick="return confirmx('确认要删除该评价小组吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>