<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>    
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPW"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인처리중</title>
</head>
<body>
	<% 
		
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='home.jsp'");
			script.println("</script>");
		}
	
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPW());
		
		//user 정보 넣기
		User userNow = userDAO.getUserInfo(user.getUserID());
		
		
		
		if(result == 1){
			session.setAttribute("userID", user.getUserID());
			session.setAttribute("userStatus" , userNow.getUserStatus());
			session.setAttribute("userPW" , userNow.getUserPW());
			
			System.out.println(session.getAttribute("userID"));
			System.out.println(userNow.getUserStatus());
			PrintWriter script = response.getWriter();
			
		 	
	 	 if(userNow.getUserStatus().equals("manager")){
				script.println("<script>");
				script.println("alert('관리자 모드로 접속하셨습니다.')");
				script.println("location.href='home.jsp'");
				script.println("</script>");
			}    
	 	 
			script.println("<script>");
			script.println("alert('로그인이 완료되었습니다.')"); 
			script.println("location.href = 'home.jsp'");
			script.println("</script>");
		}else if (result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생되었습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	
	
	
	
	
	
	%>



</body>
</html>