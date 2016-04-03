<%@page import="com.controller.PRController_showUploadList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRCreateProject"%>
<%@ page import="com.dao.PRModel"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.vo.UploadFile"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Project Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--  <link rel="stylesheet" type="text/css" href="assetscss/loginmain.css"> -->

<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/addcss.css">
<link href="assets/css/fileinput.css" media="all" rel="stylesheet"
	type="text/css" />
<link href="assets/css/uploadcss.css" rel="stylesheet">


<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /> <![endif]-->
<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/fileinput.js" type="text/javascript"></script>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/modernizr.custom.79639.js"></script>
<script type="text/javascript" src="assets/js/jquery.slitslider.js"></script>
<script type="text/javascript" src="assets/js/jquery.ba-cond.min.js"></script>

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
<script type="text/javascript">
	function addRow(TableID) // 테이블 동적 생성
	{
	}
	$(document).ready(
			function() {
				// 옵션추가 버튼 클릭시
				$("#addItemBtn").click(
						function() {
							// item 의 최대번호 구하기
							var lastItemNo = $("#tableid tr:last")
									.attr("class").replace("item", "");

							var newitem = $("#tableid tr:eq(1)").clone();
							newitem.removeClass();
							newitem.find("td:eq(0)").attr("rowspan", "1");
							newitem.addClass("item"
									+ (parseInt(lastItemNo) + 1));

							$("#tableid").append(newitem);
						});

				// 항목추가 버튼 클릭시
				$(".addBtn").live("click", function() {
					var clickedRow = $(this).parent().parent();
					var cls = clickedRow.attr("class");

					// tr 복사해서 마지막에 추가
					var newrow = clickedRow.clone();
					newrow.find("td:eq(0)").remove();
					newrow.insertAfter($("#tableid ." + cls + ":last"));

					// rowspan 조정
					resizeRowspan(cls);
				});

				// 삭제버튼 클릭시
				$(".delBtn").live(
						"click",
						function() {
							var clickedRow = $(this).parent().parent();
							var cls = clickedRow.attr("class");

							// 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다.
							if (clickedRow.find("td:eq(0)").attr("rowspan")) {
								if (clickedRow.next().hasClass(cls)) {
									clickedRow.next().prepend(
											clickedRow.find("td:eq(0)"));
								}
							}

							clickedRow.remove();

							// rowspan 조정
							resizeRowspan(cls);
						});

				// cls : rowspan 을 조정할 class ex) item1, item2, ...
				function resizeRowspan(cls) {
					var rowspan = $("." + cls).length;
					$("." + cls + ":first td:eq(0)").attr("rowspan", rowspan);
				}
			});
