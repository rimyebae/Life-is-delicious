<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>
<%@ page import="placecomment.PlaceComment" %>
<%@ page import="placecomment.PlaceCommentDAO"%>
<link rel="stylesheet" href="css/home.css">
    

<%
		 if(userID == null){ //로그인하지 않으면 게시글 작성 불가
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하셔야 댓글을 수정하실 수 있습니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 

		int pcomntID = 0;
		if (request.getParameter("pcomntID") != null) {
			pcomntID = Integer.parseInt(request.getParameter("pcomntID"));
			System.out.println(pcomntID);
		}
		
	    PlaceComment pcomnt = new PlaceCommentDAO().getPlaceCmnt(pcomntID);
		
		if(!userID.equals(pcomnt.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정권한이 없습니다.')");
			script.println("location.href='place.jsp'");
			script.println("</script>");
		}
%>			
<div class="home">
	<form method="post" action="updatePCmntProc.jsp?pcomntID=<%=pcomntID%>">
	<table>
		<thead>
			<tr>
			<td colspan="2" style="background-color:#eeeeee; text-align: center; color:rgb(0,0,0)">장소 댓글 수정</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>작성자 : <%=pcomnt.getUserID()%></td>
			<tr>	
			<tr>
				<td>별점 : <%=pcomnt.getPcomntPoint()%></td>
			<tr>	
				<td><textarea class="form-control" placeholder="글내용" name="pcomntContent" style="height : 100px; width: 100%"><%=pcomnt.getPcomntContent() %></textarea></td>
			</tr>		
		</tbody>
	</table>
		<input type="submit" class="form form-control btn" value="댓글수정">
	</form>
</div>
	





</body>
</html>