package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import qna.Qna;

public class QnaDAO {

	private Connection conn;
//	private PreparedStatement pstmt;
	private ResultSet rs;

	public QnaDAO() {
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

	public int getNext() {

		// String sql = "SELECT placeID FROM PLACE";
		String sql = "SELECT qnaID FROM QNA ORDER BY qnaID DESC";
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

	public int write(String qnaSort, String qnaTitle, String userID, String qnaContent) {

		String sql = "INSERT INTO QNA VALUE (?,?,?,?,?,?,?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, qnaSort);
			pstmt.setString(5, qnaTitle);
			pstmt.setString(6, qnaContent);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 1);
			pstmt.setInt(9, 0);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;// 데이터베이스 오류

	}

	public ArrayList<Qna> getList(int pageNumber) {
		// String sql = "SELECT * FROM PLACE WHERE placeID < ? AND placeAvailable = 1
		// LIMIT 10";
		String sql = "SELECT * FROM QNA WHERE qnaID < ? AND qnaAvailable = 1 ORDER BY qnaID DESC LIMIT 10";
		ArrayList<Qna> list = new ArrayList<Qna>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Qna qna = new Qna();
				qna.setQnaID(rs.getInt(1));
				qna.setUserID(rs.getString(2));
				qna.setQnaDate(rs.getString(3));
				qna.setQnaSort(rs.getString(4));
				qna.setQnaTitle(rs.getString(5));
				qna.setQnaContent(rs.getString(6));
				qna.setQnaStatus(rs.getInt(7));
				qna.setQnaAvailable(rs.getInt(8));
				list.add(qna);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {

		String sql = "SELECT * FROM QNA WHERE qnaID < ? AND qnaAvailable = 1";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public Qna getQna(int qnaID) {
		String sql = "SELECT * FROM QNA WHERE qnaID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Qna qna = new Qna();
				qna.setQnaID(rs.getInt(1));
				qna.setUserID(rs.getString(2));
				qna.setQnaDate(rs.getString(3));
				qna.setQnaSort(rs.getString(4));
				qna.setQnaTitle(rs.getString(5));
				qna.setQnaContent(rs.getString(6));
				qna.setQnaStatus(rs.getInt(7));
				qna.setQnaAvailable(rs.getInt(8));
				return qna;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(int qnaID, String qnaTitle, String qnaContent) {
		String sql = "UPDATE QNA SET qnaTITLE = ?, qnaContent = ? WHERE qnaID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qnaTitle);
			pstmt.setString(2, qnaContent);
			pstmt.setInt(3, qnaID);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;

	}
	
	
	
	public int delete(int qnaID) {
		String sql = "UPDATE QNA SET qnaAvailable = 0 WHERE qnaID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaID);
			
			System.out.println(pstmt);
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	
	public int checked(int qnaID) {
		String sql = "UPDATE QNA SET qnaChecked = 1 WHERE qnaID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qnaID);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	

}
