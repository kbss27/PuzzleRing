<%@page import="com.controller.PRController_showUploadList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.dao.PRCreateProject"%>
<%@ page import="com.dao.PRModel"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.vo.UploadFile"%>
<%@ page import="java.io.File"%>
<%@ page import="com.dao.PRUpload"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Project Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--  <link rel="stylesheet" type="text/css" href="assetscss/loginmain.css"> -->

<link rel="stylesheet" type="text/css" href="assets/css/joint.css" />
<link rel="stylesheet" type="text/css" href="assets/css/joint.min.css" />
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/addcss.css">
<link href="assets/css/fileinput.css" media="all" rel="stylesheet"
	type="text/css" />
<link href="assets/css/uploadcss.css" rel="stylesheet">


<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /> <![endif]-->
<script type="text/javascript" src="assets/js/lodash.min.js"></script>
<script type="text/javascript" src="assets/js/backbone-min.js"></script>
<script type="text/javascript" src="assets/js/joint.js"></script>
<script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
<!--  <script type="text/javascript" src="assets/js/bootstrap.min.js"></script> -->
<script src="assets/js/fileinput.js" type="text/javascript"></script>


<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


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
<%!String p = "", id, project_name = "", current_project = "";
	ArrayList<UploadFile> lists;
	ArrayList<String> classlist;
	ArrayList<String> classes;
	String uml;
	String content;%>
<%!String classname = "";%>
<%
	id = (String) session.getAttribute("login");
	System.out.println("ididtest ==   " + id);
%>

<%
	project_name = request.getParameter("project_name");
	System.out.println(project_name + "      P-name test");

	//if(p!=null)
	//	session.setAttribute("project_name", p);

	//project_name = session.getAttribute("project_name").toString();
%>
<%
	lists = (ArrayList<UploadFile>) request.getAttribute("lists");
	classlist = (ArrayList<String>) request.getAttribute("classlist");
	content = (String) request.getAttribute("content");
	uml = (String)request.getAttribute("uml");
	uml = uml.replace('?', ' ');
	System.out.println("-------------------------------");
	System.out.println(uml);
%>

<script type="text/javascript">
	function ErrorType() {
		alert("Invalid Type!");
	}

	function confirmUpload() {
		$('#smallModal').modal();
	}
</script>

<script>
	$(document)
			.ready(
					function() {

						setInterval(
								function() {

									var pp = $('#p_name').html();

									$
											.ajax({

												type : "POST",
												url : '/PRfinal/ajax_project_detail_Issue.do?project_name='
														+ pp,
												dataType : 'json',
												async : true,
												contentType : 'application/json; charset=utf-8',
												success : function(res) {

													var $time_line = $("#timeline");

													$time_line.empty();

													$
															.each(
																	res,
																	function(
																			idx,
																			value) {

																		////////////////
																		var issue;
																		issue = "<li><!--Time Line Element---> <div class='timeline-badge up'>	<i class='	fa fa-cloud-upload'></i></div>"
																				+ "	<div class='timeline-panel'>	<div class='timeline-heading'>	<h4 class='timeline-title'>"
																				+ "<p>Upload</p>"
																				+ "</h4></div>"
																				+ "	<div class='timeline-body'>	<!---Time Line Body&Content--->	"
																				+ value.className
																				+ "  "
																				+ value.id
																				+ "  "
																				+ value.date
																				+ "  "
																				

																				+"		</div>		</div>	</li>";
																		////////////////

																		$time_line
																				.append(issue);

																	});
												},
												error : function(req, st, e) {

												}
											});

								}, 20000);

					});
</script>

