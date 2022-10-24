<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="titlenav.jsp" %>
<link rel="stylesheet" href="css/home.css">
    


<%
		 if(userID == null){ //로그인하지 않으면 게시글 작성 불가
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하셔야 게시글을 작성할 수 있습니다.로그인페이지로 이동합니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 
%>			



<div class="home">
	<form method="post" action="writeProc.jsp">
	<table>
		<thead>
			<tr>
			<td colspan="2" style="background-color:#eeeeee; text-align: center; color:rgb(0,0,0)">Q&A 글쓰기 페이지</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<select name="qnaSort" style="width: 100%; height : 30px;" >
						<option>선택해주세요</option>
						<option value="addPlace">장소추가</option>
						<option value="deletePlace">장소삭제</option>
						<option value="modifyPlace">장소수정</option>
						<option value="inquiry">이용문의</option>
						<option value="etc">기타</option>
	<%
		if(userStatus != null && userStatus.equals("manager")){
	%>
						<option value="notice">공지</option>
	<%
		}
	%>
					</select>
				</td>
			</tr>
			<tr>
				<td><input type="text" class="form-control" placeholder="글제목" name="qnaTitle" style="width: 100%"></td>
			</tr>
			<tr>	
				<td><textarea class="form-control" placeholder="글내용" name="qnaContent" style="height : 350px; width: 100%"></textarea></td>
			</tr>		
		</tbody>
	</table>
		<input type="submit" class="form form-control btn" value="글쓰기">
	</form>
</div>
	





</body>
</html>