<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>      
<link rel="stylesheet" href="css/home.css">




	<div class="home">
	<form action="joinProc.jsp" method="post">
	<h1>JOIN</h1>
	<div class="form-group">
	<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"><br>
	</div>
	<div class="form-group">
	<input type="password" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20"><br>
	</div>
	<div class="form-group">
	<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20"><br>
	</div>
	<div class="form-group">
		<div class="btn-group">
			<label class="btn btn-primary active">
				<input type="radio" name="userGender" autocomplete="off" value="F" checked>여성
			</label>
			<label class="btn btn-primary">
				<input type="radio" name="userGender" autocomplete="off" value="M">남성
			</label>
			<label class="btn btn-primary">
				<input type="radio" name="userGender" autocomplete="off" value="NONE">선택하지않음
			</label>
		</div>
		<br>
	</div>
	<div class="form-group">
	<input type="email" class="form-control" placeholder="이메일" name="userEmail"><br>
	</div>
	<button type="submit" class="btn btn-primary form-control">회원가입</button>
	</form>
	</div>
	
	
</body>
</html>