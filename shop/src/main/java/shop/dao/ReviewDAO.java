package shop.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;


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
	
	public static ArrayList<HashMap<String, Object>> selectReviewList(int goodsNo)throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "select r.score, r.content, o.goods_no goodsNo, o.orders_no ordersNo "
				+ "from review r inner join orders o "
				+ "where r.orders_no = o.orders_no and o.goods_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("score", rs.getInt("score"));
			m.put("content", rs.getString("content"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("ordersNo", rs.getInt("ordersNo"));
			
			list.add(m);
		}
		
		
		return list;
		
	}
	
	public static boolean selectReview(int ordersNo) throws Exception {
		boolean reuslt = true;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "select score, content, orders_no from review where orders_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			reuslt = false;
		}
		
		return reuslt;
	}
	
	public static int deleteReivew(int ordersNo) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "delete from review where orders_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		return row;
	}
	
}
