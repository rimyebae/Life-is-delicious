<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="qna.QnaDAO"%>
<%@ page import="qna.Qna"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8"); %>


<%
		
			if(userID == null){ //로그인하지 않으면 qna게시판 읽기만 가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Q&A게시판은 로그인을 해야 이용하실 수 있습니다.')");
				script.println("location.href='login.jsp'");
				script.println("</script>");
			} 
		
			System.out.println(request.getParameter("qnaID")); 
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
				
			if(!userID.equals(qna.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제권한이 없습니다.')");
				script.println("location.href='qna.jsp'");
				script.println("</script>");
				
			}else{
				
				
				QnaDAO qnaDAO = new QnaDAO();
				int result = qnaDAO.delete(qnaID);
					
						
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제를 실패했습니다.')");
					script.println("history.back()");
							script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제가 완료되었습니다.')");
					script.println("location.href='qna.jsp'");
					script.println("</script>");
				}
			
			}
		
	%>



</body>
</html>
</html>