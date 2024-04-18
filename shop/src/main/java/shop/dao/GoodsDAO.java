package shop.dao;

import java.sql.*;
import java.util.*;

import shop.DBHelper;

public class GoodsDAO {
	public static void main(String[] args) throws Exception {
		//System.out.println(GoodsDAO.updateGoodsAmount(1, 1));
	}
	
	public static ArrayList<HashMap<String, Object>> selectGoodsList(String category, String goodsTitle, String order, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		PreparedStatement stmt = null;
		if(category == null || category.equals("null")){
			sql = "select goods_no goodsNo, goods_title goodsTitle, file_name filename, goods_price goodsPrice" + 
					" from goods where goods_title like ? order by " + order  + " desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + goodsTitle + "%");
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			System.out.println(stmt);
		} else {
			sql = "select goods_no goodsNo, goods_title goodsTitle, file_name filename, goods_price goodsPrice" + 
					" from goods where category = ? and goods_title like ? order by " + order  + " desc limit ?, ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setString(2, "%" + goodsTitle + "%");
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
			System.out.println(stmt);
		}
		
		
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			
			list.add(m);
			
		}
		
		return list;
	}
	
	public static ArrayList<HashMap<String, Object>> selectGoodsCount(String goodsTitle) throws Exception {
		
		String sql = null;
		sql = "select category, count(*) cnt from goods where goods_title like ? group by category order by category";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + goodsTitle + "%");
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();		
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			
			categoryList.add(m);
			
		}
		
		return categoryList;
	}
	
	public static HashMap<String, Object> selectGoods(int goodsNo) throws Exception{
		
		String sql = null;
		sql = "select goods_no goodsNo, category, emp_id empId, goods_title " + 
				"goodsTitle, file_name filename, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
				"update_date updateDate, create_date createDate from goods where goods_no = ?";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		HashMap<String, Object> m = new HashMap<>();
		if(rs.next()){
			
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("empId", rs.getString("empId"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
		}
		
		return m;
	}
	
	public static int updateGoods(String filename, String category, String goodsTitle, int goodsPrice, int goodsAmount, String goodsContent, int goodsNo) throws Exception{
		
		String sql = null;
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		if(filename == null){
			sql = "update goods set category = ?, goods_title = ?, goods_price = ?, goods_amount = ?, goods_content = ? update_date = now() where goods_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setString(2, goodsTitle);
			stmt.setInt(3, goodsPrice);
			stmt.setInt(4, goodsAmount);
			stmt.setString(5, goodsContent);
			stmt.setInt(6, goodsNo);
			
		} else {
			sql = "update goods set category = ?, goods_title = ?, file_name = ?, goods_price = ?, goods_amount = ?, goods_content = ? update_date = now() where goods_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setString(2, goodsTitle);
			stmt.setString(3, filename);
			stmt.setInt(4, goodsPrice);
			stmt.setInt(5, goodsAmount);
			stmt.setString(6, goodsContent);
			stmt.setInt(7, goodsNo);
		}
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static ArrayList<String> selcetCategoryList() throws Exception {
		String sql = null;
		sql = "select category from goods group by category";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		ArrayList<String> categoryList = new ArrayList<String>();
		
		while(rs.next()){
			categoryList.add(rs.getString("category"));
		}
		
		return categoryList;
	}
	
	public static int insertGoods(String filename, String category, String empId, String goodsTitle, String goodsContent, int goodsPrice, int goodsAmount) throws Exception {
		String sql = null;
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		if(filename == null){
			sql = "insert into goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount) values (?, ?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setString(2, empId);
			stmt.setString(3, goodsTitle);
			stmt.setString(4, goodsContent);
			stmt.setInt(5, goodsPrice);
			stmt.setInt(6, goodsAmount);
			System.out.println(stmt);
		} else {
			sql = "insert into goods (category, emp_id, goods_title, goods_content, goods_price, goods_amount, file_name) values (?, ?, ?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category);
			stmt.setString(2, empId);
			stmt.setString(3, goodsTitle);
			stmt.setString(4, goodsContent);
			stmt.setInt(5, goodsPrice);
			stmt.setInt(6, goodsAmount);
			stmt.setString(7, filename);
			System.out.println(stmt);
		}
		
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static int updateGoodsAmount(int goodsNo, int amount) throws Exception {
		String sql = null;
		sql = "update goods set goods_amount = goods_amount - ?,  update_date = now() where goods_no = ? and goods_amount > ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, amount);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, goodsNo - 1);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
}
