<%@ page import="com.vo.Project_overview"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css">
<!-- <script src="assets/js/jquery.min.js"></script>



<link rel="stylesheet" href="assets/css/addcss.css">


-->
<title>Check Project!</title>
<script type="text/javascript">
function goback() { //go to back page
	history.back();
}
function goCreateCM()
{
	var form = document.getElementById("createCM");
	form.action = "createClassMethod.do";
	form.submit();
	
	}
</script>
<script type="text/javascript">
$(document).ready(function() {	

var id = '#dialog';
	
//Get the screen height and width
var maskHeight = $(document).height();
var maskWidth = $(window).width();
	
//Set heigth and width to mask to fill up the whole screen
$('#mask').css({'width':maskWidth,'height':maskHeight});

//transition effect
$('#mask').fadeIn(500);	
$('#mask').fadeTo("slow",0.9);	
	
//Get the window height and width
var winH = $(window).height();
var winW = $(window).width();
              
//Set the popup window to center
$(id).css('top',  winH/2-$(id).height()/2);
$(id).css('left', winW/2-$(id).width()/2);
	
//transition effect
$(id).fadeIn(2000); 	
	
//if close button is clicked
$('.window .close').click(function (e) {
//Cancel the link behavior
e.preventDefault();

$('#mask').hide();
$('.window').hide();
});

//if mask is clicked
$('#mask').click(function () {
$(this).hide();
$('.window').hide();
});
	
});
 </script>
<style>
#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9000;
	background-color: #000;
	display: none;
}

#boxes .window {
	position: absolute;
	left: 0;
	top: 0;
	width: 440px;
	height: 200px;
	display: none;
	z-index: 9999;
	padding: 20px;
	border-radius: 15px;
	text-align: center;
}

#boxes #dialog {
	width: 750px;
	height: 300px;
	padding: 10px;
	background-color: #ffffff;
	font-family: 'Segoe UI Light', sans-serif;
	font-size: 15pt;
}

#popupfoot {
	font-size: 16pt;
	position: absolute;
	bottom: 0px;
	width: 250px;
	left: 250px;
}
</style>
</head>
<body>

	<div id="boxes">

		<div id="dialog" class="window">
			<h3 class="modal-title" id="lineModalLabel">
				<h3 style="color: orange;">Didn't complete create project</h3>
			</h3>
			<div class="row">
				<h4>Didn't complete create project yet. Do you want to complete
					to create project?</h4>
				<div style="float: right;">
					<form role="form" method="get" id="createCM">
					<%Project_overview project = (Project_overview)request.getAttribute("project_overview");%>
					
					<input type="hidden" value="<%=project.getProject_name()%>" name="project_name" id="project_name">
					
						<input type="button" value="Yes" onClick="goCreateCM();" />
						<input type="button" value="No" onClick="goback();"/>
					</form>
				</div>
			</div>

		</div>

		<div id="mask"></div>

	</div>

</body>
</html>