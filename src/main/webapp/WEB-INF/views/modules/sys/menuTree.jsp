<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><%--
<html>
<head>
	<title>菜单导航</title>
	<meta name="decorator" content="blank"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".accordion-heading a").click(function(){
				$('.accordion-toggle i').removeClass('icon-chevron-down');
				$('.accordion-toggle i').addClass('icon-chevron-right');
				if(!$($(this).attr('href')).hasClass('in')){
					$(this).children('i').removeClass('icon-chevron-right');
					$(this).children('i').addClass('icon-chevron-down');
				}
			});
			$(".accordion-body a").click(function(){
				$("#menu-${param.parentId} li").removeClass("active");
				$("#menu-${param.parentId} li i").removeClass("icon-white");
				$(this).parent().addClass("active");
				$(this).children("i").addClass("icon-white");
				//loading('正在执行，请稍等...');
			});
			//$(".accordion-body a:first i").click();
			//$(".accordion-body li:first li:first a:first i").click();
		});
	</script>
</head>
<body> --%>
<script type="text/javascript">
	$('li').has('ul').css('border', 'none');
</script>
	<div class="accordion l_accordion" id="menu-${param.parentId}">
	<c:set var="menuList" value="${fns:getMenuList()}"/>
	<c:set var="firstMenu" value="true"/>
	<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
	<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
		<div class="accordion-group">
		    <div class="accordion-heading">
		    	<a class="accordion-toggle l_icon" data-toggle="collapse" data-parent="#menu-${param.parentId}" data-href="#collapse-${menu.id}" href="#collapse-${menu.id}" title="${menu.remarks}"><%-- <i class="icon-chevron-${not empty firstMenu && firstMenu ? 'down' : 'right'}"></i> --%>&nbsp;${menu.name}</a>
		    </div>
		    <div id="collapse-${menu.id}" class="accordion-body collapse ${not empty firstMenu && firstMenu ? 'in' : ''}">
				<div class="accordion-inner">
					<ul class="nav nav-list">
					<c:forEach items="${menuList}" var="menu2">
					<c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
						<li>
						<a data-href=".menu3-${menu2.id}" href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" target="${not empty menu2.target ? menu2.target : 'mainFrame'}" >
							<i class="icon-${not empty menu2.icon ? menu2.icon : 'circle-arrow-right'}"></i>&nbsp;${menu2.name}
						</a>
							<ul class="nav nav-list nav_menu_ul_l" style="margin:0;padding-right:0;display:none">
								<c:forEach items="${menuList}" var="menu3">
									<c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}">
										<li class="menu3-${menu2.id} tab_3_l" style="display:none">
											<a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}" target="${not empty menu3.target ? menu3.target : 'mainFrame'}" ><i class="icon-${not empty menu3.icon ? menu3.icon : 'circle-arrow-right'}"></i>&nbsp;${menu3.name}</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						<c:set var="firstMenu" value="false"/></c:if></c:forEach>
					</ul>
				</div>
		    </div>
		</div>
	</c:if></c:forEach></div>
	
		<%-- <div id="menu-${param.parentId}">
			<div class="list-group panel">
				<c:set var="menuList" value="${fns:getMenuList()}"/>
				<c:set var="firstMenu" value="true"/>
				<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
				<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
				
					<a href="#${menu.id}" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#menu-${param.parentId}">${menu.name}</a>
					<div class="collapse" id="${menu.id}">
						 <c:forEach items="${menuList}" var="menu2">
						 <c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">	
							<a href="#SubMenu1${menu.id}" class="list-group-item" data-toggle="collapse" data-parent="#SubMenu1">${menu2.name}<i class="fa fa-caret-down"></i></a>
							<div class="collapse list-group-submenu" id="SubMenu1${menu.id}">
								<c:forEach items="${menuList}" var="menu3">
									<c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}">
										<a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}" class="list-group-item" data-toggle="collapse" data-parent="#SubMenu1${menu.id}">${menu3.name} <i class="fa fa-caret-down"></i></a>
									</c:if>
								</c:forEach>
							</div>
						</c:if>
					</c:forEach>	
					</div>
				</c:if>
				</c:forEach>		
			</div>
		</div> --%>
	
	
	<%--
</body>
</html> --%>