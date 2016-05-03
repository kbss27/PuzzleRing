<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

   <%
	  // Store "id" parameter in String variable id
     /// String id = request.getParameter("id");
   
   	  // Set id variable in login session
     /// session.setAttribute("login", id);
	  //session.getparameter("login");
	  
	  // respose from "main_page.do" script
      response.sendRedirect("usermain.do");
   %>
</body>
</html>