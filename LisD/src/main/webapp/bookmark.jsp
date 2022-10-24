<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="mypage.jsp"%>
<%@ page import="place.Place"%>
<%@ page import="bookmark.BookmarkDAO"%>
<%@ page import="java.util.ArrayList"%>
<link rel="stylesheet" href="css/mypage.css">


<div class="main">
	<h1>북마크</h1>
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>가게이름</th>
				<th>음식타입</th>
				<th>가게주소</th>
			</tr>
		</thead>
		<tbody>
		 <%
			int pageNumber = 1;
			if (request.getParameter("pageNumber") != null) {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}

			BookmarkDAO bmDAO = new BookmarkDAO();
			ArrayList<Place> list = bmDAO.getList(userID, pageNumber);
			for (int i = 0; i < list.size(); i++) {
			%>
			<tr>
				<td><%=list.get(i).getPlaceID()%></td>
				<td><a href="view.jsp?placeID=<%=list.get(i).getPlaceID()%>"><%=list.get(i).getPlaceName()%></a></td>
				<td><%=list.get(i).getPlaceFoodtype()%></td>
				<td><%=list.get(i).getPlaceAddress()%></td>

			</tr>
			<%
			} 
			%>
		</tbody>
	</table>
	<div class="listbtns">
				<%
				if (pageNumber != 1) {
				%>
				<a class="btn" href="bookmark.jsp?pageNumber=<%=pageNumber - 1%>">
					◀◀ </a>
				<%
				}
				if (bmDAO.nextPage(userID, pageNumber + 1)) {
				%>
				|| <a class="btn" href="bookmark.jsp?pageNumber=<%=pageNumber + 1%>">
					▶▶ </a>

				<%
				}
				%>
			</div>
</div>


</body>
</html>