<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>评分统计整体页</title>
    <link href="${ctxStatic}/bootstrap/3.3.4/css_default/bootstrap.min.css" type="text/css" rel="stylesheet" />
    
<script src="https://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<style type="text/css">
@media print {

			  a[href]:after {
			    content: none !important;
			  }
			  .noprint { 
			  	display: none;
			  } 
			}
</style>
<script type="text/javascript">

$(document).ready(function(){
	  $("#btn").click(function(){
		  window.print();
	  });
	});



</script>
</head>
<body>

<table>

    <span id="btn" class="noprint">打印</span>
</table>

</body>

</html>