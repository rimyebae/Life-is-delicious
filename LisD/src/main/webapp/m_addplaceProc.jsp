<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="place.PlaceDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="place" class="place.Place" scope="page" />
<jsp:setProperty name="place" property="placeName" />
<jsp:setProperty name="place" property="placeFoodtype" />
<jsp:setProperty name="place" property="placeRecommendation" />
<jsp:setProperty name="place" property="placeAddress" />
<jsp:setProperty name="place" property="placeNearstation" />
<jsp:setProperty name="place" property="placeHtmlcode" />


<%
System.out.println("==== 장소수정" + userStatus);
if (!userStatus.equals("manager")) { //관리자가 아니면 접속불가
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('접속 권한이 없습니다.')");
	script.println("location.href='place.jsp'");
	script.println("</script>");
}

if (place.getPlaceName() == null || place.getPlaceFoodtype() == null || place.getPlaceRecommendation() == null
		|| place.getPlaceAddress() == null || place.getPlaceNearstation() == null || place.getPlaceHtmlcode() == null) {

	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력되지 않은 사항이 있습니다.')");
	script.println("history.back()");
	script.println("</script>");
} else {

	PlaceDAO placeDAO = new PlaceDAO();
	int result = placeDAO.addPlace(place.getPlaceName(), place.getPlaceFoodtype(), place.getPlaceRecommendation(),
	place.getPlaceAddress(), place.getPlaceNearstation(), place.getPlaceHtmlcode());

	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('장소등록에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('장소등록에 성공했습니다')");
		script.println("location.href='place.jsp'");
		script.println("</script>");
	}

}
%>



</body>
</html>