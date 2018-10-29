<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>子午云物流网站登录</title>
	<meta name="decorator" content="blank"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${ctxStatic}/common/css/main.min.css" rel="stylesheet" />
	<script type="text/javascript">
		$(document).ready(function() {

					$("#loginForm").validate({
						rules : {
							validateCode : {
								remote : "${pageContext.request.contextPath}/servlet/validateCodeServlet"
							}
						},
						messages : {
							username : {required : "请填写用户名."},
							password : {required : "请填写密码."},
							validateCode : {remote : "验证码不正确.",required : "请填写验证码."}
						},
						errorLabelContainer : "#messageBox",
						errorPlacement : function(error, element) {
							error.appendTo($("#loginError").parent());
						}
					});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if (self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0) {
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
		
	</script>
	
</head>
<body>
	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header">
		<div class="header_body ui-header">
			<div class="container">
				<div class="row">
					<a class="span5 header-logo dpB fL cb" href="#"> <i class="ui-header ico-logo dpIB fL"></i><i class="ui-header1 ico-logo dpIB fL"></i> <span class="header-logo-top ">子午云</span><br /> <span
						class="header-logo-middle ">物流网站</span><br /></a>
				</div>
			</div>
		</div>
	</div>

	<div class="container main mt20">
		<div class="row">
			<div class="span12">
				<div class="login-msg">
					<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}">
					<button data-dismiss="alert" class="close">×</button>
					<label id="loginError" class="error">${message}</label>
					</div>
				</div>
			</div>
			<div class="span12 login" style="min-height: 350px">
				<div class="tab-content">
					<div id="grdl" class="fade in tsc-form grdl">
						<form id="loginForm" class="form-horizontal" action="b/login" method="post">
							<div class="control-group">
								<label class="control-label">登录名</label>
								<div class="controls">
									<input type="text" id="username" name="username" class="required" value="${username}" placeholder="请输入您的用户名"/>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">密码</label>
								<div class="controls">
									<input type="password" id="password" name="password" class="required" placeholder="请输入您的用户名密码"/>
								</div>
							</div>
							<c:if test="${isValidateCodeLogin}">
								<div class="control-group">
									<div class="controls">
										<div class="validateCode">
											<label class="input-label mid" for="validateCode">验证码</label>
											<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;" />
										</div>
									</div>
								</div>
							</c:if>
							<div class="control-group">
								<div class="controls">
									<label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} /> 记住我（公共场所慎用）</label>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-primary"><i class="icon-signin"></i> 登录</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!--span9 end-->
		<!--row end-->
	</div>

	<div class="footer">
		<div class="container">
			<div class="row">
				<div class=" span9">
					<p style="margin-bottom: 10px; margin-top: 10px">建议您使用IE9+、FireFox、Google Chrome，分辨率1280*800及以上浏览本网站，获得更好用户体验。</p>
					<p style="margin-bottom: 10px">
						Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="MC-NET" target="_blank"
							class="copyright-a">MC-NET</a> ${fns:getConfig('version')}
					</p>
				</div>
			</div>
		</div>
	</div>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
