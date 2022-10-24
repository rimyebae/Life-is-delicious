<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="qna.Qna"%>
<%@ page import="qna.QnaDAO"%>
<%@ page import="qnacomment.QnaComment"%>
<%@ page import="qnacomment.QnaCommentDAO"%>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="css/home.css">

<%
if (userID == null) { //로그인하지 않으면 게시글 작성 불가
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Q&A게시판은 로그인을 해야 이용하실 수 있습니다.')");
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
QnaComment qnacmnt = new QnaCommentDAO().getQnaCmnt(qnaID);
%>


<div class="home">
	<table>
		<thead>
			<tr>
				<td colspan="2"
					style="background-color: #eeeeee; text-align: center; color: rgb(0, 0, 0)">Q&A 게시글 읽기</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td style="width: 100%">
			<% if(qna.getQnaSort().equals("notice")){ %>[ <%=qna.getQnaSort()%> ] <% } %><%=qna.getQnaTitle()%></td>
			</tr>
			<tr>
				<td style="width: 100%">작성자 : <%=qna.getUserID()%> (작성일자 : <%=qna.getQnaDate()%>)
				</td>
			</tr>
			<tr>
				<td style="height: 350px; width: 100%; overflow: auto;"><%=qna.getQnaContent()%></td>
			</tr>
			<tr style="text-align: center;">
				<td><a href="update.jsp?qnaID=<%=qna.getQnaID()%>">수정하기</a> | <a
					href="delProc.jsp?qnaID=<%=qna.getQnaID()%>">삭제하기</a> | <a
					href="writeCmnt.jsp?qnaID=<%=qna.getQnaID()%>">댓글쓰기</a> </td>
			</tr>
		</tbody>
	</table>
		<div class="cmnttable">
	<%
		
		QnaCommentDAO qcmntDAO = new QnaCommentDAO();
		ArrayList<QnaComment> list = qcmntDAO.getListQcmnt(qnaID);
		System.out.println("총 데이터 수 = "+ list.size());
		for(int i = 0 ; i < list.size();i++){
	%>
		<table >
			<thead>
				<tr>
					<td style="background-color: #eeeeee; color: rgb(0, 0, 0)"><%=list.get(i).getUserID()%>
						(작성시간 : <%=list.get(i).getQcomntDate()%>)
					<td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="height: 50px; width: 100%;"><%=list.get(i).getQcomntContent()%></td>
				</tr>
				<tr style="text-align: center;">
					<td><a href="updateCmnt.jsp?qcomntID=<%=list.get(i).getQcomntID()%>">수정하기</a> | 
					<a href="delCmntProc.jsp?qcomntID=<%=list.get(i).getQcomntID()%>">삭제하기</a></td>
				</tr>
			</tbody>
		</table>
	<%
		}
	%>
		</div>
</div>






</body>
</html>