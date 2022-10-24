<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LIFE IS DELICIOUS</title>
<link rel="stylesheet" href="css/titlenav.css">
</head>
<body>
	<%
		String userID = null;
		String userStatus = null;
		String userPW = null;
		
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			userStatus = (String) session.getAttribute("userStatus");
			userPW = (String) session.getAttribute("userPW");
		}
	%>
		
	<%
	
	if(userID == null){
    %>			
		<div class="btn">
		<button class="custom-btn btn-2" onclick="location.href ='join.jsp'"><b>JOIN</b></button>
		<button class="custom-btn btn-2" onclick="location.href ='login.jsp'"><b>LOGIN</b></button>
	<%
	 }else{ 
     		if(userStatus != null && userStatus.equals("manager")){//관리자 모드
	%>	
			<button class="custom-btn btn-2" onclick="location.href ='logoutProc.jsp'"><b>LOGOUT</b></button>
			<button class="custom-btn btn-2" onclick="location.href ='manage.jsp'"><b>MANAGE</b></button>
	<%
	 		}else{//일반 사용자 모드
	%>	 
			<button class="custom-btn btn-2" onclick="location.href ='logoutProc.jsp'"><b>LOGOUT</b></button>
			<button class="custom-btn btn-2" onclick="location.href ='bookmark.jsp'"><b>MYPAGE</b></button>
	<%
	 		}
	 }
	%>
	
	</div>
	
	<div class="titlenav">
	<header>
	 <h1 class="title"> LIFE IS DELICIOUS </h1>
	</header>
	
  <!-- start nav -->
  <div class="back color-3">
    <div class="row columns">
      <ul class="menu align-center expanded text-center SMN_effect-73">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="place.jsp">Place</a></li>
        <li><a href="qna.jsp">Q&A</a></li>
      </ul>
    </div>
  </div>
	</div>
  <!-- // end nav-->
  <br>
  
	
	
