package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import shop.DBHelper;

public class OrdersDAO {
	public static void main(String[] args) throws Exception{
		//OrdersDAO.insertOrders("test@test", 1, 1, 1, "km타워");
		
	}
	
	public static ArrayList<HashMap<String, Object>> selectOrdersListByCustomer(String mail, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = null;
		sql = "select o.orders_no ordersNo, o.goods_no goodsNo, o.mail mail, o.total_amount totalAmount, o.total_price totalPrice,"
				+ "o.address address, o.state state, o.update_date updateDate, o.create_date createDate, "
				+ "g.goods_title goodsTitle, g.category category, g.goods_price goodsPrice "
				+ "from orders o inner join goods g "
				+ "on o.goods_no = g.goods_no "
				+ "where o.mail = ? "
				+ "order by o.orders_no desc "
				+ "limit ?, ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		System.out.println(stmt);
		
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("mail", rs.getString("mail"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("address"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			
			list.add(m);
		}
		return list;
	}
	
	public static ArrayList<HashMap<String, Object>> selectOrdersList(int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = null;
		sql = "select o.orders_no ordersNo, o.goods_no goodsNo, o.mail mail, o.total_amount totalAmount, o.total_price totalPrice, "
				+ "o.address address, o.state state, o.update_date updateDate, o.create_date createDate, "
				+ "g.goods_title goodsTitle, g.category category, g.goods_price goodsPrice "
				+ "from orders o inner join goods g "
				+ " on o.goods_no = g.goods_no "
				+ "order by o.orders_no desc "
				+ "limit 0, 10";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("mail", rs.getString("mail"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("address"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			
			list.add(m);
		}
		
		
		return list;
	}
	
	public static int insertOrders(String mail, int goodsNo, int amount, int price, String address) throws Exception {
		String sql = null;
		sql = "insert into orders(mail, goods_no, total_amount, total_price, address) values(?, ?, ?, ?, ?);";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, amount);
		stmt.setInt(4, price);
		stmt.setString(5, address);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static int updateOrdersState(int ordersNo, String state) throws Exception {
		
		String sql = null;
		sql = "update orders set state = ? where orders_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, state);
		stmt.setInt(2, ordersNo);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static int selectOrdersCount() throws Exception {
		String sql = null;
		sql = "select count(*) cnt from orders";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		int count = 0;
		if(rs.next()) {
			count = rs.getInt("cnt");
		}
		
		return count;
	}
	
	public static HashMap<String, Object> selectOrders(int ordersNo) throws Exception {
		String sql = null;
		sql = "select orders_no ordersNo, mail, goods_no goodsNo, total_amount totalAmount, total_price totalPrice, address, state, update_date updateDate, create_date createDate "
				+ "from orders "
				+ "where orders_no = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		ResultSet rs = stmt.executeQuery();
		
		HashMap<String, Object> m = new HashMap<String, Object>();
		if(rs.next()) {
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("mail", rs.getString("mail"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("address"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
		}
		
		return m;
	}
	
	public static int deleteOrders(int ordersNo) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = null;
		sql = "delete from orders where orders_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		return row;
	}
	
}
