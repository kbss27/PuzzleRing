<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.vo.UploadFile" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- get upload lists -->
<% 
	ArrayList<UploadFile> lists = (ArrayList<UploadFile>)request.getAttribute("lists");
%>
</head>
<body>
<table>
<tr>
<th>���ε� ���� ���</th>	
</tr>
<% for(int i = 0; i < lists.size(); i++){ %>
<tr>
<td>������Ʈ �̸�: <%=lists.get(i).getProjectName()%></td>
<td>Ŭ���� �̸�: <%=lists.get(i).getClassName()%></td>
<td>���� �̸�: <%=lists.get(i).getFileName()%></td>
<td>���δ�: <%=lists.get(i).getId()%></td>
<td>���ε� ��¥: <%=lists.get(i).getDate()%></td>
</tr>
<%}%>
</table>
</body>
</html>