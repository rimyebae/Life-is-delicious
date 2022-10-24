package placecomment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import qnacomment.QnaComment;

public class PlaceCommentDAO {
	
	private Connection conn;
	// private PreparedStatement pstmt;
	private ResultSet rs;

	
	
	public PlaceCommentDAO() {
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
	
	public int getNext() {

		// String sql = "SELECT placeID FROM PLACE";
		String sql = "SELECT pcomntID FROM COMMENT_PLACE ORDER BY pcomntID DESC";
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
	
	public ArrayList<PlaceComment> getListPcmnt(int placeID){
		
		String sql = "SELECT * FROM COMMENT_PLACE WHERE placeID = ? AND pcomntAvailable = 1  ORDER BY pcomntID DESC";
		ArrayList<PlaceComment> list =  new ArrayList<PlaceComment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeID);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PlaceComment pcmnt = new PlaceComment();
				pcmnt.setPlaceID(rs.getInt(1));
				pcmnt.setUserID(rs.getString(2));
				pcmnt.setPcomntID(rs.getInt(3));
				pcmnt.setPcomntDate(rs.getString(4));
				pcmnt.setPcomntPoint(rs.getInt(5));
				pcmnt.setPcomntContent(rs.getString(6));
				pcmnt.setPcomntAvailable(rs.getInt(7));
				list.add(pcmnt);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	

	public PlaceComment getPlaceCmnt(int pcomntID) {
		String sql = "SELECT * FROM COMMENT_PLACE WHERE pcomntID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pcomntID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				PlaceComment pcmnt = new PlaceComment();
				pcmnt.setPlaceID(rs.getInt(1));
				pcmnt.setUserID(rs.getString(2));
				pcmnt.setPcomntID(rs.getInt(3));
				pcmnt.setPcomntDate(rs.getString(4));
				pcmnt.setPcomntPoint(rs.getInt(5));
				pcmnt.setPcomntContent(rs.getString(6));
				pcmnt.setPcomntAvailable(rs.getInt(7));
				return pcmnt;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	public int writePcomnt(int placeID, String userID, int pcomntPoint, String pcomntContent) {

		String sql = "INSERT INTO COMMENT_PLACE VALUE (?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, getNext());
			pstmt.setString(4, getDate());
			pstmt.setInt(5, pcomntPoint);
			pstmt.setString(6, pcomntContent);
			pstmt.setInt(7, 1);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;// 데이터베이스 오류
	}
	
	
	
	public int updatePcmnt(int pcomntID, String pcomntContent) {
		String sql = "UPDATE COMMENT_PLACE SET  pcomntContent = ? WHERE pcomntID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,pcomntContent);
			pstmt.setInt(2,pcomntID);
			System.out.println(pstmt);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
public int delQcmnt(int qcomntID) {
		
		String sql = "UPDATE COMMENT_PLACE SET qcomntAvailable = 0 WHERE qcomntID = ?";
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
