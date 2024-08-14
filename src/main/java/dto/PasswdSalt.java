package dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

public class PasswdSalt {
	
		private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
		private static final String USER = "root";
		private static final String PASSWD = "root";
		private static final String URL = "jdbc:mysql://localhost/bb";
		private static final String CHECK_SQL = "SELECT count(*) count FROM users WHERE user_id = ?";
		private static final String INSERT_SQL = 
			"INSERT INTO users (email,password,real_name) VALUES (?,?,?)";
		private Connection conn;
		private ResultSet rs;
		
		public PasswdSalt() throws Exception {
			Properties prop = new Properties();
			prop.put("user", USER);
			prop.put("password", PASSWD);
			
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, prop);
		}
		
		public int addNew(String email, String password, String real_name) throws Exception{
			PreparedStatement pstmt = conn.prepareStatement(INSERT_SQL);
			pstmt.setString(1, email);
			pstmt.setString(2, BCrypt.hashpw(password, BCrypt.gensalt()));
			pstmt.setString(3, real_name);
			return pstmt.executeUpdate();
		}
		
		public boolean isAccountExist(String account) throws Exception {
			PreparedStatement pstmt = conn.prepareStatement(CHECK_SQL);
			pstmt.setString(1, account);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt("count") > 0; 
		}
		
		
	
}
