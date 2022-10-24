<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="qna.Qna" %>
<%@ page import="qna.QnaDAO" %>
<link rel="stylesheet" href="css/home.css">



<%
		if (userID == null) { //로그인하지 않으면 게시글 작성 불가 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하셔야 게시글을 작성할 수 있습니다.로그인페이지로 이동합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int qnaID = 0;
		if (request.getParameter("qnaID") != null) {
			qnaID = Integer.parseInt(request.getParameter("qnaID"));
			System.out.println(qnaID);
		}
		if (qnaID == 0) {
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
			script.println("alert('수정권한이 없습니다.')");
			script.println("location.href='qna.jsp'");
			script.println("</script>");
		}
		
		
%>


<div class="home">
	<form method="post" action="updateProc.jsp?qnaID=<%=qnaID %>">
		<table>
			<thead>
				<tr>
					<td colspan="2"
						style="background-color: #eeeeee; text-align: center; color: rgb(0, 0, 0)">
						Q&A 수정 페이지</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" placeholder="글제목"
						name="qnaTitle" style="width: 100%" value="<%=qna.getQnaTitle()%>"></td>
				</tr>
				<tr>
					<td><textarea class="form-control" placeholder="글내용"
							name="qnaContent" style="height: 350px; width: 100%"><%=qna.getQnaContent()%></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="form form-control btn" value="수정하기">
	</form>
</div>






</body>
</html>