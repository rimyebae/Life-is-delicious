<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="placecomment.PlaceComment" %>
<%@ page import="placecomment.PlaceCommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8"); %>


<%
		
			if(userID == null){ //로그인하지 않으면 qna게시판 읽기만 가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 해야 이용하실 수 있습니다.')");
				script.println("location.href='login.jsp'");
				script.println("</script>");
			} 
		
			System.out.println(request.getParameter("pcomntID")); 
			int pcomntID = 0;
			
			if(request.getParameter("pcomntID") != null){
				pcomntID = Integer.parseInt(request.getParameter("pcomntID"));
				System.out.println(pcomntID);
			}
			if(pcomntID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href='place.jsp'");
				script.println("</script>");
			}
			
			
			PlaceComment pcomnt = new PlaceCommentDAO().getPlaceCmnt(pcomntID);
				
			if(!userID.equals(pcomnt.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제권한이 없습니다.')");
				script.println("location.href='place.jsp'");
				script.println("</script>");
				
			}else{
				
				
				PlaceCommentDAO pcomntDAO = new PlaceCommentDAO();
				int result = pcomntDAO.delQcmnt(pcomntID);
					
						
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제를 실패했습니다.')");
					script.println("history.back()");
							script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제가 완료되었습니다.')");
					script.println("location.href='place.jsp'");
					script.println("</script>");
				}
			
			}
		
	%>



</body>
</html>
</html>