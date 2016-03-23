<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.dao.PRShowProject" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.vo.Project_detail"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
</head>
<body>
project list</br>
<%
ArrayList<Project_detail> p = (ArrayList<Project_detail>)request.getAttribute("project_detail");
for(int i = 0; i < p.size(); i++) {
	System.out.println(p.get(i).getProject_name());
	System.out.println(p.get(i).getProject_detail());
	// test!
}
%>
</body>
</html>