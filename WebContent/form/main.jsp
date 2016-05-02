<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRCreateProject"%>
<%@ page import="com.dao.PRModel"%>
<%@ page import="com.dao.PRGetModalInfo" %>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/addcss.css">
<link rel="stylesheet" type="text/css" href="assets/css/modalform.css">
<script src="assets/js/jquery.min.js"></script>

<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>

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
	$(document)
			.ready(
					function() {

						setInterval(
								function() {
									$
											.ajax({
												type : "POST",
												url : '/PRfinal/ajaxIssue.do',
												dataType : 'json',
												contentType : 'application/json; charset=utf-8',
												success : function(res) {

													var $table = $("#class_list");

													$table.empty();

													$
															.each(
																	res,
																	function(
																			idx,
																			value) {
																		var projectNameTag = "<tr><td><a href='showUploadList.do?project_name="+value.projectName+"'>"
																				+ value.projectName
																				+ "</a></td>";
																		var projectProgressTag = "<td><div class='progress'><div class='progress-bar progress-bar-striped active'role='progressbar' aria-valuenow='40' aria-valuemin='0'aria-valuemax='100' style='width: {{pro}}'>{{pro}}</div></div></td>"
																		var projectProgressTag = projectProgressTag
																				.replace(
																						/{{pro}}/gi,
																						value.projectProgress
																								+ "%")

																		var projectStatus;
																		if (value.projectProgress === 0) {
																			projectStatus = "<td>TODO</td></tr>";
																		} else if (value.projectProgress === 50) {
																			projectStatus = "<td>PROGRESS</td></tr>";
																		} else {
																			projectStatus = "<td>DONE</td></tr>";
																		}

																		$table
																				.append(projectNameTag
																						+ projectProgressTag
																						+ projectStatus);

																	});
												},
												error : function(req, st, e) {

												}
											});

								}, 10000);

					});
</script>

<title>main</title>
</head>

