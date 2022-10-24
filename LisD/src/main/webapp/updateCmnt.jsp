<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>
<%@ page import="qnacomment.QnaComment" %>
<%@ page import="qnacomment.QnaCommentDAO" %>
<link rel="stylesheet" href="css/home.css">
    

<%
		 if(userID == null){ //로그인하지 않으면 게시글 작성 불가
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하셔야 댓글을 수정하실 수 있습니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 

		int qcomntID = 0;
		if (request.getParameter("qcomntID") != null) {
			qcomntID = Integer.parseInt(request.getParameter("qcomntID"));
			System.out.println(qcomntID);
		}
		
	    QnaComment qnacomment = new QnaCommentDAO().getQnaCmnt(qcomntID);
		
		if(!userID.equals(qnacomment.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정권한이 없습니다.')");
			script.println("location.href='qna.jsp'");
			script.println("</script>");
		}
%>			
<div class="home">
	<form method="post" action="updateCmntProc.jsp?qcomntID=<%=qcomntID%>">
	<table>
		<thead>
			<tr>
			<td colspan="2" style="background-color:#eeeeee; text-align: center; color:rgb(0,0,0)">Q&A 댓글 수정</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>작성자 : <%=qnacomment.getUserID()%></td>
			<tr>	
				<td><textarea class="form-control" placeholder="글내용" name="qcomntContent" style="height : 100px; width: 100%"><%=qnacomment.getQcomntContent() %></textarea></td>
			</tr>		
		</tbody>
	</table>
		<input type="submit" class="form form-control btn" value="댓글수정">
	</form>
</div>
	





</body>
</html>