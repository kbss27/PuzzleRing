<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRModel"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.vo.Board_Info"%>
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


<title>Community</title>

<%
	//PRModel prmodel = new PRModel();
	//prmodel.updateTodayProject();
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
	function gowrite() {
		var form = document.getElementById("r");
		form.action = "write.do";
		form.submit();
	}
</script>

<%
	//for using JavaScript.
	//about board information
	ArrayList<Board_Info> board_Info = (ArrayList<Board_Info>) request.getAttribute("listinfo");
	
	String id = (String) request.getAttribute("id");

	if (id != null) {
		session.setAttribute("login", id);
	}

%>

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
				<li><a href="community.do">Community</a></li>
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
		<div id="main-wrapper">
			<div class="container">
				<div id="content">
					<section id="main_section">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr height="5">
							<td width="5"></td>
						</tr>
						<!-- for board header -->
						<tr
							style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
							<td width="5"><img src="img/table_left.gif" width="5"
								height="30" /></td>
							<td width="73">번호</td>
							<td width="379">제목</td>
							<td width="73">작성자</td>
							<td width="164">작성일</td>
							<td width="58">조회수</td>
							<td width="7"><img src="img/table_right.gif" width="5"
								height="30" /></td>
						</tr>
						<!-- for board list -->
						<%
							for (int i = 0; i < board_Info.size(); i++) {
						%>
						<tr height="25" align="center">
							<td width="5"><img src="img/table_left.gif" width="5"
								height="30" /></td>
							<td width="73"><%=board_Info.get(i).getIndex()%></td>
							<td width="379">
							<a href="goview.do?idx=<%=board_Info.get(i).getIndex()%>"><%=board_Info.get(i).getTitle()%></td>
							<td width="73"><%=board_Info.get(i).getName()%></td>
							<td width="164"><%=board_Info.get(i).getTime()%></td>
							<td width="58"><%=board_Info.get(i).getHit()%></td>
							<td width="7"><img src="img/table_right.gif" width="5"
								height="30" /></td>
						</tr>
						<%
							}
						%>
						<tr height="1" bgcolor="#D2D2D2">
							<td colspan="6"></td>
						</tr>

						<tr height="1" bgcolor="#82B5DF">
							<td colspan="6" width="752"></td>
						</tr>
					</table>

					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td colspan="4" height="5"></td>
						</tr>
						<tr align="center">
							<form role="form" id="r" method="get">
								<input type ="hidden" id="id_info" value="'<%=id %>'"></input>
								<td><input type="button" onclick="gowrite()" value="글쓰기"></td>
							</form>
						</tr>
					</table>
					</section>
					<!-- End of main section -->

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
</body>
</html>