<%
	String id = (String) request.getAttribute("id");

	if (id != null) {
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
				<li class="current"><a href="main.do"><i
						class="fa fa-2x fa-fw fa-home text-warning"></i></a></li>
				<li><a href="left-sidebar.html">Left Sb</a></li>
				<li><a href="right-sidebar.html">Right Sb</a></li>
				<li><a href="no-sidebar.html">No Sb</a></li>
				<li><a href="#" onclick="goback()"><i
						class="fa fa-2x fa-angle-left fa-fw"></i></a></li>
				<li><a href="logout.do" onclick="logout()"><i
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
										<h3>Board</h3>
									</div>
									<!-- /.col-lg-12 -->
								</div>
								<!-- /.row -->
								<div class="row">
									<div class="col-lg-3 col-md-6">

										<div class="displaystyle-fullborder displaystyle-danger">
											<div class="panel-heading">
												<div class="row">
													<div>
														<i class="fa fa-tasks fa-5x"></i>
													</div>
													<%
														PRCreateProject gettotal = new PRCreateProject();
														String total_id = (String) session.getAttribute("login");
														int total = gettotal.getTotal(total_id);
													%>
													<div>
														<div class="huge"><%=total%></div>
														<div>New Projects</div>
													</div>
												</div>
											</div>
											<a href="#">
												<div class="panel-footer">
													<span><a href="showproject.do?id=<%=total_id%>">View
															Details </a><i class="fa fa-arrow-circle-right"></i></span>
													<div class="clearfix"></div>
												</div>
											</a>
										</div>

									</div>
									<div class="col-lg-3 col-md-6">

										<div class="displaystyle-fullborder displaystyle-success">
											<div class="panel-heading">

												<i class="fa fa-comments fa-5x"></i>

											</div>
											<a href="#"> <span><a
													href="createproject_process.do">Create
														Projects </a> <i class="fa fa-arrow-circle-right"></i></span>

											</a>
										</div>

									</div>

								</div>
							</div>
						</form>
						</section>
					</div>
					<div class="5u 12u(medium)">
						<ul style="text-align: center; margin-top: 20px;">

							<p style="text-align: center; margin-top: 20px;">
								<i class="fa fa-user" style="font-size: 100px;"></i>
							</p>

							<div class="login_id"
								style="text-align: center; margin-top: 20px;">
								<h5>
									Welcome
									<%=(String) session.getAttribute("login")%></h5>
							</div>

							<input type="submit" value="Settings" formmethod="get"
								formaction="{% url 'setting' %}">

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
					<div class="12u 12u(medium)">
						<!-- Box -->
						<section class="box feature">
						<div class="container" text-center>
							<div class="inner">
								<header>
								<h2>
									<a href="#progressModal" data-toggle="modal">Project
										Progress</a>
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
	</div>
	</div>

	<!-- Start of project progress modal -->

	<div class="alert fade modal text-center" id="progressModal"
		tabindex="-1" role="dialog" aria-labelledby="modalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">x</span> <span class="sr-only">Close</span>
					</button>
					<h3 class="modal-title" id="lineModalLabel">
						<i class="fa fa-angle-right">Project Progress </i>
					</h3>
				</div>
				<div class="modal-body">
					<div class="row" style="text-align: center;">
						<div class="4u 12u(mobile)">

							<!-- Box #1 -->
							<section> <header style="border-bottom: 2px dotted red">
							<h3>
								<i class="fa fa-bullhorn"></i> To Do
							</h3>
							</header>
							
							<%PRGetModalInfo modal = new PRGetModalInfo();
								String tmpId = (String) session.getAttribute("login");
								ArrayList<String> todo = modal.getTodo(tmpId); 
								ArrayList<String> inprogress = modal.getInprogress(tmpId);
								ArrayList<String> done = modal.getDone(tmpId);
								
								for(int i = 0; i<todo.size(); i++){ %>
							<div
								class="row col-sm-12 displaystyle-leftborder displaystyle-danger">
								<a href="showUploadList.do?project_name=<%=todo.get(i)%>"><strong><%=todo.get(i)%></strong></a>
							</div>
							<%} %>							
							</section>

						</div>
						<div class="4u 12u(mobile)">

							<!-- Box #2 -->
							<section> <header
								style="border-bottom: 2px dotted orange">
							<h3>
								<i class="fa fa-archive"></i> In Progress
							</h3>
							</header>
							<%for(int i = 0; i<inprogress.size(); i++){ %>
							<div
								class="row col-sm-12 displaystyle-leftborder displaystyle-success">
								<a href="showUploadList.do?project_name=<%=inprogress.get(i)%>"><strong><%=inprogress.get(i)%></strong></a>
							</div>
							<%} %>
							</section>

						</div>
						<div class="4u 12u(mobile)">

							<!-- Box #3 -->
							<section> <header
								style="border-bottom: 2px dotted green">
							<h3>
								<i class="fa fa-bookmark"></i> Done
							</h3>
							</header>
							<%for(int i = 0; i<done.size(); i++){ %>
							<div
								class="row col-sm-12 displaystyle-leftborder displaystyle-success">
								<a href="showUploadList.do?project_name=<%=done.get(i)%>"><strong><%=done.get(i)%></strong></a>
							</div>
							<%} %>
							</section>

						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
	<!--  End of project progress modal -->

	<style>
.displaystyle-fullborder {
	padding: 15px;
	margin: 5px;
	background-color: #FFFFFF;
	border: 3px solid #7f7f84;
	margin-bottom: 10px;
	box-shadow: 5px 7px 7px 5px rgba(0, 0, 0, 0.19), 10px 12px 20px 10px
		rgba(0, 0, 0, 0.19);
}

.displaystyle-leftborder {
	margin: 1px;
	background-color: #FFFFFF;
	border-left: 9px solid;
	border-right: 1px solid;
	border-bottom: 1px solid;
	border-top: 1px solid;
}

.displaystyle-sm {
	padding: 10px;
	font-size: 80%;
}

.displaystyle-lg {
	padding: 35px;
	font-size: large;
}

.displaystyle-success {
	border-color: #80D651;
}

.displaystyle-success>strong {
	color: #80D651;
}

.displaystyle-info {
	border-color: #45ABCD;
}

.displaystyle-info>strong {
	color: #45ABCD;
}

.displaystyle-warning {
	border-color: #FEAF20;
}

.displaystyle-warning>strong {
	color: #FEAF20;
}

.displaystyle-danger {
	border-color: #d73814;
}

.displaystyle-danger>strong {
	color: #d73814;
}
</style>
</body>


</html>