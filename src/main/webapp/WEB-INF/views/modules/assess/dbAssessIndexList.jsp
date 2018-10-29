<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价指标管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出评价指标数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbAssessIndex/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbAssessIndex/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style type="text/css">
	/* 文字超出长度用省略号代替
	 * title 鼠标悬浮显示所有文字
	 */
	#contentTable { table-layout: fixed;}
	.remarks1 {
	    overflow:hidden;
	    white-space:nowrap;
	    text-overflow:ellipsis;
	    -o-text-overflow:ellipsis;
	    -moz-text-overflow: ellipsis;
	    -webkit-text-overflow: ellipsis;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbAssessIndex/list">评价指标列表</a></li>
		<shiro:hasPermission name="assess:dbAssessIndex:edit"><li><a href="${ctx}/assess/dbAssessIndex/form">评价指标添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbAssessIndex" action="${ctx}/assess/dbAssessIndex/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<!-- <ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul> -->
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<th class="sort-column levelId">评价指标</th>
				<th class="sort-column content">评分要点</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
				<shiro:hasPermission name="assess:dbAssessIndex:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbAssessIndex" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><%-- <a href="${ctx}/assess/dbAssessIndex/detail?id=${dbAssessIndex.id}"> --%>
					${dbAssessIndex.levelId.name}
				<!-- </a> --></td>
				<td>
					${dbAssessIndex.content}
				</td>
				<td>
					<fmt:formatDate value="${dbAssessIndex.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="remarks1" title="${dbAssessIndex.remarks}">
					${dbAssessIndex.remarks}
				</td>
				<shiro:hasPermission name="assess:dbAssessIndex:edit"><td>
    				<a href="${ctx}/assess/dbAssessIndex/form?id=${dbAssessIndex.id}">修改</a>
					<a href="${ctx}/assess/dbAssessIndex/delete?id=${dbAssessIndex.id}" onclick="return confirmx('确认要删除该评价指标吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-md-12 col-lg-12">${page}</div>
</body>
</html>