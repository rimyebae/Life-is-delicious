<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="place.Place"%>
<%@ page import="place.PlaceDAO"%>
<%@ page import="bookmark.Bookmark"%>
<%@ page import="bookmark.BookmarkDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>북마크 처리중</title>
</head>
<body>
		
		<%
		
		String userID = null;
		String userStatus = null;
		
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			userStatus = (String) session.getAttribute("userStatus");
		}
		
		if(userID == null){ //로그인하지 않으면 북마크 불가
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('북마크 서비스는 로그인을 해야 이용하실 수 있습니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 
		
		int placeID = 0;
		
		if(request.getParameter("placeID") != null){
			placeID = Integer.parseInt(request.getParameter("placeID"));
			System.out.println(placeID);
		}
		if(placeID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('북마크 처리중 오류가 발생하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
			BookmarkDAO bmDAO = new BookmarkDAO();
		if (bmDAO.isBM(placeID, userID)) {
				
				int result = bmDAO.delBM(placeID, userID);
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('북마크 오류 발생')");
					script.println("history.back()");
						script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('북마크 취소되었습니다.')");
					script.println("location.href='place.jsp'");
					script.println("</script>");
				}
				
			}else{
				int result = bmDAO.addBM(placeID, userID);
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('북마크 오류 발생')");
					script.println("history.back()");
						script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('북마크가 되었습니다.')");
					script.println("location.href='place.jsp'");
					script.println("</script>");
				}
				
			}
			%>
			
		%>
		
		
		
		
		
		
		





</body>
</html>