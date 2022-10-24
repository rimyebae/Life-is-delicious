<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/mypage.css">
<title>마이페이지</title>
</head>
<body>

	<div class="left_section">
	<%
	String userID = null;
	String userStatus = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		userStatus = (String) session.getAttribute("userStatus");
	}
	%>
	
	<h3>📃 LisD MYPAGE</h3>
	
	
	<div class="profile">
		<div class="profile_box">		
		</div>
	<h2><%=userID %>님의 프로필</h2>
	
	</div>
	
	
	<div>
	<button class="btn" onclick="location.href ='logoutProc.jsp'">
		<b>LOGOUT</b>
	</button>
	<button class="btn" onclick="location.href ='home.jsp'">
		<b>HOME</b>
	</button>
	</div>

	<div class="nav">
		<ul>
			<li><a href="bookmark.jsp">BOOKMARK</a></li>		
			<li><a href="account.jsp">ACCOUNT</a></li>		
			<li><a href="usage.jsp">USAGE HISTORY</a></li>		
		</ul>
		
		<hr>
		
		<ul>
			<li>Message</li>		
			<li>아직미정</li>		
		</ul>
	</div>
	
	</div>
</body>
</html>	