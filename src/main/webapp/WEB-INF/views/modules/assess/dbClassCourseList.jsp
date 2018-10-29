<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级课程信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var ii="${dbClassCourse.bookunit}"
				var opt = "<option value=''></option>";
				for(var i=1;i<20;i++){
					if(ii==i){
						opt += "<option value='"+i+"' selected='selected'>" + i+"单元" + "</option>"
					}else{
						opt += "<option value='"+i+"'>" + i+"单元" + "</option>"
					}
				}
				document.getElementById("left").innerHTML = opt;
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出班级课程信息数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/assess/dbClassCourse/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
		});
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbClassCourse/list");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbClassCourse/">班级课程信息列表</a></li>
		<shiro:hasPermission name="assess:dbClassCourse:edit"><li><a href="${ctx}/assess/dbClassCourse/form">班级课程信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbClassCourse" action="${ctx}/assess/dbClassCourse/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>年级:</label>
				<%-- <form:input path="grade" htmlEscape="false" maxlength="64" class="input-medium"/> --%>
				<form:select path="grade" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('student_grade')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
			</li>
			<li><label>学科：</label>
				<form:input path="discipline.def1" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>上下册：</label>
				<%-- <form:input path="ce" htmlEscape="false" maxlength="64" class="input-medium"/> --%>
				<form:select path="ce" style="width:100px;">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('up_down')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
			</li>
			<li><label>单元：</label>
				<%-- <form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-medium"/> --%>
				<select name="bookunit" style="width: 100px" id='left'>
				</select>
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
				<th class="sort-column grade">年级</th>
				<th class="sort-column version">版本</th>
				<th class="sort-column discipline">学科</th>
				<th class="sort-column ce">上下册</th>
				<th class="sort-column bookunit">单元</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
				<shiro:hasPermission name="assess:dbClassCourse:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbClassCourse" varStatus="varStatus">
			<tr>
				<td style="text-align:center;">${(page.pageNo-1)*page.pageSize+varStatus.count}</td>
				<td><a href="${ctx}/assess/dbClassCourse/detail?id=${dbClassCourse.id}">
					${fns:getDictLabel(dbClassCourse.grade, 'student_grade', '')}
				</a></td>
				<td>
					${fns:getDictLabel(dbClassCourse.version, 'book_version', '')}
				</td>
				<td>
					${dbClassCourse.discipline.name}
				</td>
				<td>
					${fns:getDictLabel(dbClassCourse.ce, 'up_down', '')}册
				</td>
				<td>
					${dbClassCourse.bookunit}单元
				</td>
				<td>
					<fmt:formatDate value="${dbClassCourse.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbClassCourse.remarks}
				</td>
				<shiro:hasPermission name="assess:dbClassCourse:edit"><td>
    				<a href="${ctx}/assess/dbClassCourse/form?id=${dbClassCourse.id}">修改</a>
					<a href="${ctx}/assess/dbClassCourse/delete?id=${dbClassCourse.id}" onclick="return confirmx('确认要删除该班级课程信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12 col-md-12 col-lg-12">${page}</div>
</body>
</html>