<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>
<%@ page import="java.io.PrintWriter" %>
<link rel="stylesheet" href="css/home.css">
    


<%
		System.out.println("==== 장소추가"+userStatus);

		 if(!userStatus.equals("manager")){ //관리자가 아니면 접속불가
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접속 권한이 없습니다.')");
			script.println("location.href='place.jsp'");
			script.println("</script>");
		} 
%>			
<div class="home">
	<form method="post" action="m_addplaceProc.jsp">
	<table>
		<thead>
			<tr>
			<td colspan="2" style="background-color:#eeeeee; text-align: center; color:rgb(0,0,0)">장소 등록 페이지</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" class="form-control" placeholder="장소이름" name="placeName" style="width: 100%"></td>
			</tr>
			<tr>
				<td><input type="text" class="form-control" placeholder="음식타입" name="placeFoodtype" style="width: 100%"></td>
			</tr>
			<tr>
				<td><input type="text" class="form-control" placeholder="추천메뉴" name="placeRecommendation" style="width: 100%"></td>
			</tr>
			<tr>	
				<td><textarea class="form-control" placeholder="가게주소" name="placeAddress" style="height : 100px; width: 100%"></textarea></td>
			</tr>		
			<tr>
				<td><input type="text" class="form-control" placeholder="인근역" name="placeNearstation" style="width: 100%"></td>
			</tr>
			<tr>	
				<td><textarea class="form-control" placeholder="HTML지도코드" name="placeHtmlcode" style="height : 100px; width: 100%"></textarea></td>
			</tr>		
		</tbody>
	</table>
		<input type="submit" class="form form-control btn" value="장소추가하기">
	</form>
</div>
	





</body>
</html>