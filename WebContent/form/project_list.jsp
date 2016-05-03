<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRModel"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="assets/css/main.css">

<link rel="stylesheet" type="text/css" href="assets/css/modalform.css">
<link rel="stylesheet" href="assets/css/addcss.css">

<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/modernizr.custom.79639.js"></script>

<script type="text/javascript" src="assets/js/jquery.ba-cond.min.js"></script>

<script>
      $(document).ready(function(){ 
         
         setInterval(function(){
            $.ajax({
               type : "POST",
               url : '/PRfinal/ajaxIssuehome.do',
               dataType : 'json',
               contentType : 'application/json; charset=utf-8',
               success : function(res) {
                  
                  var $table = $("#class_list");
                  
                  $table.empty();
               
               
                  $.each(res, function(idx, value){
                     var projectNameTag = "<tr><td>" + value.projectName + "</td>";
                     var projectProgressTag = "<td><div class='progress'><div class='progress-bar progress-bar-striped active'role='progressbar' aria-valuenow='40' aria-valuemin='0'aria-valuemax='100' style='width: {{pro}}'>{{pro}}</div></div></td>"
                     var projectProgressTag = projectProgressTag.replace(/{{pro}}/gi, value.projectProgress +"%")
                     
                     var projectStatus;
                     if(value.projectProgress === 0){
                        projectStatus = "<td>TODO</td></tr>";
                     }else if(value.projectProgress === 50){
                        projectStatus = "<td>PROGRESS</td></tr>";
                     }else {
                        projectStatus = "<td>DONE</td></tr>";
                     }
                     
                     $table.append(projectNameTag + projectProgressTag + projectStatus);
                     
                  });
               },
               error : function(req, st, e) {
            
               }
            });
            
         },10000);
          
      });
</script>

<title>Project List</title>

<%
//PRModel prmodel = new PRModel();
//prmodel.updateTodayProject();
%>
<script type="text/javascript">
   function goJoin() {
      var form = document.getElementById("joinForm");
      form.action = "joinprocess.do";
      form.submit();
   }
</script>
<script type="text/javascript">
   //back, foward, logout button event function
   function goback() { //go to back page
      history.back();
   }
   function forward() { //go to prior page
      history.forward();
   }
   function logout() {

   }

   //Slide functino
   $(function() {

      var Page = (function() {

         var $navArrows = $('#nav-arrows'), $nav = $('#nav-dots > span'), slitslider = $(
               '#slider').slitslider({
            onBeforeChange : function(slide, pos) {

               $nav.removeClass('nav-dot-current');
               $nav.eq(pos).addClass('nav-dot-current');

            }
         }),

         init = function() {

            initEvents();

         }, initEvents = function() {

            // add navigation events
            $navArrows.children(':last').on('click', function() {

               slitslider.next();
               return false;

            });

            $navArrows.children(':first').on('click', function() {

               slitslider.previous();
               return false;

            });

            $nav.each(function(i) {

               $(this).on('click', function(event) {

                  var $dot = $(this);

                  if (!slitslider.isActive()) {

                     $nav.removeClass('nav-dot-current');
                     $dot.addClass('nav-dot-current');

                  }

                  slitslider.jump(i + 1);
                  return false;

               });

            });

         };

         return {
            init : init
         };

      })();

      Page.init();

   });
</script>


</head>
<body class="homepage">
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header-wrapper">
			<header id="header" class="container"> <!-- Logo -->
			<div id="logo">
				<h1>
					<a href="main.do">Puzzle Ring</a>
				</h1>
			</div>

			<!-- Nav --> <nav id="nav">
			<ul>
				<li class="current"><a href="main.do"><i
						class="fa fa-2x fa-fw fa-home text-warning"></i></a></li>
			<li><a href="project_list">Projects</a></li>
				<li><a href="community">Community</a></li>
				<li><a href="#" onclick="goback()"><i
						class="fa fa-2x fa-angle-left fa-fw"></i></a></li>
				<li><a href="logout.do"><i
						class="fa fa-2x fa-fw fa-unlock text-success"></i></a></li>
				<li><a href="#" onclick="foward()"><i
						class="fa fa-2x fa-angle-right fa-fw"></i></a></li>
			</ul>
			</nav> </header>
		</div>


		<!-- Banner -->
		<div id="banner-wrapper">
	////banner
		</div>
		<br>
		<!-- Main -->
		<div class="container">
		///main container

			</div>

			<!-- Features -->
			<div id="features-wrapper">
				<div class="container">
					<div class="row">
						<section class="box feature">
						<div class="container" text-center>
							<div class="inner">
								<header>
								<h2>
									<a href="">Project List</a>
								</h2>
								</header>

								<div class="scroll">
									<table style="border: 1px;" width="100%" cellspacing="0"
										cellpadding="0" align="middle" id="class_list">
									</table>
								</div>

							</div>
						</div>
						</section>
					</div>
				</div>
			</div>


			<!-- Footer -->
			<div id="footer-wrapper">
				<footer id="footer" class="container">
				<div class="row">
					<div class="8u 12u(medium) important(medium)">
						<section class="last">
						<h3>So what's this all about?</h3>
						<p>
							This is <strong>Puzzle Ring</strong>, a free and fully responsive
							web site made by department of software, Gachon Univ. Puzzle Ring
							is released under the Creative Commons Attribution license, so
							feel free to use it for any personal or commercial project you
							might have going on (just don't forget to credit us for the
							design!)
						</p>
						</section>
					</div>
					<div class="4u 12u(medium)">
						<!-- Contact -->
						<section class="widget contact last">
						<h3>
							Contact Us <i class="fa fa-1x fa-envelope fa-fw text-danger"></i>
						</h3>
						<ul>
							<li><a href="#" class="icon fa-twitter"><span
									class="label">Twitter</span></a></li>
							<li><a href="#" class="icon fa-facebook"><span
									class="label">Facebook</span></a></li>
							<li><a href="#" class="icon fa-instagram"><span
									class="label">Instagram</span></a></li>
							<li><a href="#" class="icon fa-dribbble"><span
									class="label">Dribbble</span></a></li>
							<li><a href="#" class="icon fa-pinterest"><span
									class="label">Pinterest</span></a></li>
						</ul>
						<p>
							Gachon University <br>Gyeonggi-do, Korea <br>(031)
							555-0000
						</p>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="12u">
						<div id="copyright">
							<ul class="menu">
								<li>© Puzzle Ring. All rights reserved</li>
								<li>Design: Software of Gachon Univ.</li>
							</ul>
						</div>
					</div>
				</div>
				</footer>

			</div>

</body>
</html>