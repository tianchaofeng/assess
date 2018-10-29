<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出任务统计数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/viewJob/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/viewJob/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/viewJob/">任务统计列表</a></li>
		<%-- <a href="${ctx}/assess/viewJob/findListgroup">任务统计</a></li> --%>
		<shiro:hasPermission name="assess:viewJob:edit"><li><a href="${ctx}/assess/viewJob/form">任务统计添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="viewJob" action="${ctx}/assess/viewJob/" method="post" class="breadcrumb form-search viewJob">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<form:hidden path="def1" htmlEscape="false" maxlength="64" class="input-medium"/>
			<form:hidden path="def2" htmlEscape="false" maxlength="64" class="input-medium"/>
			
			<c:forEach items="${map}" var="map">
			    <li><label>${map.value}：</label>
				<form:input path="${map.key}" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			</c:forEach>
			
			
			
			
			
			<%-- <li><label>学科：</label>
				<form:input path="course" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>教师：</label>
				<form:input path="teacher" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
		</ul>
		<ul class="ul-form">
			<li><label>区域：</label>
				<form:input path="area" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>学校：</label>
				<form:input path="school" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li> --%>
			<li><label>考评开始时间：</label>
				<input name="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${viewJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
		</ul>
		<ul class="ul-form">	
			<li><label>考评结束时间：</label>
				<input name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${viewJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns pull-right"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li> -->
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"></th>
				<c:forEach items="${list1}" var="list1">  
					<th>${list1}</th>
				</c:forEach>
				<th class="sort-column startDate">考评开始时间</th>
				<th class="sort-column endDate">考评结束时间</th>
				<th class="sort-column score">分数</th>
				
				<!-- <th class="sort-column course">学科</th>
				<th class="sort-column teacher">教师</th>
				<th class="sort-column area">区域</th>
				<th class="sort-column school">学校</th>
				<th class="sort-column startDate">考评开始时间</th>
				<th class="sort-column endDate">考评结束时间</th>
				<th class="sort-column score">分数</th> -->
				<shiro:hasPermission name="assess:viewJob:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="viewJob" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<c:forEach items="${viewJob.viewJobL}" var="vv">
				 	 <td>
						${vv}
					</td>
				</c:forEach>
				
				<td>
					<fmt:formatDate value="${viewJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${viewJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${viewJob.score}
				</td>
				<%-- <td>
					${viewJob.teacher}
				</td>
				<td>
					${viewJob.area}
				</td>
				<td>
					${viewJob.school}
				</td>
				 --%>
				<%-- <shiro:hasPermission name="assess:viewJob:edit"><td>
    				<a href="${ctx}/assess/viewJob/form?id=${viewJob.id}">修改</a>
					<a href="${ctx}/assess/viewJob/delete?id=${viewJob.id}" onclick="return confirmx('确认要删除该任务统计吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-md-12 col-lg-12">${page}</div>
</body>
</html>