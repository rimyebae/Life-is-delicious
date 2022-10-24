<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="placecomment.PlaceCommentDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="placecomment" class="placecomment.PlaceComment" scope="page"/>    
<jsp:setProperty name="placecomment" property="userID"/>
<jsp:setProperty name="placecomment" property="pcomntContent"/>


	<%
			int placeID = 0;
			
			if(request.getParameter("placeID") != null){
				placeID = Integer.parseInt(request.getParameter("placeID"));
				System.out.println(placeID);
			}
			if(placeID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href='place.jsp'");
				script.println("</script>");
			}
	
			
			int pcomntPoint = 0;
			if(request.getParameter("pcomntPoint") != null){
				pcomntPoint = Integer.parseInt(request.getParameter("pcomntPoint"));
				System.out.println("==== 입력한 별점 "+pcomntPoint);
			}
			
			
			System.out.println("장소댓글유저아이디  "+placecomment.getUserID());
			System.out.println("장소댓글내용  "+placecomment.getPcomntContent());
			
			
			/* if(request.getParameter("pcomntPoint") == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} */
		
			if(placecomment.getUserID() == null || placecomment.getPcomntContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				
			
			PlaceCommentDAO pcomntDAO = new PlaceCommentDAO();
			int result = pcomntDAO.writePcomnt(placeID, placecomment.getUserID(), pcomntPoint , placecomment.getPcomntContent());
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글쓰기에 성공했습니다')");
				script.println("location.href='place.jsp'");
				script.println("</script>");
			}
			
			
		}
	
	%>



</body>
</html>