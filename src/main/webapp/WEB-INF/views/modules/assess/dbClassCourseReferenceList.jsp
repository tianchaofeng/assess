<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级课程信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var extractToList = ${extractToList};
			if(extractToList != ""){
				var opt = "<option value=''></option>";
				for(var i=0;i<extractToList.length;i++){
					opt += "<option id ='"+extractToList[i]+"' value='"+extractToList[i]+"'>" +extractToList[i] + "</option>"
				}
				 document.getElementById("discipline").innerHTML = opt;
			}
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/assess/dbClassCourse/reference");
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbClassCourse/">班级课程信息列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="dbClassCourse" action="${ctx}/assess/dbClassCourse/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>年级：</label>
				<form:select path="grade" style="width:100px;">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('student_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>学科：</label>
				<select name="def1" style="width: 100px">
				<c:forEach items="${extractToList}" var="extractToList">
					<option value="" label="" />
					<option value="${ extractToList}"> ${extractToList}</option>
				</c:forEach>
			    </select>
				<%-- <form:select path="discipline" style="width:100px;">
					<form:option value="" label="" />
					<form:options items="${extractToList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select> --%>
			</li>
		</ul>
		<ul class='ul-form padding_top'>	
			<li><label>上下册：</label>
				<form:select path="ce" style="width:100px;">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('up_down')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>单元：</label>
				<form:input path="bookunit" htmlEscape="false" maxlength="64" class="input-medium"/>
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
				<th class="sort-column discipline">学科</th>
				<th class="sort-column version">版本</th>
				<th class="sort-column grade">年级</th>
				<th class="sort-column ce">上下册</th>
				<th class="sort-column bookunit">单元</th>
				<th class="sort-column updateDate">修改时间</th>
				<th class="sort-column remarks">说明</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dbClassCourse">
			<tr>
				<td style="text-align:center;"><input type=radio name="id" value="${dbClassCourse.id}"/></td>
				<td><a href="${ctx}/assess/dbClassCourse/detail?id=${dbClassCourse.id}">
					${dbClassCourse.discipline.name}
				</a></td>
				<td>
					${fns:getDictLabel(dbClassCourse.version, 'book_version', '')}
				</td>
				<td>
					${fns:getDictLabel(dbClassCourse.grade, 'student_grade', '')}
				</td>
				<td>
					${fns:getDictLabel(dbClassCourse.ce, 'up_down', '')}
				</td>
				<td>
					${dbClassCourse.bookunit}
				</td>
				<td>
					<fmt:formatDate value="${dbClassCourse.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dbClassCourse.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination col-sm-12">${page}</div>
</body>
</html>