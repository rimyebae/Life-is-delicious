<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="qnacomment.QnaCommentDAO"%>
<%@ page import="qnacomment.QnaComment"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>


	<%
		
			if(userID == null){ //로그인하지 않으면 게시글 작성 불가
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Q&A게시판은 로그인을 해야 이용하실 수 있습니다.')");
				script.println("location.href='login.jsp'");
				script.println("</script>");
			} 
		
			int qcomntID = 0;
			
			if(request.getParameter("qcomntID") != null){
				qcomntID = Integer.parseInt(request.getParameter("qcomntID"));
				System.out.println(qcomntID);
			}
			if(qcomntID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 접근입니다.')");
				script.println("location.href='qna.jsp'");
				script.println("</script>");
			}
			
			QnaComment qnacomt = new QnaCommentDAO().getQnaCmnt(qcomntID);
			
			
			if(request.getParameter("qcomntContent") == null || request.getParameter("qcomntContent").equals("")) { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
			
					QnaCommentDAO qnacomntDAO = new QnaCommentDAO();
					int result = qnacomntDAO.updateQcmnt(qcomntID, request.getParameter("qcomntContent"));
				
					
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
					script.println("location.href='qna.jsp'");
					script.println("</script>");
				}
				
				
			}
		
	%>

</body>
</html>
