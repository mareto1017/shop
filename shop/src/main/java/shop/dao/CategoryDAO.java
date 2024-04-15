package shop.dao;

import java.sql.*;
import java.util.*;

import shop.DBHelper;

public class CategoryDAO {
	public static ArrayList<HashMap<String, String>> selectCategoryList(String category) throws Exception{
		String sql = "select category,  create_date createDate from category where category like ?;";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + category + "%");
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, String>> categoryList = new ArrayList<>();
		while(rs.next()){
			HashMap<String, String> m = new HashMap<>();
			m.put("category", rs.getString("category"));
			m.put("createDate", rs.getString("createDate"));
			
			categoryList.add(m);
		}
		
		return categoryList;
	}
	
	public static int insertCategory(String category) throws Exception {
		String sql = "insert into category (category) values (?)";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		System.out.println(stmt);
		
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
}