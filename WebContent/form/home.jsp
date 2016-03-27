<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRModel"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/slider1.css">
<link rel="stylesheet" type="text/css" href="css/slider2.css">

<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/modernizr.custom.79639.js"></script>
<script type="text/javascript" src="assets/js/jquery.slitslider.js"></script>
<script type="text/javascript" src="assets/js/jquery.ba-cond.min.js"></script>

<title>Puzzle Ring</title>

<%
PRModel prmodel = new PRModel();
prmodel.updateTodayProject();
%>

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
				<a href="home.html">Puzzle Ring</a>
			</div>

			<!-- Nav --> <nav id="nav">
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
						<h2>Hi. This is Puzzle Ring</h2>
						<p>
							You can realize your dream.<br>You can contribute someone's
							dream.
						</p>
					</div>
					<div class="5u 12u(medium)">
						<ul>
							<li><a data-toggle="modal" data-target="#squarespaceModal"
								class="button big icon fa-arrow-circle-right">Login</a></li>
							<li><a data-toggle="modal" data-target="#squarespaceModal"
								class="button alt big icon fa-question-circle">Join Us!</a></li>
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
						<section class="box feature"> <a href="#"
							class="image featured"><img src="images/pic02.jpg" alt="" /></a>
						<div class="inner">
							<header>
							<h2>An interesting title</h2>
							<p>This is also an interesting subtitle</p>
							</header>
							<p>Phasellus quam turpis, feugiat sit amet in, hendrerit in
								lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
						</div>
						</section>

					</div>
					<div class="4u 12u(medium)">

						<!-- Box -->
						<section class="box feature"> <a href="#"
							class="image featured"><img src="images/pic03.jpg" alt="" /></a>
						<div class="inner">
							<header>
							<h2>Oh, and finally ...</h2>
							<p>Here's another intriguing subtitle</p>
							</header>
							<p>Phasellus quam turpis, feugiat sit amet in, hendrerit in
								lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
						</div>
						</section>

					</div>
				</div>
			</div>
		</div>

		<!-- Main -->
		<div class="container">
			<!-- Slide Start-->
			<div class="demo-1">
				<div class="demo-1">

					<div id="slider" class="sl-slider-wrapper">

						<div class="sl-slider">

							<div class="sl-slide bg-1" data-orientation="horizontal"
								data-slice1-rotation="-25" data-slice2-rotation="-25"
								data-slice1-scale="2" data-slice2-scale="2">
								<div class="sl-slide-inner">
									<div class="deco" data-icon="P"></div>
									<h2>Puzzle Ring</h2>
									<blockquote>
										<p>
											You can realize your dream. </br> You can contribute someone's
											dream.
										</p>
										<cite>Software of Gachon Univ.</cite>
									</blockquote>
								</div>
							</div>

							<div class="sl-slide bg-2" data-orientation="vertical"
								data-slice1-rotation="10" data-slice2-rotation="-15"
								data-slice1-scale="1.5" data-slice2-scale="1.5">
								<div class="sl-slide-inner">
									<div class="deco" data-icon="S"></div>
									<h2>Show Your Idea</h2>
									<blockquote>
										<p>
											Write your idea after click "create project". </br> You should
											write in detail if you want wonderful project.
										</p>
										<cite> Click "create project"</cite>
									</blockquote>
								</div>
							</div>

							<div class="sl-slide bg-3" data-orientation="horizontal"
								data-slice1-rotation="3" data-slice2-rotation="3"
								data-slice1-scale="2" data-slice2-scale="1">
								<div class="sl-slide-inner">
									<div class="deco" data-icon="D"></div>
									<h2>Design project!</h2>
									<blockquote>
										<p>You can design your project directly if you can. Or
											not, you can wait other people to design project.</p>
										<cite> Click "create project - step 2" </cite>
									</blockquote>
								</div>
							</div>

							<div class="sl-slide bg-4" data-orientation="vertical"
								data-slice1-rotation="-5" data-slice2-rotation="25"
								data-slice1-scale="2" data-slice2-scale="1">
								<div class="sl-slide-inner">
									<div class="deco" data-icon="C"></div>
									<h2>Contribute project!</h2>
									<blockquote>
										<p>You can contribute to project and share code with
											others.</p>
										<cite>Click "upload code"</cite>
									</blockquote>
								</div>
							</div>

							<div class="sl-slide bg-5" data-orientation="horizontal"
								data-slice1-rotation="-5" data-slice2-rotation="10"
								data-slice1-scale="2" data-slice2-scale="1">
								<div class="sl-slide-inner">
									<div class="deco" data-icon="T"></div>
									<h2>Together!</h2>
									<blockquote>
										<p>I hope anyone makes own program. Realize your dream
											now!</p>
										<cite>Join us!!!</cite>
									</blockquote>
								</div>
							</div>
						</div>
						<!-- /sl-slider -->

						<nav id="nav-arrows" class="nav-arrows"> <span
							class="nav-arrow-prev">Previous</span> <span
							class="nav-arrow-next">Next</span> </nav>

						<nav id="nav-dots" class="nav-dots"> <span
							class="nav-dot-current"></span> <span></span> <span></span> <span></span>
						<span></span> </nav>

					</div>
					<!-- /slider-wrapper -->

				</div>
				<!-- Slide end-->

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
		<!-- Scripts -->

		<!--<script src="assets/js/jquery.min.js"></script> -->
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/util.js"></script>
		<!--[if lte IE 8]>
            <script src="assets/js/ie/respond.min.js"></script>
        <![endif]-->
		<script src="js/main.js"></script>
		<!-- Popup Modal Window - END -->
		<div class="alert fade modal text-center" id="squarespaceModal"
			tabindex="-1" role="dialog" aria-labelledby="modalLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">x</span> <span class="sr-only">Close</span>
						</button>
						<h3 class="modal-title" id="lineModalLabel">Modal Login
							Window</h3>
					</div>
					<div class="modal-body">
						<section class="loginform">
						<form action="" method="get">
							<div class="form-group">
								<label for="id">ID: </label> <input type="text"
									class="form-control txt" name="id" placeholder="Enter id">
							</div>
							<div class="form-group">
								<label for="password">Password: </label> <input type="password"
									class="form-control txt" name="password"
									placeholder="Enter Password">
							</div>
							<input type="submit" value="Login" formmethod="post"
								formaction="login.do"> <input type="submit"
								value="Signup" formmethod="get" formaction="join.do">
						</form>
						</section>
					</div>
				</div>
			</div>
		</div>
		<style>
.center {
	margin-top: 50px;
}

.modal-header {
	padding-bottom: 5px;
}

.modal-footer {
	padding: 0;
}

.modal-footer .btn-group button {
	height: 40px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
	border: none;
}

.modal-footer .btn-group:last-child>button {
	border-right: 0;
}
</style>
		<!-- Popup Modal Window - END -->
</body>
</html>