<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="qna.QnaDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="qna" class="qna.Qna" scope="page"/>    
<jsp:setProperty name="qna" property="qnaSort"/>
<jsp:setProperty name="qna" property="qnaTitle"/>
<jsp:setProperty name="qna" property="qnaContent"/>


	<%
		
		
		if(qna.getQnaSort()== null || qna.getQnaTitle() == null || qna.getQnaContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			
			
			QnaDAO qnaDAO = new QnaDAO();
			int result = qnaDAO.write(qna.getQnaSort(),qna.getQnaTitle(),userID,qna.getQnaContent());
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 성공했습니다')");
				script.println("location.href='qna.jsp'");
				script.println("</script>");
			}
			
			
		}
	
	%>



</body>
</html>