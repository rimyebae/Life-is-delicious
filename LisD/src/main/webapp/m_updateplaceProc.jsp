<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>    
<%@ page import="place.PlaceDAO"%>
<%@ page import="place.Place"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>



	<%
	System.out.println("==== 장소수정 process" + userStatus);
	if (!userStatus.equals("manager")) { //관리자가 아니면 접속불가
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접속 권한이 없습니다.')");
		script.println("location.href='place.jsp'");
		script.println("</script>");
	}

	int placeID = 0;
	if (request.getParameter("placeID") != null) {
		placeID = Integer.parseInt(request.getParameter("placeID"));
		System.out.println(placeID);
	}

	if (placeID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 접근입니다.')");
		script.println("location.href='place.jsp'");
		script.println("</script>");
	}

	Place place = new PlaceDAO().getPlace(placeID);
		
		
		if(request.getParameter("placeName") == null || request.getParameter("placeFoodtype") == null 
		    || request.getParameter("placeRecommendation") == null || request.getParameter("placeAddress") == null
		    || request.getParameter("placeNearstation") == null || request.getParameter("placeHtmlcode") == null ){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			
			
			PlaceDAO placeDAO = new PlaceDAO();
			int result = placeDAO.modifyPlace(placeID, request.getParameter("placeName"), request.getParameter("placeFoodtype"), 
					request.getParameter("placeRecommendation"), request.getParameter("placeAddress"),
					request.getParameter("placeNearstation"), request.getParameter("placeHtmlcode"));
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('장소수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('장소수정에 성공했습니다')");
				script.println("location.href='place.jsp'");
				script.println("</script>");
			}
			
			
		}
	
	%>



</body>
</html>