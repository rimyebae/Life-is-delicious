<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="mypage.jsp"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList"%>


<div class="main">
<%
	UserDAO userDAO = new UserDAO();
	User user = userDAO.getUserInfo(userID);
	
%>
	<h1>계정관리</h1>
		<div class="userUpdate">
			<span>회원정보수정</span>
			<div class="userUpdateForm">
				<form method="post" action="accountProc.jsp">
					<table>
						<tr>
							<th>
								<input type="hidden" class="form-control" placeholder="이름" name="userID" maxlength="20" value="<%=user.getUserID() %>">
							</th>
						</tr>				
						<tr>
							<th>
								<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%=user.getUserName() %>">
							</th>
						</tr>				
						<tr>
							<th>
								<input type="text" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20" value="<%=user.getUserPW() %>" >
							</th>
						</tr>				
						
						<tr>
							<th>
								<input type="email" class="form-control" placeholder="이메일" name="userEmail" value="<%=user.getUserEmail() %>">
							</th>
						</tr>				
						<tr>
							<th>
								<button type="submit">회원정보수정</button>
							</th>
						</tr>
					</table>
				</form>
			</div>
		</div>
		
		
	<div class="userDeleteForm">
			<span>회원탈퇴</span>
			<div class="delconfirm">
				<form method="post" action="accountProc.jsp?mod=2">
					<input type="text" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20">
					<input type="hidden" class="form-control" name="userID" value = "<%=userID %>">
					<button type="submit" onclick=<% %>>회원탈퇴</button>
				</form>	
			</div>
		</div>

</div>
</body>
</html>