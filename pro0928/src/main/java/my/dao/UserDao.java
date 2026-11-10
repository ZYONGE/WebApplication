package my.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import my.model.User;
import my.util.JdbcUtil;

public class UserDao {
	
	public void insert(Connection conn, User user) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("insert into user values(?,?,?,?)");
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setTimestamp(4, new Timestamp(user.getRegisterTime().getTime()));
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public boolean idCheck(Connection conn, String userId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement
			("select * from user where userId = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()){
				return true;
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return false;
	}
	
	public User selectById(Connection conn, String userId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		User user = null; 
		try {
			pstmt = conn.prepareStatement
			("select * from user where userId = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()){
				user = new User(); 
				user.setUserId(rs.getString(1));
				user.setPassword(rs.getString(2));
				user.setName(rs.getString(3));
				user.setRegisterTime(rs.getTimestamp(4));
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return user;
	}
	
	public boolean checkPassword(Connection conn, String userId, String password) 
	throws SQLException{
		User user = selectById(conn, userId); 
		if (user.getPassword().equals(password)==true)
			return true;
		else
			return false;
	}
	
	public List<User> selectLike(Connection conn, String target, String keyword) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		User user = null; 
		List<User> users = new ArrayList<User>();
		try {
			pstmt = conn.prepareStatement
			("select * from user where " +target +" like ?");
			pstmt.setString(1, "%"+keyword+"%");
			rs = pstmt.executeQuery();
			while (rs.next()){
				user = new User(); 
				user.setUserId(rs.getString(1));
				user.setPassword(rs.getString(2));
				user.setName(rs.getString(3));
				user.setRegisterTime(rs.getTimestamp(4));
				users.add(user);
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return users;
	}
	
	public void update(Connection conn, User user) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("update user set password=?,name=? where userId=?");
			pstmt.setString(1, user.getPassword());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getUserId());
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public void deleteById(Connection conn, String userId) 
			throws SQLException {
		PreparedStatement pstmt=null; 		
		try {
			pstmt = conn.prepareStatement
			("delete from user where userId = ?");
			pstmt.setString(1, userId);
			pstmt.executeUpdate();			
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public int selectCount(Connection conn) throws SQLException {
		Statement stmt = null; 
		ResultSet rs = null; 
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from user");
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
		}
	}
	
	public List<User> selectList(Connection conn) 
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<User> userList = null;
		try {
			pstmt = conn.prepareStatement
					("select * from user ");			
			rs  = pstmt.executeQuery(); 
			userList = new ArrayList<User>();
			while (rs.next()){
				User user = new User();
				user.setUserId(rs.getString(1));
				user.setPassword(rs.getString(2));
				user.setName(rs.getString(3));
				user.setRegisterTime(rs.getTimestamp(4));
				userList.add(user);
			}
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return userList;
	}
}




















