package shop.dao;

import java.sql.*;

import shop.DBHelper;

public class ReviewDAO {
	
	public static void main(String[] args) throws Exception {
		//System.out.println(ReviewDAO.insertReview(1, 1, "테스트"));
	}
	
	public static int insertReview(int ordersNo, int score, String content) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "insert into review(orders_no, score, content) values(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, score);
		stmt.setString(3, content);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		return row;
	}
}
