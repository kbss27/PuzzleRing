<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.vo.UploadFile" %>
<%@ page import="com.dao.PRShowUploadList" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Download page</title>
<%
request.setCharacterEncoding("UTF-8");
//PRShowUploadList list = new PRShowUploadList();
//���� file �̸�
String fileName = request.getParameter("filename");
//������ file �̸�
String newFileName = "";
String path = request.getSession().getServletContext().getRealPath("/")+"download/";
InputStream in = null;
OutputStream os = null;
File file = null;
boolean skip = false;
String client = "";
//UploadFile file = new UploadFile(); 
//file = list.getFile(fileName);
%>
</head>
<body>
<%
try {
	try {
		file = new File(path, fileName);
		System.out.println("��� : " + path + " / "  + "���� �̸� : " + fileName);
		in = new FileInputStream(file);
	} catch(FileNotFoundException e) {
		skip = true;
	}
	client = request.getHeader("User-Agent");
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Description", "JSP Generated Data");
	
	//������ ������
	if(!skip) {
		// IE
        if(client.indexOf("MSIE") != -1){
            response.setHeader ("Content-Disposition", "attachment; newFileName="+new String(fileName.getBytes("KSC5601"),"ISO8859_1"));
        }
        else{
            // �ѱ� ���ϸ� ó��
           	fileName = new String(fileName.getBytes("utf-8"),"iso-8859-1");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
        }  
        response.setHeader ("Content-Length", ""+file.length() );
        os = response.getOutputStream();
        byte b[] = new byte[(int)file.length()];
        int leng = 0;
         
        while( (leng = in.read(b)) > 0 ){
            os.write(b,0,leng);
        }	
	}
	else{
        response.setContentType("text/html;charset=UTF-8");
        out.println("<script language='javascript'>alert('������ ã�� �� �����ϴ�');history.back();</script>");

    }
	in.close();
	os.close();
} catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>