<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="qna.QnaDAO"%>
<%@ page import="qna.Qna"%>
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
			
			Qna qna = new QnaDAO().getQna(qnaID);
			
			
			if(request.getParameter("qnaTitle") == null || request.getParameter("qnaContent") == null
					|| request.getParameter("qnaTitle").equals("")|| request.getParameter("qnaContent").equals("")) { 
				//TODO 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
			
					QnaDAO qnaDAO = new QnaDAO();
					int result = qnaDAO.update(qnaID ,request.getParameter("qnaTitle"),request.getParameter("qnaContent"));
				
					
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
						script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정이 완료되었습니다.')");
					script.println("location.href='qna.jsp'");
					script.println("</script>");
				}
				
				
			}
		
	%>



</body>
</html>