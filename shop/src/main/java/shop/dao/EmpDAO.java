package shop.dao;

import java.sql.*;
import java.util.*;

import shop.DBHelper;

public class EmpDAO {
	
    // HashMap<String, Object> : null이면 로그인실패, 아니면 성공
	// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
   
	// Emp 로그인
	// 파라미터 : empId, empPw
	// empId, empPw가 같은 Emp를 반환(HashMap)
	public static HashMap<String, Object> selectEmp(String empId, String empPw)
                                       throws Exception {
		HashMap<String, Object> resultMap = null;
      
		// DB 접근
		Connection conn = DBHelper.getConnection();
      
		String sql = "select emp_id empId, emp_name empName, grade from emp where active = 'ON' and emp_id =? and emp_pw = password(?)";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
		}
		conn.close();
		return resultMap;
   }
	
	// Emp active 수정
	// 파라미터 : active, empId
	// empId가 같은 emp의 active 값을 파라미터로 받은 active로 변경, 성공 1, 실패 0 반환(int)
	public static int updateEmp(String active, String empId) throws Exception{
		
		String sql = null;
		sql = "update emp set active = ? update_date = now() where emp_id = ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, active);
		stmt.setString(2, empId);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// emp 목록
	// 파라미터 : order(정렬), paramEmpName(검색 값), startRow, rowPerPage
	// emp를 startRow부터 rowPerPage 만큼 반환(ArrayList<HashMap<String, Object>>)
	public static ArrayList<HashMap<String, Object>> selectEmpList(String order, String paramEmpName, int startRow, int rowPerPage) throws Exception {
		String sql = null;
		sql = "select emp_id empId, emp_name empName, emp_job empJob,  hire_date hireDate, active from emp where emp_name like ? order by " + order +" asc limit ? , ?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + paramEmpName + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		System.out.println(stmt);
		ResultSet rs = null;
		rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			String empId = rs.getString("empId");
			String empName = rs.getString("empName");
			String empJob = rs.getString("empJob");
			String hireDate = rs.getString("hireDate");
			String active = rs.getString("active");
			
			m.put("empId", empId);
			m.put("empName", empName);
			m.put("empJob", empJob);
			m.put("hireDate", hireDate);
			m.put("active", active);
			
			list.add(m);
			
		}
		
		return list;
	}
	
	// 고객 수
	// 파라미터 : paramEmpName(검색 값)
	// paramEmpName가 empName에 포함된 emp의 숫자를 반환(int)
	public static int selectEmpCount(String paramEmpName)throws Exception {
		String sql = null;
		sql = "select count(*) cnt from emp where emp_name like ? ";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramEmpName);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		int count = 0;
		if(rs.next()){
			 count = rs.getInt("cnt");
		}
		
		return count;
	}
	
	// emp 회원가입
	// 파라미터 : empId, empPw, empName, empJob, hireDate
	// 파라미터 값들을 DB에 입력, 입력 성공 1, 실패 0 반환(int)
	public static int insertEmp(String empId, String empPw, String empName, String empJob, String hireDate) throws Exception {
		String sql = "insert into emp (emp_id, emp_pw, emp_name, emp_job, hire_date) values (?, password(?), ?, ?, ?)";
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		stmt.setString(5, hireDate);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
	
		return row;
	}
}