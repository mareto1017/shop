package shop.dao;

import java.sql.*;
import java.util.*;

import shop.DBHelper;

public class CustomerDAO {
	
	public static void main(String[] args) throws Exception {
		//System.out.println(CustomerDAO.selectCustomerList("mail", "", 0, 10));
	}
	
	// 고객 로그인
	// 파라미터 : mail, pw
	// mail과 pw 값이 같은 customer를 반환(HashMap)
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
	
	// 고객 이메일 중복 체크
	// 파라미터 : mail
	// mail 값이 같은 customer가 있는지 확인후, 있으면 X 없으면 O 반환(String)
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
	
	// 고객 회원가입
	// 파라미터 : mail, pw, name, birth, gender
	// 받은 값들을 DB에 입력후, 입력이 되었으면 1, 아니면 0 반환(int)
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
	
	// 고객 회원 탈퇴
	// 파라미터 : mail, pw 
	// mail과 pw 값이 같은 customer를 삭제, 삭제 성공하면 1, 실패하면 0 반환(int)
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
	
	// 고객 비밀번호 수정
	// 파라미터로 mail, oldPw, newPw
	// mail과 oldPw(pw) 같은 customer의 pw를 newPw로 변경, 성공시 1, 실패시 0 반환(int)
	public static int updateCustomerPw(String mail, String oldPw, String newPw) throws Exception{
		String sql = "update customer set pw = password(?), update_date = now() where mail = ? and pw = password(?)";
		
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
	
	// 고객 목록
	// 파라미터 : order(정렬), mail(검색 값), startRow, rowPerPage
	// customer를 startRow부터 rowPerPage 만큼 반환(ArrayList<HashMap<String, Object>>)
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
	
	// 고객 수
	// 파라미터 : paramCustomerMail(검색 값)
	// paramCustomerMail가 mail에 포함된 customer의 숫자를 반환(int)
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
