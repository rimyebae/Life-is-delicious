<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="qna.QnaDAO" %>
<%@ page import="qna.Qna" %>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="css/home.css">

<br>
<div class="home">
	<div>
	<h1 class="hometitle">Q&A</h1>
	<br>
	</div>
	<% 
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
		
		<div class="container">
			<div class=row>
				<table class="table table-striped" style="text-align : center; border : 1px solid #dddddd">
				<thead>
				<tr>
				 	<th>번호</th>
				 	<th>제목</th>
				 	<th>작성날짜</th>
				</tr>
				</thead>
				<tbody>
	<%
		QnaDAO qnaDAO = new QnaDAO();
		ArrayList<Qna> list = qnaDAO.getList(pageNumber);
		for(int i = 0 ; i < list.size();i++){
	
	%>
					<tr>
						<th><%=list.get(i).getQnaID()%></th>				
						<th><% if(list.get(i).getQnaSort().equals("notice")){ %>[ <%=list.get(i).getQnaSort()%> ] <% } %>
						<a href="viewqna.jsp?qnaID=<%=list.get(i).getQnaID()%>"><%=list.get(i).getQnaTitle()%></a></th>				
						<th><%=list.get(i).getQnaDate()%></th>				
					</tr>
	<%
		}
	%>				
				</tbody>
				</table>
				<div class="listbtns">
	<%
					if(pageNumber != 1){
	%>
		<a class="btn" href="qna.jsp?pageNumber=<%=pageNumber - 1 %>"> ◀◀ </a>					
	<% 
					}if(qnaDAO.nextPage(pageNumber + 1)){
	%>
		<a class="btn" href="qna.jsp?pageNumber=<%=pageNumber + 1 %>"> ▶▶ </a>
		
	<% 
					}
	%>
				</div>
				
				
			</div>
			
			
			
			
		</div>
	
	<a href="write.jsp"><b>글 쓰기</b></a>
	
	
</div>
</body>

</html>