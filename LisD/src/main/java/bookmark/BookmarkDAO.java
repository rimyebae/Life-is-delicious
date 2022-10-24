package bookmark;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import place.Place;

public class BookmarkDAO {
	
	private Connection conn;
	// private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BookmarkDAO() {
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
	
	public ArrayList<Place> getList(String userID, int pageNumber) {
		
		// String sql = "SELECT * FROM PLACE WHERE placeID < ? AND placeAvailable = 1
		// String sql = "SELECT * FROM PLACE WHERE placeID IN (select placeID from BOOKMARK where userID = ?) ORDER BY placeID DESC LIMIT 10";
		String sql = "SELECT * FROM PLACE WHERE placeID IN "
				+ "(select placeID from BOOKMARK where userID = ?) ORDER BY placeID";
		ArrayList<Place> list = new ArrayList<Place>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userID);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Place place = new Place();
				
				place.setPlaceID(rs.getInt(1));
				place.setPlaceName(rs.getString(2));
				place.setPlaceFoodtype(rs.getString(3));
				place.setPlaceRecommendation(rs.getString(4));
				place.setPlaceAddress(rs.getString(5));
				place.setPlaceNearstation(rs.getString(6));
				place.setPlaceHtmlcode(rs.getString(7));
				place.setPlaceAvailable(rs.getInt(8));
				list.add(place);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	
	
	  public Place getBM(int placeID , String userID) { 
		  String sql = "SELECT * FROM PLACE WHERE placeID = ? AND userID = ?"; 
	  try {
		  PreparedStatement pstmt = conn.prepareStatement(sql); pstmt.setInt(1,
				  placeID); rs = pstmt.executeQuery(); 
	  if (rs.next()) { 
			  Place place = new Place(); 
			  place.setPlaceID(rs.getInt(1)); 
			  place.setPlaceName(rs.getString(2));
			  place.setPlaceFoodtype(rs.getString(3));
			  place.setPlaceRecommendation(rs.getString(4));
			  place.setPlaceAddress(rs.getString(5));
			  place.setPlaceNearstation(rs.getString(6));
			  place.setPlaceHtmlcode(rs.getString(7));
			  place.setPlaceAvailable(rs.getInt(8)); 
			  return place; 
		  }
	  
	  
	  } catch (SQLException e) { e.printStackTrace(); } 
	  return null;
}
	  
	
	public int addBM(int placeID , String userID) {
		String sql = "INSERT INTO BOOKMARK VALUE (?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,getNextBM(userID));
			pstmt.setInt(2, placeID);
			pstmt.setString(3, userID);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;// 데이터베이스 오류

	}
	
	public int delBM(int placeID , String userID) {
		String sql = "DELETE FROM BOOKMARK WHERE placeID = ? AND userID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeID);
			pstmt.setString(2, userID);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;// 데이터베이스 오류

	}
	
	public boolean isBM(int placeID, String userID) { //값이 있는지 체크하는 함수
		System.out.println("====장소번호"+placeID);
		System.out.println("====아이디"+userID);
		String sql = "SELECT * FROM BOOKMARK WHERE placeID = ? AND userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeID);
			pstmt.setString(2, userID);
			System.out.println(pstmt);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	public int getNextBM(String userID) { //다음 숫자가 뭔지 bmID

		String sql = "SELECT COUNT(*) FROM PLACE WHERE placeID IN (select placeID from BOOKMARK where userID = ?) ORDER BY placeID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userID);
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
	
	
	public boolean nextPage(String userID , int pageNumber) {

		String sql = "SELECT * FROM BOOKMARK WHERE bmID < ? AND userID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNextBM(userID) - (pageNumber - 1) * 10);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	
	
	
	
}
