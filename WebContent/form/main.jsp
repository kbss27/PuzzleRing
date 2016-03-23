<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRCreateProject"%>
<%@ page import="com.dao.PRModel" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/loginmain.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">



 
 
<title>Insert title here</title>
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
					<a href="index.html">PuzzleRing</a>
				</h1>
			</div>

			<!-- Nav --> <nav id="nav">
			<ul>
				<li class="current"><a href="index.html">Welcome <%=(String)session.getAttribute("login")%>
				</a></li>
				<li><a href="#">Dropdown</a>
					<ul>
						<li><a href="#">Lorem ipsum dolor</a></li>
						<li><a href="#">Magna phasellus</a></li>
						<li><a href="#">Phasellus consequat</a>
							<ul>
								<li><a href="#">Lorem ipsum dolor</a></li>
								<li><a href="#">Phasellus consequat</a></li>
								<li><a href="#">Magna phasellus</a></li>
								<li><a href="#">Etiam dolore nisl</a></li>
							</ul></li>
						<li><a href="#">Veroeros feugiat</a></li>
					</ul></li>
				<li><a href="left-sidebar.html">Left Sidebar</a></li>
				<li><a href="right-sidebar.html">Right Sidebar</a></li>
				<li><a href="no-sidebar.html">No Sidebar</a></li>
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
					<div class="4u 12u(medium)">

						<!-- Box -->
						<section class="box feature">
						<div class="container" text-center>
							<div class="inner">
								<header>
								<h2>Today's new Project</h2>
								</header>
							</div>
							
							<% 
                            PRModel gettoday = new PRModel();
                            ArrayList<String> arr = gettoday.getTodayProject();
							%>
							
							<%for(int i = 0; i <arr.size(); i++){ %>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel11 text-right">
											<div>
												<span class="bigicon"><%=arr.get(i)%></span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<%} %>

						</div>
						</section>

					</div>
					<div class="4u 12u(medium)">

						<!-- Box -->
						<section class="box feature">
						<div class="container" text-center>
							<div class="inner">
								<header>
								<h2>Oldest Project</h2>
								</header>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel21 text-right">
											<div>
												<span class="bigicon">Elevator algorithm</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel22 text-right">
											<div>
												<span class="bigicon">ddddddddd</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel23 text-right">
											<div>
												<span class="bigicon">eeeeeeee</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center last">
										<div class="panel21 text-right">
											<div>
												<span class="big icon">ffffffff</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>

						</div>
						</section>
					</div>
					<div class="4u 12u(medium)">

						<!— Box —>
						<section class="box feature">
						<div class="container" text-center>
							<div class="inner">
								<header>
								<h2>Popular Project</h2>
								</header>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel31 text-right">
											<div>
												<span class="big icon">Programming Linked list</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel32 text-right">
											<div>
												<span class="big icon">ggggggggg</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center">
										<div class="panel33 text-right">
											<div>
												<span class="big icon">hhhhhhhh</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
							</div>
							<div class="row">
								<div class="col-sm-12 col-md-4"></div>
								<div class="col-sm-12 col-md-4 contents">
									<div class="panel text-center last">
										<div class="panel31 text-right">
											<div>
												<span class="big icon">iiiiiiiii</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-12 col-md-4"></div>
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
				<div class="3u 6u(medium) 12u$(small)">

					<!-- Links -->
					<section class="widget links">
					<h3>Random Stuff</h3>
					<ul class="style2">
						<li><a href="#">Etiam feugiat condimentum</a></li>
						<li><a href="#">Aliquam imperdiet suscipit odio</a></li>
						<li><a href="#">Sed porttitor cras in erat nec</a></li>
						<li><a href="#">Felis varius pellentesque potenti</a></li>
						<li><a href="#">Nullam scelerisque blandit leo</a></li>
					</ul>
					</section>

				</div>
				<div class="3u 6u$(medium) 12u$(small)">

					<!— Links —>
					<section class="widget links">
					<h3>Random Stuff</h3>
					<ul class="style2">
						<li><a href="#">Etiam feugiat condimentum</a></li>
						<li><a href="#">Aliquam imperdiet suscipit odio</a></li>
						<li><a href="#">Sed porttitor cras in erat nec</a></li>
						<li><a href="#">Felis varius pellentesque potenti</a></li>
						<li><a href="#">Nullam scelerisque blandit leo</a></li>
					</ul>
					</section>

				</div>
				<div class="3u 6u(medium) 12u$(small)">

					<!— Links —>
					<section class="widget links">
					<h3>Random Stuff</h3>
					<ul class="style2">
						<li><a href="#">Etiam feugiat condimentum</a></li>
						<li><a href="#">Aliquam imperdiet suscipit odio</a></li>
						<li><a href="#">Sed porttitor cras in erat nec</a></li>
						<li><a href="#">Felis varius pellentesque potenti</a></li>
						<li><a href="#">Nullam scelerisque blandit leo</a></li>
					</ul>
					</section>

				</div>
				<div class="3u 6u$(medium) 12u$(small)">

					<!— Contact —>
					<section class="widget contact last">
					<h3>Contact Us</h3>
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
						1234 Fictional Road<br /> Nashville, TN 00000<br /> (800)
						555-0000
					</p>
					</section>

				</div>
			</div>
			<div class="row">
				<div class="12u">
					<div id="copyright">
						<ul class="menu">
							<li>&copy; Untitled. All rights reserved</li>
							<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
						</ul>
					</div>
				</div>
			</div>
			</footer>
		</div>

	</div>
</body>
</html>