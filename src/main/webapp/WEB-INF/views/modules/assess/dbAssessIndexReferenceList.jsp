<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价指标管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbAssessIndex/reference?assessids=");
			$("#searchForm").submit();
        	return false;
        }
		var isCheckAll = false;  
		function checkAll() {
	            if (isCheckAll) {  
	                $("input[type='checkbox']").each(function() {  
	                    this.checked = false;  
	                });  
	                isCheckAll = false;  
	            } else {  
	                $("input[type='checkbox']").each(function() {  
	                    this.checked = true;  
	                });  
	                isCheckAll = true;  
	            }  
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:void(0)">评价指标列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="dbAssessIndex" action="${ctx}/assess/dbAssessIndex/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<!-- <ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
			<li class="clearfix"></li>
		</ul> -->
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="5%"><input type="checkbox" name="check" onclick="checkAll('check');"/></th>
				<th class="">一级</th>
				<th class="">二级</th>
				<th class="">评价指标</th>
				<th class="">评分要点</th>
				<th class="sort-column updateDate">修改时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbAssessIndex">
			<tr id = "${dbAssessIndex.id}">
				<td style="text-align:center;">
					<%-- <input type=radio name="id" value="${dbAssessIndex.id}"/> --%>
					<input type="checkbox" name="id" value="${dbAssessIndex.id}"/>
					<input type="hidden" value="${dbAssessIndex.levelId1.id}"/>
					<input type="hidden" value="${dbAssessIndex.levelId2.id}"/>
					<input type="hidden" value="${dbAssessIndex.levelId.id}"/>
				</td>
				<td>
					${dbAssessIndex.levelId1.name}
				</td>
				<td>
					${dbAssessIndex.levelId2.name}
				</td>
				<td>
					${dbAssessIndex.levelId.name}
				</td>
				<td>
					${dbAssessIndex.content}
				</td>
				<td>
					<fmt:formatDate value="${dbAssessIndex.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-m d-12 col-lg-12">${page}</div>
</body>
</html>