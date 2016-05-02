package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Member;

public class PRUpdateMember {

	DataSource ds;
	Member a;
	/**
	 * Create db pool
	 */
	public PRUpdateMember() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public void updateMember(String id,String password, String email, String info){
		
		
		try {
			Connection con = ds.getConnection();
			String sql = "update member set password=?, email=?, info=? where id=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, password);
			pstat.setString(2, email);
			pstat.setString(3, info);
			pstat.setString(4, id);
			pstat.executeUpdate();
			pstat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}
}
