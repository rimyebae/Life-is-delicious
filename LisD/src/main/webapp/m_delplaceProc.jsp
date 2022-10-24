<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<%@ page import="place.PlaceDAO"%>
<%@ page import="place.Place"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>


<%
System.out.println("==== 장소삭제" + userStatus);
if (!userStatus.equals("manager")) { //관리자가 아니면 접속불가
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('접속 권한이 없습니다.')");
	script.println("location.href='place.jsp'");
	script.println("</script>");
}

System.out.println(request.getParameter("placeID"));
int placeID = 0;

if (request.getParameter("placeID") != null) {
	placeID = Integer.parseInt(request.getParameter("placeID"));
}
if (placeID == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 접근입니다.')");
	script.println("location.href='place.jsp'");
	script.println("</script>");
}

Place place = new PlaceDAO().getPlace(placeID);



PlaceDAO placeDAO = new PlaceDAO();
int result = placeDAO.deletePlace(placeID);

if (result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('장소 삭제를 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('장소 삭제가 완료되었습니다.')");
	script.println("location.href='place.jsp'");
	script.println("</script>");
}
%>



</body>
</html>
</html>