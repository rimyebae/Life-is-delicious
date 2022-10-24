<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="placecomment.PlaceComment" %>
<%@ page import="placecomment.PlaceCommentDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>


	<%
		
			if(userID == null){ //로그인하지 않으면 게시글 작성 불가
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 수정은 로그인을 해야 이용하실 수 있습니다.')");
				script.println("location.href='login.jsp'");
				script.println("</script>");
			} 
		
			int pcomntID = 0;
			
			if(request.getParameter("pcomntID") != null){
				pcomntID = Integer.parseInt(request.getParameter("pcomntID"));
				System.out.println(pcomntID);
			}
			if(pcomntID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 접근입니다.')");
				script.println("location.href='place.jsp'");
				script.println("</script>");
			}
			
			PlaceComment Pcomnt = new PlaceCommentDAO().getPlaceCmnt(pcomntID);
			
			
			if(request.getParameter("pcomntContent") == null || request.getParameter("pcomntContent").equals("")) { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
			
					PlaceCommentDAO pcomntDAO = new PlaceCommentDAO();
					int result = pcomntDAO.updatePcmnt(pcomntID, request.getParameter("pcomntContent"));
				
					
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 수정에 실패했습니다.')");
					script.println("history.back()");
						script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 수정이 완료되었습니다.')");
					script.println("location.href='place.jsp'");
					script.println("</script>");
				}
				
				
			}
		
	%>

</body>
</html>
