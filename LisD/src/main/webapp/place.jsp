<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="place.PlaceDAO"%>
<%@ page import="place.Place"%>
<%@ page import="java.util.ArrayList"%>
<link rel="stylesheet" href="css/home.css">

<br>
<div class="home">
	<div>
		<h1 class="hometitle">PLACE LIST</h1>
		<br>
	</div>
	<%
	//TODO 검색이 되는 검색어가 한정적임 새로운 페이지로 갔을때 검색창이 위로 올라감
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<div class="container">
		<div>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th>번호</th>
						<th>가게이름</th>
						<th>음식타입</th>
						<th>가게주소</th>
						<th>인근역</th>
					</tr>
				</thead>
				<tbody>
					<%
					PlaceDAO placeDAO = new PlaceDAO();
					ArrayList<Place> list = placeDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<th><%=list.get(i).getPlaceID()%></th>
						<th><a href="view.jsp?placeID=<%=list.get(i).getPlaceID()%>"><%=list.get(i).getPlaceName()%></a></th>
						<th><%=list.get(i).getPlaceFoodtype()%></th>
						<th><%=list.get(i).getPlaceAddress()%></th>
						<th><%=list.get(i).getPlaceNearstation()%></th>
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
				<a class="btn" href="place.jsp?pageNumber=<%=pageNumber - 1%>">
					◀◀ </a>
				<%
				}
				if (placeDAO.nextPage(pageNumber + 1)) {
				%>
				|| <a class="btn" href="place.jsp?pageNumber=<%=pageNumber + 1%>">
					▶▶ </a>

				<%
				}
				if (userStatus != null && userStatus.equals("manager")) {
				%>
				|| <a href="m_addplace.jsp"> 장소 추가하기 </a><br>
				<%
				}
				%>
			</div>
		</div>
	</div>





</div>

</body>
</html>