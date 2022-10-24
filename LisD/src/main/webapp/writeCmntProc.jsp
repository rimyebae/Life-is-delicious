<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="qnacomment.QnaCommentDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="qnacomment" class="qnacomment.QnaComment" scope="page"/>    
<jsp:setProperty name="qnacomment" property="userID"/>
<jsp:setProperty name="qnacomment" property="qcomntContent"/>


	<%
			int qnaID = 0;
			
			if(request.getParameter("qnaID") != null){
				qnaID = Integer.parseInt(request.getParameter("qnaID"));
				System.out.println(qnaID);
			}
			if(qnaID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href='qna.jsp'");
				script.println("</script>");
			}
	
		
			if(qnacomment.getUserID()== null || qnacomment.getQcomntContent() == null ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
			
			
			QnaCommentDAO qnacomntDAO = new QnaCommentDAO();
			int result = qnacomntDAO.writeQcomnt(qnaID, qnacomment.getUserID(),qnacomment.getQcomntContent());
			
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
				script.println("location.href='qna.jsp'");
				script.println("</script>");
			}
			
			
		}
	
	%>



</body>
</html>