</script>
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
				<li class="current"><a href="main.do"><i
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
					<div class="container" text-center>
						<div>
							<header>
							<h2 style="text-align: center;">Project Name</h2>
							</header>
						</div>
						<p>project에 대한 설명을 불러올것.</p>
						<div id="current_prj">
							<table id="tableid">
								<tr>
									<th colspan="2">등록된 클래스 목록</th>

								</tr>
								<tr class="item1">
									<td>Class name</td>

									<td style="width: 15%;"><a data-toggle="modal"
										data-target="#uploadModal" class="button">upload</a></td>
									<td style="width: 15%;"><a data-toggle="modal"
										data-target="#downloadModal" class="button">download</a></td>

								</tr>

							</table>
							<button id="addItemBtn">클래스추가</button>
						</div>
					</div>
				</div>
				<br>
			</div>
		</div>

		<!-- Features -->
		<div id="features-wrapper">
			<div class="container">
				<div class="row">
					<div class="12u 12u(medium)">
						<section class="box feature">
						<div class="container" text-center>
							<div class="inner">
								<header>
								<h2>Issue Tracker</h2>
								</header>
								<div class="scroll">
									<ul class="timeline">
										<li>
											<!---Time Line Element--->
											<div class="timeline-badge up">
												<i class="fa fa-thumbs-up"></i>
											</div>
											<div class="timeline-panel">
												<div class="timeline-heading">
													<h4 class="timeline-title">Time Line Entry #1</h4>
												</div>
												<div class="timeline-body">
													<!---Time Line Body&Content--->
													<p>Time line content is placed here...</p>
												</div>
											</div>
										</li>
										<li>
											<!---Time Line Element--->
											<div class="timeline-badge down">
												<i class="fa fa-thumbs-down"></i>
											</div>
											<div class="timeline-panel">
												<div class="timeline-heading">
													<h4 class="timeline-title">Time Line Entry #2</h4>
												</div>
												<div class="timeline-body">
													<!---Time Line Body&Content--->
													<p>Time line content is placed here...</p>
													<p>And some more Time line content</p>
												</div>
											</div>
										</li>
										<li>
											<!---Time Line Element--->
											<div class="timeline-badge neutral">
												<i class="fa fa-navicon"></i>
											</div>
											<div class="timeline-panel">
												<div class="timeline-heading">
													<h4 class="timeline-title">Time Line Entry #3</h4>
												</div>
												<div class="timeline-body">
													<!---Time Line Body&Content--->
													<p>Time line content is placed here...</p>
													<p>This appears to be a neutral time line enty...</p>
												</div>
											</div>
										</li>
										<li>
											<!---Time Line Element--->
											<div class="timeline-badge down">
												<i class="fa fa-thumbs-down"></i>
											</div>
											<div class="timeline-panel">
												<div class="timeline-heading">
													<h4 class="timeline-title">Time Line Entry #4</h4>
												</div>
												<div class="timeline-body">
													<!---Time Line Body&Content--->
													<p>Time line content is placed here...</p>
													<p>And some more Time line content</p>
												</div>
											</div>
										</li>

										<li>
											<!---Time Line Element--->
											<div class="timeline-badge up">
												<i class="fa fa-thumbs-up"></i>
											</div>
											<div class="timeline-panel">
												<div class="timeline-heading">
													<h4 class="timeline-title">Time Line Entry #5</h4>
												</div>
												<div class="timeline-body">
													<!---Time Line Body&Content--->
													<p>Time line content is placed here...</p>
												</div>
											</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
						</section>
					</div>
				</div>
			</div>
		</div>
		<!-- end of timeline -->



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


	<!-- Scripts -->

	<!--<script src="assets/js/jquery.min.js"></script> -->
	<script src="assets/js/jquery.dropotron.min.js"></script>
	<script src="assets/js/skel.min.js"></script>
	<script src="assets/js/util.js"></script>
	<!--[if lte IE 8]>
            <script src="assets/js/ie/respond.min.js"></script>
        <![endif]-->
	<script src="assets/js/main.js"></script>
	<!-- Popup Modal Window - END -->
	<!-- Start of upload modal -->
	<div class="alert fade modal text-center" id="uploadModal"
		tabindex="-1" role="dialog" aria-labelledby="modalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">x</span> <span class="sr-only">Close</span>
					</button>
					<h3 class="modal-title" id="lineModalLabel">Upload Code File</h3>
				</div>
				<div class="modal-body">
					<form action="form/fileupload_form.jsp" method="post"
						enctype="multipart/form-data">
						<input type="file" id="file" class="file" name="uploadFile"
							id="uploadFile"> <br>
						<button type="submit" class="btn btn-primary" name="upload">Submit</button>
						<button type="reset" class="btn btn-default">Reset</button>
					</form>
					<hr>

				</div>
			</div>
		</div>
	</div>
	<!-- End of upload modal -->

	<!-- Start of download modal -->
	<div class="alert fade modal text-center" id="downloadModal"
		tabindex="-1" role="dialog" aria-labelledby="modalLabel"
		aria-hidden="true">
		<div id="downModal" class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">x</span> <span class="sr-only">Close</span>
					</button>
					<h3 class="modal-title" id="lineModalLabel">Source Code List</h3>
				</div>
				<div class="modal-body">
					<table id="fileListTable">
						<theader>
						<tr>
							<th><h4>Project Name</h4></th>
							<th><h4>Class Name</h4></th>
							<th><h4>File Name</h4></th>
							<th><h4>Uploader</h4></th>
							<th><h4>Upload Date</h4></th>
							<th><h4>download</h4></th>
						</tr>
						</theader>
						<tbody>
							<%
					ArrayList<UploadFile> lists = (ArrayList<UploadFile>)request.getAttribute("lists");
					System.out.println(lists.size());
					for (int i = 0; i < lists.size(); i++) {
					%>

							<tr>
								<td><%=lists.get(i).getProjectName()%></td>
								<td><%=lists.get(i).getClassName()%></td>
								<td><%=lists.get(i).getFileName()%></td>
								<td><%=lists.get(i).getId()%></td>
								<td><%=lists.get(i).getDate()%></td>
								<td><a
									href="form/downloadFile.jsp?filename=<%=lists.get(i).getFileName()%>"><span
										class="glyphicon glyphicon-save" aria-hidden="true"></span></a></td>
								<%System.out.println(lists.get(i).getFileName()); %>
							</tr>
							<%}%>
						</tbody>
					</table>

					<hr>

				</div>
			</div>
		</div>
		<!-- End of download modal -->


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
		<!-- Timeline style - start -->
		<style>
