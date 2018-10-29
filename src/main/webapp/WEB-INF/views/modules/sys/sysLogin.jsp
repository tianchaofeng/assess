<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%-- <html>
<head>
	<title>${fns:getConfig('productName')}登录</title>
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
	<style>
		
		.header .header_body{
			height:80px;
			background:#fff;
			line-height:80px;
			border-bottom:1px solid #ccc;
		}
		.header-logo-middle{
			color:#555;
		}
		.ui-header{
			background:#fff;
		}
		.control-group .control-label{
			width:60px;
			padding-left:10px;
		}
		.form-group{
			margin-bottom:10px!important;
		}
		.form-inline input[type="text"],input[type="password"]{
			height:36px;
			width:230px;
			padding:0!important;
			background:#fff!important;
			-webkit-appearance: none;
			text-indent:5px;
		}
		input:-webkit-autofill{
		   -webkit-box-shadow: 0 0 0 1000px white inset !important;
		   background:#fff;
		}
		.forgot-password-link{
			color:#444;
			float:right;
			margin-right:30px;
		}
		.control-group{
			border:none
		}
		 .col-xs-4{
		    background:rgba(0,0,0,0.4);
			margin-top:40px;
		} 
		.form_box{
			padding:20px 45px;
		}
		.point_Mes{
			padding:1px;
			margin-bottom:10px;
			background:#faffbd;
			border:1px solid #f8ac59;
			font-size:12px;
		}
		.controls{
			font-size:12px;
			margin-bottom:10px;
			font-weight: 100;
			color:#fff;
		}
		.controls a{
			color:#fff;
		}
		.user_icon_l{
			width:40px!important;
			height:36px!important;
		}
		.tab-content{
			position:initial!important
		}
		.required{
		    width: 200px;
		    background: #fff;
		    border-radius:5px!important;
		    border: 1px solid #ccc;
		}
		
		.btn_l button{
			width:268px;
		}
		.footer{
		    min-height: 100px;
		    width: 100%;
		    background:#fff;
		    color:#555;
			text-align:center;
		} 
	.toolbar{
		text-align:right;
		padding:10px 30px 0 0;;
	}
	</style>
</head>
<body>
	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header header_l">
		<div class="header_body ui-header">
			<div class="container">
				<div class="row">
					<a class="span5 header-logo dpB fL cb" href="#">
						
						<span class="header-logo-middle ">${fns:getConfig('productName')}</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="section">
		<div class="container main mt20" style="min-height: 350px">
			<div class="row">
				<div class="col-xs-12">
					<div class="login-msg">
						<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}">
						<button data-dismiss="alert" class="close">×</button>
						<label id="loginError" class="error">${message}</label>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-7"> 
				</div>
				<div class="col-xs-4">
					<form id="loginForm" class="form-inline" role="form" action="${ctx}/login" method="post">
						<div class="form_box">
						<p class="point_Mes"><i class="icon-lightbulb">&nbsp;&nbsp;&nbsp;公共场所不建议自动登陆，以防账号丢失</i></p>
						<div class="form-group">
						    <div class="input-group">
						      <div class="input-group-addon user_icon_l"><i class="icon-user"></i></div>
						      <input type="text" id="username" name="username" class="required" value="${username}" placeholder="请输入您的用户名"/>
						    </div>
						  </div>
						  <div class="form-group">
						    <div class="input-group">
						      <div class="input-group-addon user_icon_l"><i class="icon-key"></i></div>
						      <input type="password" id="password" name="password" class="required" placeholder="请输入您的用户名密码"/>
						    </div>
						  </div>
						
						<c:if test="${isValidateCodeLogin}">
							<div class="control-group">
								<div class="controls">
									<div class="validateCode">
										<label class="control-label input-label mid" for="validateCode">验证码</label>
										<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;" />
									</div>
								</div>
							</div>
						</c:if>
						<div class="control-group">
							<div class="controls">
								<label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} /> 自动登陆</label>
								<a href="#" data-target="#forgot-box" class="forgot-password-link">忘记密码</a>
							</div>
						</div>
						<div class="btn_l">
							<button type="submit" class="btn btn-primary"><i class="icon-signin"></i> 登录</button>
						</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="container">
			<div class="row">
				<div class=" span9">
					<p style="margin-bottom: 10px; margin-top: 10px">建议您使用IE9+、FireFox、Google Chrome，分辨率1280*800及以上浏览本网站，获得更好用户体验。</p>
					<p style="margin-bottom: 10px">
						Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="" target="_blank"
							class="copyright-a">pccw</a> ${fns:getConfig('version')}
					</p>
				</div>
			</div>
		</div>
	</div> 
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
 --%>
 
<!doctype html>
<html lang="en">
<head>
	<title>${fns:getConfig('productName')}登录</title>
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
	<header class='head'>
		<div class='container'>
			<div class='row'>
				<div class='col-sm-12'>
					<h4>${fns:getConfig('productName')}</h4>
				</div>
			</div>
		</div>
	</header>
	<section class='sect'>
		<div class='container'>
			<div class='row'>
				<div class='col-sm-12 col-md-12 col-lg-12text-center'>
					<div class="login-msg">
						<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}">
						<button data-dismiss="alert" class="close">×</button>
						<label id="loginError" class="error">${message}</label>
						</div>
					</div>
					<div class='col-sm-6 col-md-6 col-lg-6 col_img'>
						<img alt="" src="${ctxStatic}/images/login-bg.png">
					</div>
					<div class='col-sm-6 col-md-6 col-lg-6'>
						<div class='pad_box'>
							<div class="pad_title">${fns:getConfig('productName')}</div>
							<form id="loginForm" role="form" action="${ctx}/login" method="post">
								<div class="form-group" >
								    <input type="text" id="username" name="username" class="required" value="${username}" placeholder="请输入您的用户名"/>
								</div>
								<div class="form-group" >
								    <input type="password" id="password" name="password" class="required" placeholder="请输入您的用户名密码"/>
								</div>
								<c:if test="${isValidateCodeLogin}">
									<div class="form-group">
										<div class="controls">
											<div class="validateCode">
												<label class="input-label mid" for="validateCode">验证码</label>
												<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;" />
											</div>
										</div>
									</div>
								</c:if>
								<div class='form-group'>
									<div class="checkbox">
									      <input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''} />记住密码(公共场合 <span style='color:red'>慎用</span> )
									</div>
								 </div>
								 <button type="submit" class="btn btn-primary btn_bg_color">登录</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>		
	</section>
	<footer class='foot'>
		<div class='container'>
			<div class='row'>
				<div class='col-sm-12 text-center'>
					<p>建议您使用IE9+、FireFox、Google Chrome，分辨率1280*800及以上浏览本网站，获得更好用户体验。</p>
					<p>
						Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="" target="_blank"
							class="copyright-a">Ezicloud</a> ${fns:getConfig('version')}
					</p>
				</div>
			</div>		
		</div>
	</footer>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
 
 