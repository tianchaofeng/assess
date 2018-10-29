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
		 /*  document.getElementById('printIframe2').contentWindow.iframePrint();
		  document.getElementById('printIframe3').contentWindow.iframePrint(); */
		  window.print();
	  });
	});



</script>
<script>
  // 计算页面的实际高度，iframe自适应会用到
  function calcPageHeight(doc) {
      var cHeight = Math.max(doc.body.clientHeight, doc.documentElement.clientHeight)
      var sHeight = Math.max(doc.body.scrollHeight, doc.documentElement.scrollHeight)
      var height  = Math.max(cHeight, sHeight)
      return height
  }
  //根据ID获取iframe对象
  var ifr = document.getElementById('printIframe1')
  ifr.onload = function() {
  	  //解决打开高度太高的页面后再打开高度较小页面滚动条不收缩
  	  ifr.style.height='0px';
      var iDoc = ifr.contentDocument || ifr.document
      var height = calcPageHeight(iDoc)
      if(height < 850){
      	height = 850;
      }
      ifr.style.height = height + 'px'
  }
</script>
<!-- <style>html,body
{
    margin: 0;
    padding: 0;
    border: 0;
    overflow: hidden;
    height: 100%;
}</style> -->
    <style>
        .container{
            text-align: center;
            float: none;
        }
#printIframe1,#printIframe4{box-shadow: 0 0 20px #ccc; border:1px solid #ccc}
.noprint{padding:5px 15px;background: #00a8f9; border-radius: 5px; color:#fff}
.strong{font-weight: 900;font-size: 16px;padding: 10px;}
    </style>
</head>
<body>

<table class="result" style="margin: auto; widt:100%;"  cellpadding="0" cellspacing="0">

   <%--  <div class="container">
    <div class="form-inline">

      <div class="form-group">
        <label>课例名称：</label><label>${dbJob.name}</label>
      </div>
      <div class="form-group">
        <label>考评类型：</label><label>${fns:getDictLabel('0','grade_type','')}</label>
      </div>
      <div class="form-group">
        <label>评课工具：</label><label>${dbJob.questionnaireId.name}</label>
      </div>
      <div class="form-group">
        <label>授课教师：</label><label>${dbJob.evaluationTarget.name}</label>
      </div>
      <div class="form-group">
        <label>评课小组：</label><label>${dbJob.teamId.name}</label>
      </div>
 </div>

    <div class="form-inline">
        <div class="form-group">
            <label>学科：</label><label>${dbJob.discipline.def1}</label>
        </div>
        <div class="form-group">
            <label>班级信息：</label><label>${dbJob.grade}</label>
        </div>
        <div class="form-group">
            <label>版本：</label><label>${dbJob.version}</label>
        </div>
        <div class="form-group">
            <label>上下册：</label><label>${dbJob.ce}</label>
        </div>
        <div class="form-group">
            <label>单元：</label><label>${dbJob.bookunit}</label>
        </div>
        <div class="form-group">
            <label>章节：</label><label>${dbJob.chapter}</label>
        </div>
        <div class="form-group">
            <label>考评开始时间：</label><label><fmt:formatDate value="${dbJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
        </div>
        <div class="form-group">
            <label>考评结束时间：</label><label><fmt:formatDate value="${dbJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
        </div>
   	 </div>
    </div> --%>
<tr>
<div style="text-align:center;">
<h1 style="display: inline;">${dbJob.name}</h1>
<h2 style="display: inline;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;——${dbJob.evaluationTarget.name}</h2>
<h3>
<span>学科：${dbJob.discipline.def1}&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>版本：${fns:getDictLabel(dbJob.version,'book_version','')}&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>年级：${fns:getDictLabel(dbJob.grade,'student_grade','')}&nbsp;&nbsp;&nbsp;&nbsp;</span>
</h3>
<h3>
<span>上下册：${fns:getDictLabel(dbJob.ce,'up_down','')}&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>单元：${dbJob.bookunit}&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>章节：${dbJob.chapter}&nbsp;&nbsp;&nbsp;&nbsp;</span>
</h3>
<h3>
<span>评课开始时间：<b><fmt:formatDate value="${dbJob.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span>评课结束时间：<b><fmt:formatDate value="${dbJob.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>&nbsp;&nbsp;&nbsp;&nbsp;</span>
</h3>
<h3 >
<span>评课小组：<b>${dbJob.teamId.name}</b>&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span id="btn" class="noprint">打印</span>
<span id="ret" class="noprint" onclick="javascript:history.back(-1);">返回</span>
</h3>
</div>
</tr>
<div style='width:1200px;margin:0 auto'>

<h6 class="strong">评分明细</h6>
<iframe src="${ctx}/assess/dbJob/table2?id=${id}" frameborder="0" id="printIframe1" name="printIframe" align="middle" width="1000" height="500"
        onload="this.height=this.contentWindow.document.documentElement.scrollHeight" >
        <script type="text/javascript">
            //动态获取被引用的页面的高度
            function reinitIframe1(){
                var iframe = document.getElementById("printIframe1");
                try{
                    var bHeight = iframe.contentWindow.document.body.scrollHeight;
                    var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    var height = Math.max(bHeight, dHeight);
                    iframe.height =  height;
                }catch (ex){}
            }
            window.setInterval("reinitIframe1()", 200);
            </script>
        </iframe>
<iframe src="${ctx}/assess/dbJobSelf/echarts2?jobid=${id}" frameborder="0" id="printIframe2" name="printIframe"  width="1000" height="500"
        onload="this.height=this.contentWindow.document.documentElement.scrollHeight"">
        <script type="text/javascript">
            //动态获取被引用的页面的高度
            function reinitIframe2(){
                var iframe = document.getElementById("printIframe2");
                try{
                    var bHeight = iframe.contentWindow.document.body.scrollHeight;
                    var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    var height = Math.max(bHeight, dHeight);
                    iframe.height =  height;
                }catch (ex){}
            }
            window.setInterval("reinitIframe2()", 200);
            </script>
            </iframe>
<iframe src="${ctx}/assess/dbJobSelf/echartsy2?jobid=${id}" frameborder="0" id="printIframe3" name="printIframe" align="middle" style="align-content: center;"  width="1000" height="500"
        onload="this.height=this.contentWindow.document.documentElement.scrollHeight">
        <script type="text/javascript">
            //动态获取被引用的页面的高度
            function reinitIframe3(){
                var iframe = document.getElementById("printIframe3");
                try{
                    var bHeight = iframe.contentWindow.document.body.scrollHeight;
                    var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    var height = Math.max(bHeight, dHeight);
                    iframe.height =  height;
                }catch (ex){}
            }
            window.setInterval("reinitIframe3()", 200);
            </script>
        </iframe>
<h6 class="strong">评语明细</h6>
<iframe src="${ctx}/assess/dbJob/comment2?id=${id}" frameborder="0" id="printIframe4" name="printIframe" align="middle"  width="1000" height="500"
        onload="this.height=this.contentWindow.document.documentElement.scrollHeight">
        <script type="text/javascript">
            //动态获取被引用的页面的高度
            function reinitIframe4(){
                var iframe = document.getElementById("printIframe4");
                try{
                    var bHeight = iframe.contentWindow.document.body.scrollHeight;
                    var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                    var height = Math.max(bHeight, dHeight);
                    iframe.height =  height;
                }catch (ex){}
            }
            window.setInterval("reinitIframe4()", 200);
            </script>
        </iframe>

</div>



</table>
</body>

</html>