<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="UTF-8" />
	<title>Document</title>
	<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
	<link href="https://cdn.bootcss.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.bootcss.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"></script>
	<style>
		.view .count_box{
			width:100%;
			height:100%;
			background: rgba(0,0,0,0.5)!important;
			position:absolute;
			top:0;
			right: 0;
			left:0;
			bottom:0;
			display: none;
		}
		.view .count_box{
			width: 300px;
			height:300px;
			position: absolute;
			top:50%;
			left:50%;
			margin-left:-50%;
			margin-top: -50%;
			margin-left: -150px;
			margin-top: -150px;
			background: red;
			display: none;
		}
		.view .modal_set{
			width: 100px;
			height: 100px;
			background: red;
			display: block;
		}
		.view #btn2{
		    padding: 10px;
		    background: #337ab7;
		    cursor: pointer;
		    color: #fff;
		    font-size: 14px;
		}
		.view .btn-icon{
			cursor:none!important;
		}
		
	</style>
	
</head>
<body>

<!-- Modal -->
	<div class="container view">  
          <!--   <button class="btn btn-primary" data-toggle='modal' data-target='#show'>自定义统计</button>   -->
  
            <div class="modal fade  " id='show' >  
                <div class="modal-dialog  modal-lg" role="document">
				    <div class="modal-content">
					    <div class="modal-body">
					        <div class='count_one'>
					        	<!--<button >分类查询项</button>-->
					        	<select  multiple name="right" id="right" size="8" style='width:200px'  
								  ondblclick="moveOption(document.getElementById('right'), document.getElementById('right_left'))">  
								  <option id="btn2" >选择查询显示项</option>
								</select>  
								<select  multiple name="right" id="right_left" size="8" style='width:200px'  
								  ondblclick="moveOption(document.getElementById('right_left'), document.getElementById('right'))">  
								  <option id="btn2" class="btn-icon">选择查询统计项</option>
								</select>  
					        </div>
					    </div>
				        <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="group()">关闭</button>
				        </div>
				    </div>
			  	</div>
            </div>  
  
          <form:form id="inputForm" modelAttribute="viewJob" action="${ctx}/assess/viewJob/list" method="post" class="form-horizontal">
          <div class="control-group" style="display: none;">
			<label class="control-label">科目：</label>
			<div class="controls">
				<form:input path="def1" id="courseId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group" style="display: none;">
			<label class="control-label">教师：</label>
			<div class="controls">
				<form:input path="def2" id="teacherId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
          </form:form>
          <div class="modal fade  " id='show2'>  
                <div class="modal-dialog  modal-lg" role="document">
				    <div class="modal-content">
					    <div class="modal-body">
					        <select name="" size="15" style='width:200px' id='left' ondblclick="moveOption(document.getElementById('left'), document.getElementById('right'))" >
					        </select>
					    </div>
				        <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="List()">关闭</button>
				        </div>
				    </div>
			  	</div>
        	</div> 
          
          
  
            
	
	
	
	
	<script type="text/javascript">
	    var data="";
	
		$(document).ready(function(){
			 $("#btn2").click(function(){  
		        	$("#show2").modal("show");  
		       });
			 $('#show').modal({
			        keyboard: true
			    })
			var ll="${list}";
			var series =  ${fns:toJson(list)};
			console.log(series);
			var opt = "<option value=''>选择显示列表</option>";
			for(var i in series){
				opt += "<option value='"+series[i]+"'>" + series[i] + "</option>"
			}
			document.getElementById("left").innerHTML = opt;
		});
		
		function moveOption(obj1, obj2){  
			
	             for(var i = obj1.options.length - 1 ; i >= 1 ; i--)  
	             {  
	                 if(obj1.options[i].selected)  
	                 {  
	                  if(obj1.options[i].value !=''){
	                	data=data+","+obj1.options[i].value;
	                    var opt = new Option(obj1.options[i].text,obj1.options[i].value);  
	                    opt.selected = true;  
	                    obj2.options.add(opt);  
	                    obj1.remove(i);  
	                  }
	                }  
	             }  
	             
	             console.log(data);
	        } 
		
		
		function List(){
			$("#courseId").val(data);
			data="";
		}
		
		function group(){
			data="";
			var gg=document.getElementById("right_left").options;
			for(var i=1;i<gg.length;i++){
				data=data+","+gg[i].value;
			}
			console.log("接:"+data);
			$("#teacherId").val(data);
		    $("#inputForm").submit();
			
		}
	    //$('#show').modal({backdrop: 'static', keyboard: false});    
	</script>
	
</body>
</html>