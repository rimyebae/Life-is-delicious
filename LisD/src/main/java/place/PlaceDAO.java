package place;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PlaceDAO {

	private Connection conn;
	// private PreparedStatement pstmt;
	private ResultSet rs;

	public PlaceDAO() {
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
		String sql = "SELECT placeID FROM PLACE ORDER BY placeID DESC";
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

	public ArrayList<Place> getList(int pageNumber) {
		// String sql = "SELECT * FROM PLACE WHERE placeID < ? AND placeAvailable = 1
		// LIMIT 10";
		String sql = "SELECT * FROM PLACE WHERE placeID < ? AND placeAvailable = 1 ORDER BY placeID DESC LIMIT 10";
		ArrayList<Place> list = new ArrayList<Place>();

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
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

	public boolean nextPage(int pageNumber) {

		String sql = "SELECT * FROM PLACE WHERE placeID < ? AND placeAvailable = 1";

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
	

	public Place getPlace(int placeID) {
		String sql = "SELECT * FROM PLACE WHERE placeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeID);
			rs = pstmt.executeQuery();
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

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public int addPlace(String placeName, String placeFoodtype, String placeRecommendation, String placeAddress,
			String placeNearstation, String placeHtmlcode) {

		String sql = "INSERT INTO PLACE VALUE (?,?,?,?,?,?,?,?)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, placeName);
			pstmt.setString(3, placeFoodtype);
			pstmt.setString(4, placeRecommendation);
			pstmt.setString(5, placeAddress);
			pstmt.setString(6, placeNearstation);
			pstmt.setString(7, placeHtmlcode);
			pstmt.setInt(8, 1);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;// 데이터베이스 오류

	}

	public int modifyPlace(int placeID, String placeName, String placeFoodtype, String placeRecommendation,
			String placeAddress, String placeNearstation, String placeHtmlcode) {
		String sql = "UPDATE PLACE SET placeName = ?, placeFoodtype = ? , placeRecommendation = ?, placeAddress = ?, "
				+ "placeNearstation = ?, placeHtmlcode = ? WHERE placeID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, placeName);
			pstmt.setString(2, placeFoodtype);
			pstmt.setString(3, placeRecommendation);
			pstmt.setString(4, placeAddress);
			pstmt.setString(5, placeNearstation);
			pstmt.setString(6, placeHtmlcode);
			pstmt.setInt(7, placeID);

			System.out.println(pstmt);
			return pstmt.executeUpdate(); // 0이상의 숫자

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return -1;
	}

	public int deletePlace(int placeID) {

		String sql = "UPDATE PLACE SET placeAvailable = 0 WHERE placeID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, placeID);

			System.out.println(pstmt);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1;

	}

}
