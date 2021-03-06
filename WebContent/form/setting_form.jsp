<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="com.vo.Member"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
   <link rel="stylesheet"  type="text/css" href="assets/css/main.css">
<title>Setting Personel Infomation</title>
<script type="text/javascript">
   //back, foward, logout button event function
   function goback() { //go to back page
      history.back();
   }
   </script>
</head>
<body class="homepage">
	<div id="page-wrapper">

	<div id="banner-wrapper">
		<div id="banner">
				<div class="container">		
					<header>
						<h2 style="text-align: center;">Setting Your Information</h2>
   					</header>
					<section class="settingform">
						<form action = "" method="post">
						    <%Member member = (Member)request.getAttribute("member");%>
						    <div class="setting_id">
						        <label for="id">ID: </label>
						        <input type="text" id="id" name="id" value = "<%=member.getM_id()%>" readonly>
						    </div>
						    <div class="setting_password">
						        <label for="password">password: </label>
						        <input type="password" id="password" name="password" value = "">
						    </div>
						    <div class="setting_password_check">
						        <label for="password_check">password(again): </label>
						        <input type="password" id="password_check" name="password_check" value = "">
						    </div>
						    <div class="setting_email">
						        <label for="email">E-mail: </label>
						        <input type="text" id="email" name="email" value = "<%=member.getM_email()%>">
						    </div>
						    <div class="setting_info">
						        <label for="info">Information: </label>
						        <input type="text" id="info" name="info" value = "<%=member.get_info()%>">
						    </div>
						    <br/>
						    <div style="float: right;">
						    <input type="submit" value="Cancel" formmethod="post" onclick="goback()"/>
						    <input type="submit" value="Update" formmethod="post" formaction="memberUpdate.do">
						    </div>
						    <br/>
						</form>
					</section>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
