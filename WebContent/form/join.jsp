<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"  type="text/css" href="css/join.css">
<title>Insert title here</title>
<script type="text/javascript">
	function goJoin() {
		var form = document.getElementById("joinForm");
		form.action = "joinprocess.do";
		form.submit();
	}
</script>
</head>
<body>
    <h1 align="center">Join our Membership</h1>
<section class="signupform">
<form role="form" id="joinForm" method="get">
    <div class="signup_id">
        <label for="id">ID: </label>
		<input type="text" class="form-control txt" name="id" placeholder="　length 5-20">
    </div>
    <div class="signup_password">
        <label for="password">password: </label>
		<input type="password" class="form-control txt" name="password">
    </div>
    <div class="signup_password_check">
        <label for="password_check">password(again): </label>
		<input type="password" class="form-control txt" name="passcheck">
    </div>
    <div class="signup_email">
        <label for="email">E-mail: </label>
		<input type="text" class="form-control txt" name="e_mail" placeholder="sample@sample.com">
    </div>
    <div class="signup_interested">
    	<label for="interested">Interested part: </label>
    	<select name="interestedPart">
    		<option value="sorting">Sorting</option>
    		<option value="tree">Tree</option>
    		<option value="algorithm">Algorithm</option>
    		<option value="design">Design</option>
    		<option value="others">Others</option>
    	</select>
    </div>
    <div class="signup_info">
        <label for="info">Information: </label></br>
		<textarea class="form-control txt" name="information" max_length="900" cols="80" rows="10"  placeholder="Information(1~900)"></textarea>
    </div>
    <input type="submit" value="Join" onclick = "goJoin()" >
</form>
</section>
</body>
</html>