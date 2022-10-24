package qnacomment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import qna.Qna;

public class QnaCommentDAO {
	
	
	private Connection conn;
//	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public QnaCommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lisd";
			String dbID = "root";
			String dbPW = "admin";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);

			System.out.println("==== DB연결성공");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//다음 댓글아이디 구하는 함수
	public int getNext() {

		// String sql = "SELECT placeID FROM PLACE";
		String sql = "SELECT qcomntID FROM COMMENT_QNA ORDER BY qcomntID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물일 경우
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	//시간
	public String getDate() {
		String sql = "SELECT NOW()";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	
	public ArrayList<QnaComment> getListQcmnt(int qnaID) {
		// String sql = "SELECT * FROM PLACE WHERE placeID < ? AND placeAvailable = 1
		// LIMIT 10";
		String sql = "SELECT * FROM COMMENT_QNA WHERE qnaID = ? AND qcomntAvailable = 1 ORDER BY qcomntID DESC";
		ArrayList<QnaComment> list = new ArrayList<QnaComment>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaID);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QnaComment qnacmnt = new QnaComment();
				qnacmnt.setQnaID(rs.getInt(1));
				qnacmnt.setUserID(rs.getString(2));
				qnacmnt.setQcomntID(rs.getInt(3));
				qnacmnt.setQcomntDate(rs.getString(4));
				qnacmnt.setQcomntContent(rs.getString(5));
				qnacmnt.setQcomntAvailable(rs.getInt(6));
				list.add(qnacmnt);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public QnaComment getQnaCmnt(int qcomntID) {
		String sql = "SELECT * FROM COMMENT_QNA WHERE qcomntID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qcomntID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				QnaComment qnacmnt = new QnaComment();
				qnacmnt.setQnaID(rs.getInt(1));
				qnacmnt.setUserID(rs.getString(2));
				qnacmnt.setQcomntID(rs.getInt(3));
				qnacmnt.setQcomntDate(rs.getString(4));
				qnacmnt.setQcomntContent(rs.getString(5));
				qnacmnt.setQcomntAvailable(rs.getInt(6));
				return qnacmnt;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public int writeQcomnt(int qnaID, String userID, String qcomntContent) {

		String sql = "INSERT INTO COMMENT_QNA VALUE (?,?,?,?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, getNext());
			pstmt.setString(4, getDate());
			pstmt.setString(5, qcomntContent);
			pstmt.setInt(6, 1);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;// 데이터베이스 오류
	}
	
	
	public int updateQcmnt(int qcomntID, String qcomntContent) {
		
		String sql = "UPDATE COMMENT_QNA SET qcomntContent = ? WHERE qcomntID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,qcomntContent);
			pstmt.setInt(2,qcomntID);
			
			System.out.println(pstmt);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public int delQcmnt(int qcomntID) {
		
		String sql = "UPDATE COMMENT_QNA SET qcomntAvailable = 0 WHERE qcomntID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,qcomntID);
			
			System.out.println(pstmt);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}

}
