package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import qna.Qna;



public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lisd";
			String dbID = "root";
			String dbPW = "admin";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn =  DriverManager.getConnection(dbURL,dbID,dbPW);
			
			System.out.println("==== DB연결성공");
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int login(String userID, String userPW) {
		System.out.println("====아이디"+userID); //잘넘어옴
		System.out.println("====비밀번호"+userPW); //잘넘어옴
		
		String sql = "SELECT userPW FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);  
			pstmt.setString(1, userID); 
			System.out.println(pstmt); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPW)) {
					//System.out.println("==== 로그인성공");
//					getInfo(userID);
					return 1; //로그인성공
				}else {
					//System.out.println("==== 비밀번호 불일치");
					return 0;//비밀번호 불일치
				}
				
			}
			//System.out.println("====아이디가 없음");
			return -1; // 아이디가 없음.
		}catch (Exception e) {
			e.printStackTrace();
		}
		//System.out.println("==== 데이터베이스오류");
		return -2; // 데이터베이스 오류
		
	}
	
		
	public User getUserInfo(String userID) {
		String sql = "SELECT * FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPW(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserStatus(rs.getString(6));
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public int join(User user) {
		String sql = "INSERT INTO USER (userID, userPW,userName,userGender,userEmail) VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPW());
			pstmt.setString(3,user.getUserName());
			pstmt.setString(4,user.getUserGender());
			pstmt.setString(5,user.getUserEmail());
			
			return pstmt.executeUpdate(); //0이상의 숫자 
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
	
 //TODO 널 죽여아한다
 //회원정보 수정
	public int updateUser(String userID , String userName, String userPW, String userEmail) {
		String sql = "UPDATE USER SET userName = ?, userPW = ? , userEmail = ? WHERE userID = ?";

		try {
			conn.prepareStatement(sql);
			pstmt.setString(1,userName);
			pstmt.setString(2,userPW);
			pstmt.setString(3,userEmail);
			pstmt.setString(4,userID);
			System.out.println(pstmt);
			
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1; 
	}
	
	
// 회원정보 삭제
	public int deleteUser( String userID, String userPW) {
		String sql = "DELETE FROM USER WHERE userID = ? AND userPW = ?";
		
		try {
			conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPW);
			
			return pstmt.executeUpdate();
					
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	
	
	
	
	
	}
	
	
