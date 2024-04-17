package shop.dao;

import java.sql.*;
import java.util.*;

import shop.DBHelper;

public class CustomerDAO {
	
	public static void main(String[] args) throws Exception {
		//System.out.println(CustomerDAO.selectCustomerList("mail", "", 0, 10));
	}
	
	public static HashMap<String, Object> selectCustomer(String mail, String pw) throws Exception{
		String sql = null;
		sql = "select mail, pw, name, birth, gender from customer where mail =? and pw = password(?)";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		HashMap<String, Object> loginCustomer = null; 
		
		if(rs.next()){
			loginCustomer = new HashMap<String, Object>();
			//로그인 성공
			System.out.println("로그인성공");
			loginCustomer.put("customerEmail", rs.getString("mail"));
			loginCustomer.put("customerName", rs.getString("name"));;
			loginCustomer.put("birth", rs.getString("birth"));;
			loginCustomer.put("gender", rs.getString("gender"));;
		}
		
		return loginCustomer;
	}
	
	public static String selectCustomerMail(String mail) throws Exception{
		String sql = null;
		sql = "select mail, pw, name, birth, gender from customer where mail =?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		String check = "O";
		
		if(rs.next()){
				check = "X";
		}
		
		return check;
	}
	
	public static int insertCustomer(String mail, String pw, String name, String birth, String gender) throws Exception {
		String sql = "insert into customer (mail, pw, name, birth, gender) values (?, password(?), ?, ?, ?)";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static int deleteCustomer(String mail, String pw) throws Exception {
		
		String sql = "delete from customer where mail = ? and pw = password(?)";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static int updateCustomerPw(String mail, String oldPw, String newPw) throws Exception{
		String sql = "update customer set pw = password(?) update_date = now() where mail = ? and pw = password(?)";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, mail);
		stmt.setString(3, oldPw);
		
		
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	public static ArrayList<HashMap<String, Object>> selectCustomerList(String order, String mail, int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		String sql = null;
		sql = "select mail, pw, name, birth, gender from customer where mail like ? order by " + order + " asc limit ? , ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + mail + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			String customerMail = rs.getString("mail");
			String customerPw = rs.getString("pw");
			String customerName = rs.getString("name");
			String birth = rs.getString("birth");
			String gender = rs.getString("gender");
			
			m.put("customerMail", customerMail);
			m.put("customerPw", customerPw);
			m.put("customerName", customerName);
			m.put("birth", birth);
			m.put("gender", gender);
			
			list.add(m);
			
		}
		
		
		return list;
	}
	
	public static int selectCustomerCount(String paramCustomerMail)throws Exception {
		String sql = null;
		sql = "select count(*) cnt from customer where mail like ? ";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCustomerMail);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		int count = 0;
		if(rs.next()){
			 count = rs.getInt("cnt");
		}
		
		return count;
	}
}
