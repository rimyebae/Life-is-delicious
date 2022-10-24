<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="place.Place"%>
<%@ page import="place.PlaceDAO"%>
<%@ page import="bookmark.Bookmark"%>
<%@ page import="bookmark.BookmarkDAO"%>
<%@ page import="placecomment.PlaceComment"%>
<%@ page import="placecomment.PlaceCommentDAO"%>

<link rel="stylesheet" href="css/home.css">


<%
int placeID = 0;
if (request.getParameter("placeID") != null) {
	placeID = Integer.parseInt(request.getParameter("placeID"));
	System.out.println(placeID);
}
if (placeID == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href='place.jsp'");
	script.println("</script>");
}

Place place = new PlaceDAO().getPlace(placeID);
%>
<br>

<div class="home">
	<br>
	<div>
		<table class="table table-striped"
			style="text-align: center; border: 1px solid #dddddd">
			<tbody>
				<tr>
					<th>이름</th>
					<td><%=place.getPlaceName()%></td>

					<th>지도</th>
					<td rowspan="6"><%=place.getPlaceHtmlcode()%></td>
				</tr>
				<tr>
					<th>음식타입</th>
					<td><%=place.getPlaceFoodtype()%></td>
				</tr>
				<tr>
					<th>추천메뉴</th>
					<td><%=place.getPlaceRecommendation()%></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><%=place.getPlaceAddress()%></td>
				</tr>
				<tr>
					<th>인근역</th>
					<td><%=place.getPlaceNearstation()%></td>
				</tr>
				<tr>
					<th></th>
					<%
					if (userID != null) {
						BookmarkDAO bmDAO = new BookmarkDAO();
					System.out.println("==== 장소아디"+placeID+" ===== 유저아디"+userID);
					if (bmDAO.isBM(placeID, userID)) {
					%>
					<td><button onclick="location.href='bookmarkProc.jsp?placeID=<%=placeID%>'">
					북마크취소</button></td>
					<%
					}else{
					%>
					<td><button onclick="location.href='bookmarkProc.jsp?placeID=<%=placeID%>'">
					북마크</button></td>
					<%
					}
					}
					%>

				</tr>
			</tbody>
		</table>
		<div class="tablebtns">
			<%
			if (userStatus != null && userStatus.equals("manager")) {
			%>
			<a href="m_updateplace.jsp?placeID=<%=place.getPlaceID()%>">장소수정</a>
			| <a href="m_delplaceProc.jsp?placeID=<%=place.getPlaceID()%>">장소삭제</a>
			|
			<%
			}
			%>
			<a href="writePComnt.jsp?placeID=<%=place.getPlaceID()%>">댓글쓰기</a> |
			<a href="place.jsp"> 목록으로 </a>
		</div>
	</div>

	<div class="cmnttable">
		<%
		PlaceCommentDAO pcmntDAO = new PlaceCommentDAO();
		ArrayList<PlaceComment> list = pcmntDAO.getListPcmnt(placeID);
		System.out.println("총 데이터 수 = " + list.size());
		for (int i = 0; i < list.size(); i++) {
		%>
		<table>
			<thead>
				<tr>
					<td style="background-color: #eeeeee; color: rgb(0, 0, 0)"><%=list.get(i).getUserID()%>
						(작성시간 : <%=list.get(i).getPcomntDate()%>)
					<td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="height: 50px; width: 100%;">
						<%
						for (int j = 0; j < list.get(i).getPcomntPoint(); j++) {
						%> ★ <%
						}
						%>
					</td>
				</tr>
				<tr>
					<td style="height: 50px; width: 100%;"><%=list.get(i).getPcomntContent()%></td>
				</tr>
				<tr style="text-align: center;">
					<td><a
						href="updatePCmnt.jsp?pcomntID=<%=list.get(i).getPcomntID()%>">수정하기</a>
						| <a
						href="delPCmntProc.jsp?pcomntID=<%=list.get(i).getPcomntID()%>">삭제하기</a></td>
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