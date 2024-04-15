package shop;

import java.io.FileReader;
import java.sql.*;
import java.util.Properties;

public class DBHelper {
	public static Connection getConnection() throws Exception {
		
		FileReader fr = new FileReader("d:\\auth\\mariadb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop",id, pw);
		
		return conn;
	}
}