<script type="text/javascript">
	function fileupload_form() {
<%PRUpload upload;
			request.setCharacterEncoding("UTF-8");
			//10Mbyte
			int maxSize = 1024 * 1024 * 10;

			//파일 저장할 경로
			String path = request.getSession().getServletContext().getRealPath("/") + "download/";

			//업로드된 파일 이름
			String uploadFile = "";

			//저장될 파일 이름
			String fileName = "";

			//DB에 저장될 날짜, 아이디, 프로젝트 이름, 클래스 이름
			String DB_date, DB_Id, DB_projectName, DB_className;
			int read = 0;

			byte[] buf = new byte[1024];
			FileInputStream is = null;
			FileOutputStream os = null;
			long currentTime = System.currentTimeMillis();
			SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd/HH:mm:ss");
			try {
				System.out.println("path : " + request.getSession().getServletContext().getRealPath("/") + "download/");
				System.out.println(request.getContentType());
				MultipartRequest multi = new MultipartRequest(request, path, maxSize, "UTF-8",
						new DefaultFileRenamePolicy());

				//System.out.println(multi.getFilesystemName("uploadFile"));
				//파일 이름
				uploadFile = multi.getFilesystemName("uploadFile");
				//확장자
				String extension = uploadFile.substring(uploadFile.lastIndexOf(".") + 1);
				System.out.println("확장자: " + extension);
				//확장자가 java가 아니라면
				if (!(extension.equalsIgnoreCase("java"))) {

					return;
				} else {
					DB_date = date.format(new Date(currentTime));
					DB_Id = id;
					DB_projectName = project_name;
					DB_className = uploadFile.substring(0, uploadFile.lastIndexOf("."));
					System.out.println("업로드 날짜: " + DB_date);
					System.out.println("아이디: " + DB_Id);
					System.out.println("프로젝트 이름 : " + DB_projectName);
					System.out.println("클래스 이름 : " + DB_className);
					// 실제 저장할 파일명(class name_id_date.java)
					fileName = DB_className + "_" + DB_Id + "_" + simDf.format(new Date(currentTime)) + "." + extension;
					System.out.println("저장된 이름 : " + fileName);

					upload = new PRUpload();
					//filename, id, date, projectname, classname
					upload.upLoad(fileName, DB_Id, DB_date, DB_projectName, DB_className);

					//System.out.println(fileName + "_" + simDf.format(new Date(currentTime)));
					// 업로드된 파일 객체 생성
					File oFile = new File(path + uploadFile);

					// 실제 저장될 파일 객체 생성
					File nFile = new File(path + fileName);

					// 파일명 rename
					if (!oFile.renameTo(nFile)) {
						// rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
						buf = new byte[1024];
						is = new FileInputStream(oFile);
						os = new FileOutputStream(nFile);
						read = 0;
						while ((read = is.read(buf, 0, buf.length)) != -1) {
							os.write(buf, 0, read);
						}

					}
					is.close();
					os.close();
					oFile.delete();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}%>
	var c = confirm("Upload Success!");
		if (c == true) {
			window.addUploadIssue();
		}
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
				$(".addBtn").click(function() {
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
				$(".delBtn").click(
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
<script type="text/javascript">
	function addUploadIssue() {

		var issue;
		issue = "<li><!--Time Line Element---> <div class='timeline-badge up'>	<i class='	fa fa-cloud-upload'></i></div>"
				+ "	<div class='timeline-panel'>	<div class='timeline-heading'>	<h4 class='timeline-title'>Time Line Entry #1</h4></div>"
				+ "	<div class='timeline-body'>	<!---Time Line Body&Content--->	<p>Upload</p>"
				+ "		</div>		</div>	</li>";
		$("#timeline").append(issue); //db에 넣어야 함!

	}

	function addUploadIssue() {
<%PRUpload tmp = new PRUpload();
			// tmp.upLoad(fileName, id, date, projectName, className)%>
	}
</script>


<style>
.modal-backdrop {
	z-index: -1;
}
</style>

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
			<li class="current"><a href="usermain.do"><i
						class="fa fa-2x fa-fw fa-home text-warning"></i></a></li>
				<li><a href="projectList.do">Project List</a></li>
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
				<div style="text-align: center;">
					<h2 id="p_name"><%=project_name%></h2>

				</div>
				</br>
				<i class="fa fa-cube" style="font-size:24px; color:Black;"> Project Information </i>
				<div class="info-display">
          			<div class="message success">
						
						<strong><%=content%></strong>
					</div>
				</div>
				<br>
				

				<i class="fa fa-cube"  style="font-size:24px; color:Black;"> Class List</i>
				<div id="current_prj">
					<table id="tableid">

						<%
									ArrayList<String> temp = new ArrayList<String>();
									for (int i = 0; i < classlist.size(); i++) {

										temp.add(classlist.get(i));
									}
									for (int i = 0; i < temp.size(); i++) {
										for (int j = i + 1; j < temp.size(); j++) {
											if (temp.get(i).equalsIgnoreCase(temp.get(j))) {
												temp.remove(j);
											}
										}
									}
									classes = new ArrayList<String>();

									for (int i = 0; i < temp.size(); i++) {
										classes.add(temp.get(i));
								%>
						<tr>
							<td><%=temp.get(i)%></td>
							<td style="width: 15%;"><a data-toggle="modal"
								data-target="#uploadModal" class="button">upload</a></td>

							<td style="width: 15%;"><a data-id="<%=temp.get(i)%>"
								class="button downBtn">download</a></td>
						</tr>

						<%
									}
								%>

						<script>
									var selected = "";

									$(function() {
										$('.downBtn').click(function() {
											selected = $(this).attr("data-id");

											$('#downloadModal').modal('show')
										})

									})
								</script>
					</table>
				</div>
				<br>
				<i class="fa fa-cube"  style="font-size:24px; color:Black;"> UML</i>
				<div style="border: solid 1px; height: 500px; 	margin-top: 8px;">
					<section id="Myboxes" class="papers"><%=uml %></section>
				</div>
			</div>

			<br>
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
									<ul class="timeline" id="timeline">
										<!-- space for appending timeline -->

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
					<form
						action="form/fileupload_form.jsp?project_name=<%=project_name%>"
						method="post" enctype="multipart/form-data">
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

					<input type="hidden" id="classtype" name="classtype" value="">


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
								ArrayList<UploadFile> lists = (ArrayList<UploadFile>) request.getAttribute("lists");
								for (int i = 0; i < lists.size(); i++) {
							%>

							<tr class="class-info"
								data-class="<%=lists.get(i).getClassName()%>"
								style="display: none">
								<td><%=lists.get(i).getProjectName()%></td>
								<td><%=lists.get(i).getClassName()%></td>
								<td><%=lists.get(i).getFileName()%></td>
								<td><%=lists.get(i).getId()%></td>
								<td><%=lists.get(i).getDate()%></td>

								<td><a
									href="form/downloadFile.jsp?filename=<%=lists.get(i).getFileName()%>">
										<span class="glyphicon glyphicon-save" aria-hidden="true"
										onClick="addDownloadIssue()"></span>
								</a></td>
								<%
									System.out.println(lists.get(i).getFileName());
								%>


							</tr>
							<%
								}
							%>

							<script>
								$('#downloadModal')
										.on(
												'shown.bs.modal',
												function(e) {

													$('.class-info')
															.each(
																	function(
																			index) {
																		if ($(
																				".class-info")
																				.eq(
																						index)
																				.attr(
																						'data-class') == selected) {
																			$(
																					".class-info")
																					.eq(
																							index)
																					.fadeIn()
																		}
																	})
												})

								$('#downloadModal').on(
										'hidden.bs.modal',
										function(e) {
											$('.class-info').each(
													function(index) {
														$(".class-info").eq(
																index).hide()
													})
										})
							</script>
						</tbody>
					</table>

					<hr>

				</div>
			</div>
		</div>
		<!-- End of download modal -->

		<!-- Start of confirm modal -->
		<div id="smallModal" class="modal fade bs-example-modal-sm"
			tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">...alert</div>
			</div>
		</div>
		<!-- End of confirm modal -->
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
.info-display {
  margin-top: 8px;
}

.message {
  margin: 0 auto;   
  padding: 19px;
  margin: 0 auto;
  background-color: #FFFFFF; 
  font-family: 'Open Sans', sans-serif;
  font-size: 16px;
}

.info strong {
  color: #5bc0de;
}

.success {
  border-right-color: #FF4486;
  border-radius: 31px;
  background-color: rgba(255, 235, 254, 0.2);
  border-right-color:#FF4486; /* Side Effect Colors */
  border-left-color:#FF4486; /* Side Effect Colors */
  border: 1px solid #FF4486;
  border-right-width: 19px;
  border-left-width: 19px;
}
.success strong {
  color: Black;
}


</style>
		<!-- Timeline style - END -->
</body>
</html>