<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>评价级别管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
			for(var i=0;i<$("#treeTableList").find('tr').length;i++){
				
				var depth = Number($("#treeTableList").find('tr').eq(i).attr('depth'));
				//二级前面箭头
				if(depth ==2){
					var td = $("#treeTableList").find('tr').eq(i).find('td').eq(0);
					var a =td.children();
					a[1].setAttribute("class","default_active_node default_shut"); /*haschild="true"  default_node default_last_leaf*/
					var has = $("#treeTableList").find('tr').eq(i).attr('haschild');
					if(has == undefined){ //是否有下级
						a[1].setAttribute("class","default_node default_last_leaf");
					}
					
				}
				//隐藏三级
				if(depth == 3){
					$("#treeTableList").find('tr').eq(i).hide();
				}
				var td = Number($("#treeTableList").find('tr').eq(i).find('td').eq(1).text());
				if(td ==3){
					$("#treeTableList").find('tr').eq(i).find('td').eq(5).find('a').last().hide();
				}
			}
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/assess/dbLevel/">评价级别列表</a></li>
		<shiro:hasPermission name="assess:dbLevel:edit"><li><a href="${ctx}/assess/dbLevel/form">评价级别添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dbLevel" action="${ctx}/assess/dbLevel/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th class="hide">级别</th>
				<th>序号</th>
				<th>修改时间</th>
				<th>说明</th>
				<shiro:hasPermission name="assess:dbLevel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/assess/dbLevel/form?id={{row.id}}">
				{{row.name}}
			</a></td>
			
			<td class= "hide">
				{{row.level}}
			</td>
			
			<td>
				{{row.sort}}
			</td>
			<td>
				{{row.updateDate}}
			</td>
			<td>
				{{row.remarks}}
			</td>
			<shiro:hasPermission name="assess:dbLevel:edit"><td>
   				<a href="${ctx}/assess/dbLevel/form?id={{row.id}}">修改</a>
				<a href="${ctx}/assess/dbLevel/delete?id={{row.id}}" onclick="return confirmx('确认要删除该评价级别及所有子评价级别吗？', this.href)">删除</a>
				<a href="${ctx}/assess/dbLevel/form?parent.id={{row.id}}">添加下级评价级别</a>
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>