package shop.dao;

import java.sql.*;
import java.util.*;

import shop.DBHelper;

public class CustomerDAO {
	public static HashMap<String, Object> selectCustomer(String customerEmail, String customerPw) throws Exception{
		String sql = null;
		sql = "select mail, pw, name, birth, gender from customer where mail =? and pw = password(?)";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerEmail);
		stmt.setString(2, customerPw);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		HashMap<String, Object> loginCustomer =  new HashMap<String, Object>();
		
		if(rs.next()){
			//로그인 성공
			System.out.println("로그인성공");
			loginCustomer.put("customerEmail", rs.getString("mail"));
			loginCustomer.put("customerName", rs.getString("name"));;
			loginCustomer.put("birth", rs.getString("birth"));;
			loginCustomer.put("gender", rs.getString("gender"));;
		}
		
		return loginCustomer;
	}
	
	public static String selectCustomerMail(String customerEmail) throws Exception{
		String sql = null;
		sql = "select mail, pw, name, birth, gender from customer where mail =?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerEmail);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		String check = "O";
		
		if(rs.next()){
				check = "X";
		}
		
		return check;
	}
	
	public static int insertCustomer(String customerEmail, String customerPw, String customerName, String birth, String gender) throws Exception {
		String sql = "insert into customer (mail, pw, name, birth, gender) values (?, password(?), ?, ?, ?)";
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerEmail);
		stmt.setString(2, customerPw);
		stmt.setString(3, customerName);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
}
