<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.vo.Board_Info"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="assets/css/main.css">

<link rel="stylesheet" type="text/css" href="assets/css/modalform.css">
<link rel="stylesheet" href="assets/css/addcss.css">

<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/modernizr.custom.79639.js"></script>

<script type="text/javascript" src="assets/js/jquery.ba-cond.min.js"></script>


<title>Modify Form</title>
<script type="text/javascript">
	//back, foward button event function
	function goback() { //go to back page
		history.back();
	}
	function forward() { //go to prior page
		history.forward();
	}
</script>
<!-- Button Event-->
<script type="text/javascript">
	function realmodify() {
		var form = document.getElementById("w");
		form.action = "realmodify.do";
		form.submit();
	}
</script>
<script type="text/javascript">
	function gowrite() {
		var form = document.getElementById("r");
		form.action = "write.do";
		form.submit();
	}
</script>

<!-- Create Board Information ArrayList Object-->
<%
	ArrayList<Board_Info> board_Info = (ArrayList<Board_Info>) request
			.getAttribute("modify");
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


	
		<div id="main-wrapper">
					<div class="container">
						<div id="content">
						<section id="main_section"> 
						<article
							class="main_article">
	                            
						<center>
						<form role="form" id="w" method="post">
							<table>
								<tr>
									<td>
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
											<tr
												style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
												<td width="5"><img src="img/table_left.gif" width="5"
													height="30" /></td>
												<td>수정</td>
												<td width="5"><img src="img/table_right.gif" width="5"
													height="30" /></td>
											</tr>
										</table>
										<table>
											<tr>
												<td>&nbsp;</td>
												<td align="center">제목</td>
												<td><input name="title" size="50" maxlength="100" value="<%=board_Info.get(0).getTitle() %>"></td>
												<td>&nbsp;</td>
											</tr>
											<tr height="1" bgcolor="#dddddd">
												<td colspan="4"></td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td align="center">이름</td>
												<td><input name="name" size="50" maxlength="50" value = "<%=board_Info.get(0).getName() %>"></td>
												<td>&nbsp;</td>
											</tr>
											<tr height="1" bgcolor="#dddddd">
												<td colspan="4"></td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td align="center">비밀번호</td>
												<td><input type="password" name="password" size="50"
													maxlength="50" value="<%=board_Info.get(0).getpass() %>"></td>
												<td>&nbsp;</td>
											</tr>
											<tr height="1" bgcolor="#dddddd">
												<td colspan="4"></td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td align="center">내용</td>
												<td><textarea name="memo" cols="50" rows="13"><%=board_Info.get(0).getMemo() %></textarea></td>
												<td>&nbsp;</td>
											</tr>
											<tr height="1" bgcolor="#dddddd">
												<td colspan="4"></td>
											</tr>
											<tr height="1" bgcolor="#82B5DF">
												<td colspan="4"></td>
											</tr>
											<tr align="center">
												<td>&nbsp;</td>
												<td colspan="2"><input type=button onclick="realmodify()"value="수정">
												<td>&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</form>
						</center>
						</article> </section>
						<!-- for main section -->

					</div>
					
				</div>
				<!-- middle section - row1 -->
			</div>
			<!-- container -->
		</div>
		<!-- middle section -->

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
</body>
</html>