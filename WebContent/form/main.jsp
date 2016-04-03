<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRCreateProject"%>
<%@ page import="com.dao.PRModel" %>
<%@ page import="java.util.ArrayList" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/addcss.css">

<script src="assets/js/jquery.min.js"></script>

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
</script>

<script>
      $(document).ready(function(){ 
         
         setInterval(function(){
            $.ajax({
               type : "POST",
               url : '/PRfinal/ajaxIssue.do',
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

<title>main</title>
</head>

<%

String id = (String)request.getAttribute("id");

if(id!=null){
	session.setAttribute("login", id);
}

%>

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
				<li class="current"><a href="index.html">Welcome <%=(String)session.getAttribute("login")%>
				</a></li>
				<li><a href="#">Dropdown</a>
					<ul>
						<li class="current"><a href="main_page.do"><i
								class="fa fa-2x fa-fw fa-home text-warning"></i></a></li>
						<li><a href="left-sidebar.html">Left Sb</a></li>
						<li><a href="right-sidebar.html">Right Sb</a></li>
						<li><a href="no-sidebar.html">No Sb</a></li>
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
			<div id="banner" class="box container">
				<div class="row">
					<div class="7u 12u(medium)">
						<section class="index_info">
						<form name="my project" action="index_submit" method="get"
							accept-charset="utf-8">
							<div id="page-wrapper">
								<div class="row">
									<div class="col-lg-12">
										<h1 class="page-header">Board</h1>
									</div>
									<!-- /.col-lg-12 -->
								</div>
								<!-- /.row -->
								<div class="row">
									<div class="col-lg-3 col-md-6">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-comments fa-5x"></i>
													</div>
													<% 
                                                    PRCreateProject gettotal = new PRCreateProject();
                                                    String total_id = (String)session.getAttribute("login");
													int total = gettotal.getTotal(total_id);
													%>
													<div class="col-xs-9 text-right">
														<div class="huge"><%=total%></div>
														<div>New Projects</div>
													</div>
												</div>
											</div>
											<a href="#">
												<div class="panel-footer">
													<span class="pull-left"><a
														href="showproject.do?id=<%=total_id%>">View Details</a></span> <span
														class="pull-right"><i
														class="fa fa-arrow-circle-right"></i></span>
													<div class="clearfix"></div>
												</div>
											</a>
										</div>
									</div>
									<div class="col-lg-3 col-md-6">
										<div class="panel panel-success">
											<div class="panel-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-tasks fa-5x"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div class="huge">0</div>
														<div>New Tasks!</div>
													</div>
												</div>
											</div>
											<a href="#">
												<div class="panel-footer">
													<span class="pull-left">View Details</span> <span
														class="pull-right"><i
														class="fa fa-arrow-circle-right"></i></span>
													<div class="clearfix"></div>
												</div>
											</a>
										</div>
									</div>
									<div class="col-lg-3 col-md-6">
										<div class="panel panel-warning">
											<div class="panel-heading">
												<div class="row">
													<div class="col-xs-3">
														<i class="fa fa-shopping-cart fa-5x"></i>
													</div>
													<div class="col-xs-9 text-right">
														<div class="huge">0</div>
														<div>New Orders!</div>
													</div>
												</div>
											</div>
											<a href="#">
												<div class="panel-footer">
													<span class="pull-left">View Details</span> <span
														class="pull-right"><i
														class="fa fa-arrow-circle-right"></i></span>
													<div class="clearfix"></div>
												</div>
											</a>
										</div>
									</div>
								</div>
							</div>
						</form>
						</section>
					</div>
					<div class="5u 12u(medium)">
						<ul>

							<div class="login_id">
								<h5>
									Welcome
									<%=(String)session.getAttribute("login")%></h5>
							</div>
							<input type="submit" value="Settings" formmethod="get"
								formaction="{% url 'setting' %}">
							<input type="submit" value="Log out" formmethod="get"
								formaction="{% url 'home' %}">
							<input type="button" value="Create Project"
								onclick="location.href='createproject_process.do'">

							<!--<li><a href="#" class="button big icon fa-arrow-circle-right">Join</a></li>
                        <li><a href="#" class="button alt big icon fa-question-circle">Login</a></li>-->
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- Features -->
      <div id="features-wrapper">
         <div class="container">
            <div class="row">
              
               <div class="4u 12u(medium)" style="width: 1220px;">

                  <!-- Box -->
                  <section class="box feature">
                  <div style="height: 450px;" class="container" text-center>
                     <div class="inner">
                        <header>
                        <h2>
                           <a href="">Issue Tracking</a>
                        </h2>
                        </header>

                        <div  style="width: 1120px; height: 300px; overflow: scroll;">
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
      </div>

		<!-- Main -->
		<div id="main-wrapper">
			<div class="container">
				<div class="row 200%">
					<div class="4u 12u(medium)">

						<!-- Sidebar -->
						<div id="sidebar">
							<section class="widget thumbnails">
							<h3>Interesting stuff</h3>
							<div class="grid">
								<div class="row 50%">
									<div class="6u">
										<a href="#" class="image fit"><img src="images/pic04.jpg"
											alt="" /></a>
									</div>
									<div class="6u">
										<a href="#" class="image fit"><img src="images/pic05.jpg"
											alt="" /></a>
									</div>
									<div class="6u">
										<a href="#" class="image fit"><img src="images/pic06.jpg"
											alt="" /></a>
									</div>
									<div class="6u">
										<a href="#" class="image fit"><img src="images/pic07.jpg"
											alt="" /></a>
									</div>
								</div>
							</div>
							<a href="#" class="button icon fa-file-text-o">More</a> </section>
						</div>

					</div>
					<div class="8u 12u(medium) important(medium)">

						<!-- Content -->
						<div id="content">
							<section class="last">
							<h2>So what's this all about?</h2>
							<p>
								This is <strong>Verti</strong>, a free and fully responsive
								HTML5 site template by <a href="http://html5up.net">HTML5 UP</a>.
								Verti is released under the <a href="http://html5up.net/license">Creative
									Commons Attribution license</a>, so feel free to use it for any
								personal or commercial project you might have going on (just
								don't forget to credit us for the design!)
							</p>
							<p>Phasellus quam turpis, feugiat sit amet ornare in,
								hendrerit in lectus. Praesent semper bibendum ipsum, et
								tristique augue fringilla eu. Vivamus id risus vel dolor auctor
								euismod quis eget mi. Etiam eu ante risus. Aliquam erat
								volutpat. Aliquam luctus mattis lectus sit amet phasellus quam
								turpis.</p>
							<a href="#" class="button icon fa-arrow-circle-right">Continue
								Reading</a> </section>
						</div>

					</div>
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
								This is <strong>Puzzle Ring</strong>, a free and fully
								responsive web site made by department of software, Gachon Univ.
								Puzzle Ring is released under the Creative Commons Attribution
								license, so feel free to use it for any personal or commercial
								project you might have going on (just don't forget to credit us
								for the design!)
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
	</div>
	</div>
</body>
</html>