<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp"%>
<link rel="stylesheet" href="css/home.css">






<%
if (userID == null) { //로그인하지 않으면 게시글 작성 불가
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하셔야 댓글을 작성하실 수 있습니다.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");
}

int placeID = 0;
if (request.getParameter("placeID") != null) {
	placeID = Integer.parseInt(request.getParameter("placeID"));
	System.out.println(placeID);
}
%>
<div class="home">
	<form method="post" action="writePCmntProc.jsp?placeID=<%=placeID%>">
		<table>
			<thead>
				<tr>
					<td colspan="2"
						style="background-color: #eeeeee; text-align: center; color: rgb(0, 0, 0)">맛집
						댓글 쓰기</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>작성자 : <%=userID%> <input type="hidden" name="userID"
						value="<%=userID%>"></td>
				</tr>
				<tr>
					<td>
					<select name="pcomntPoint" style="width: 100%; height : 30px;" >
						<option>선택해주세요</option>
						<option value="5">★★★★★</option>
						<option value="4">★★★★</option>
						<option value="3">★★★</option>
						<option value="2">★★</option>
						<option value="1">★</option>
					</select>	
					</td>
				</tr>
				<tr>
					<td><textarea class="form-control" placeholder="글내용"
							name="pcomntContent" style="height: 100px; width: 100%"></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="form form-control btn" value="글쓰기">
	</form>
</div>





</body>
</html>