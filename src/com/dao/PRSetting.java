package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Member;

public class PRSetting {
	DataSource ds;
	Member a;
	/**
	 * Create db pool
	 */
	public PRSetting() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public Member getUserInfo(String id){
		
		
		try {
			Connection con = ds.getConnection();
			String sql = "select password, email, info from member where id=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, id);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next())
			{
				a = new Member(id, rs.getString(1),rs.getString(2),rs.getString(3));
			}
			pstat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return a;
		
	}
}
