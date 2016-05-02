<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%  //for using JavaScript.
	request.setCharacterEncoding("euc-kr");
	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	String url = "jdbc:odbc:board2";
	String id = "";
	String pass = "";
	String password = null;
	int idx = Integer.parseInt(request.getParameter("idx")); //get index
	String passw = request.getParameter("password"); //get password
	
	try{
				
		Connection conn = DriverManager.getConnection(url,id,pass); //connection
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT PASSWORD FROM board1 WHERE NUM=" + idx; //using database
		ResultSet rs = stmt.executeQuery(sql); //query result
		
		 if(rs.next()){
				password = rs.getString(1);
		 }
		 
		 if(password.equals(passw)) {
			   			
			sql = "DELETE FROM board1 WHERE NUM=" + idx;	
			stmt.executeUpdate(sql);	//execute statement
%>
<script language=javascript> //for alert message.
	self.window.alert("해당 글을 삭제하였습니다.");
	location.href = "list.jsp";
</script>

<%
		//close statements and connection
		rs.close();
		stmt.close();
		conn.close();
		
		 } else { 
%>
<script language=javascript> //for alert message.
	self.window.alert("비밀번호를 틀렸습니다.");
	location.href = "javascript:history.back()";
</script>
<%		
		 }
 	} catch(SQLException e) {
		out.println( e.toString() );
	} 

%>
