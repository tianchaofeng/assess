<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人任务管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出个人任务数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbJobSelf/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbJobSelf/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbJobSelf/list">个人任务列表</a></li>
		<%-- <shiro:hasPermission name="assess:dbJobSelf:edit"><li><a href="${ctx}/assess/dbJobSelf/form">个人任务添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="dbJobSelf" action="${ctx}/assess/dbJobSelf/" method="post" class="breadcrumb form-search">
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
				<th >课例名称</th>
				<th >授课教师</th>
				<th >学科</th>
				<th >版本</th>
				<th >年级</th>
				<th >上下册</th>
				<th >单元</th>
				<th >章节</th>
				
				<th >参评人</th>
				<th >得分</th>
				<th class="sort-column startDate">开始时间</th>
				<th class="sort-column endDate">结束时间</th>
				<shiro:hasPermission name="assess:dbJobSelf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbJobSelf" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><%-- <a href="${ctx}/assess/dbJobSelf/detail?id=${dbJobSelf.id}"> --%>
					${dbJobSelf.name }
				<!-- </a> --></td>
				<td>
					${dbJobSelf.target.name }
				</td>
				
				<td>
					${dbJobSelf.discipline.def1 }
				</td>
				<td>
					${fns:getDictLabel(dbJobSelf.version,'book_version','')}
				</td>
				<td>
					${fns:getDictLabel(dbJobSelf.grade,'student_grade','')}
				</td>
				<td>
					${fns:getDictLabel(dbJobSelf.ce,'up_down','')}
				</td>
				<td>
					${dbJobSelf.bookunit}
				</td>
				<td>
					${dbJobSelf.chapter}
				</td>
				
				
				<td>
					${dbJobSelf.participant.name }
				</td>
				<td>
					${dbJobSelf.score }
				</td>
				<td>
					<fmt:formatDate value="${dbJobSelf.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${dbJobSelf.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="assess:dbJobSelf:edit"><td>
    				<%-- <a href="${ctx}/assess/dbJobSelf/form?id=${dbJobSelf.id}">修改</a>
					<a href="${ctx}/assess/dbJobSelf/delete?id=${dbJobSelf.id}" onclick="return confirmx('确认要删除该个人任务吗？', this.href)">删除</a> --%>
    					<a href="${ctx}/assess/dbJobSelf/exercise?id=${dbJobSelf.id}" target="_blank">评分</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-md-12 col-lg-12">${page}</div>
</body>
</html>