<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.File" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>Source code upload page</h1>
<%
System.out.println("1");
request.setCharacterEncoding("UTF-8");
System.out.println("2");
//10Mbyte
int maxSize = 1024*1024*10;
System.out.println("3");
String path = request.getSession().getServletContext().getRealPath("/");
String uploadFile = "";
String newFile = "";

int read = 0;
byte[] buf = new byte[1024];
FileInputStream is = null;
FileOutputStream os = null;
System.out.println("4");
long currentTime = System.currentTimeMillis();
SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 

try {
	System.out.println("5");
	System.out.println("path : " + request.getSession().getServletContext().getRealPath("/"));
	System.out.println(request.getContentType());
	MultipartRequest multi = new MultipartRequest(request, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
    System.out.println("title : " + multi.getParameter("title")); 
     // 전송받은 parameter의 한글깨짐 방지
     String title = multi.getParameter("title");
     title = new String(title.getBytes("8859_1"), "UTF-8");

     System.out.println("6");
     System.out.println(multi.getFilesystemName("uploadFile"));
     // 파일업로드
     uploadFile = multi.getFilesystemName("uploadFile");

     // 실제 저장할 파일명(ex : 20140819151221.zip)
     newFile = simDf.format(new Date(currentTime)) +"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
     System.out.println("7");
      
     // 업로드된 파일 객체 생성
     File oFile = new File(path + uploadFile);
     System.out.println("8");
      
     // 실제 저장될 파일 객체 생성
     File nFile = new File(path + newFile);
     System.out.println("9");

     // 파일명 rename
     if(!oFile.renameTo(nFile)){
    	 System.out.println("10");
         // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제

         buf = new byte[1024];
         is = new FileInputStream(oFile);
         os = new FileOutputStream(nFile);
         read = 0;
         while((read=is.read(buf,0,buf.length))!=-1){
             os.write(buf, 0, read);
         }
          
         is.close();
         os.close();
         oFile.delete();
}
}catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>