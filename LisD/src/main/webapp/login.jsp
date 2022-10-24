<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>      
<link rel="stylesheet" href="css/home.css">

 
<br>
<div class="home">
	<div class="loginbox">
	<form action="loginProc.jsp" method="post">
	<h1 class="hometitle">LOGIN</h1>
	<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" ><br>
	<input type="password" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20"><br>
	<button type="submit" class="btn btn-primary form-control">SIGN IN</button>
	<br>
	</form>
	</div>
</div>

 
</body>
</html>

