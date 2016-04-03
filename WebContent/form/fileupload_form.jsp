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
<%@ page import="com.dao.PRUpload" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>Source code upload page</h1>
<%
PRUpload upload;
request.setCharacterEncoding("UTF-8");
//10Mbyte
int maxSize = 1024*1024*10;

//파일 저장할 경로
String path = request.getSession().getServletContext().getRealPath("/")+"download/";

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
	System.out.println("현우형 path : " + request.getSession().getServletContext().getRealPath("/")+"download/");
	System.out.println(request.getContentType());
	MultipartRequest multi = new MultipartRequest(request, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());

     //System.out.println(multi.getFilesystemName("uploadFile"));
     //파일 이름
     uploadFile = multi.getFilesystemName("uploadFile");
     //확장자
     String extension = uploadFile.substring(uploadFile.lastIndexOf(".")+1);
     System.out.println("확장자: " + extension);
     //확장자가 java가 아니라면
     if(!(extension.equalsIgnoreCase("java"))) {
    	 return;
     }
     else {
    	 DB_date = date.format(new Date(currentTime));
    	 DB_Id = "sampleID";
    	 DB_projectName = "sampleProject";
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
        if(!oFile.renameTo(nFile)){
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
     }
     
}catch(Exception e) {
	e.printStackTrace();
}
%>
<a href="project_detail.jsp">돌아가기</a>
</body>
</html>