.timeline {
	list-style: none;
	padding: 20px 0 20px;
	position: relative;
}

.timeline:before {
	top: 0;
	bottom: 0;
	position: absolute;
	content: " ";
	width: 3px;
	background-color: #CCCCCC;
	left: 25px;
	margin-left: -1.5px;
}

.timeline>li {
	margin-bottom: 20px;
	position: relative;
}

.timeline>li:before, .timeline>li:after {
	content: " ";
	display: table;
}

.timeline>li:after {
	clear: both;
}

.timeline>li:before, .timeline>li:after {
	content: " ";
	display: table;
}

.timeline>li:after {
	clear: both;
}

.timeline>li>.timeline-panel {
	width: calc(100% - 55px);
	float: right;
	border: 1px solid #d4d4d4;
	border-radius: 22px;
	padding: 10px;
	position: relative;
	-webkit-box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
	box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
}

.timeline>li>.timeline-panel:before {
	position: absolute;
	top: 26px;
	left: -15px;
	display: inline-block;
}

.timeline>li>.timeline-panel:after {
	position: absolute;
	top: 27px;
	left: -14px;
	display: inline-block;
}

.timeline>li>.timeline-badge {
	color: #FFFF99;
	width: 25px;
	height: 25px;
	line-height: 25px;
	font-size: 1.4em;
	text-align: center;
	position: absolute;
	top: 16px;
	left: 13px;
	background-color: #666666;
	z-index: 100;
	border-top-right-radius: 50%;
	border-top-left-radius: 50%;
	border-bottom-right-radius: 50%;
	border-bottom-left-radius: 50%;
}

.timeline>li.timeline-inverted>.timeline-panel {
	float: left;
}

.timeline>li.timeline-inverted>.timeline-panel:before {
	border-left-width: 0;
	border-right-width: 15px;
	right: -15px;
	right: auto;
}

.timeline>li.timeline-inverted>.timeline-panel:after {
	border-left-width: 0;
	border-right-width: 14px;
	left: -14px;
	right: auto;
}

.timeline-badge.primary {
	background-color: #006699 !important;
}

.timeline-badge.up {
	background-color: #339933 !important;
}

.timeline-badge.down {
	background-color: #CC3333 !important;
}

.timeline-badge.neutral {
	background-color: #999999 !important;
}

.timeline-title {
	margin-top: 0;
	color: inherit;
}

.timeline-body>p, .timeline-body>ul {
	margin-bottom: 0;
}

.timeline-body>p+p {
	margin-top: 5px;
}
</style>
		<!-- Timeline style - END -->
</body>
</html>