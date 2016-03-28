package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;
import javax.naming.InitialContext;
/*
 * DB로 upload file정보 전송
 * */
public class PRUpload {
	DataSource ds;
	
	public PRUpload() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * attributes : fileName, id, date, projectName, className 
	 * */
	public void upLoad(String fileName, String id, String date, String projectName, String className) {
		try {
			Connection con = ds.getConnection();
			String sql = "insert into uploadlist(fileName, id, date, projectName, className) values(?, ?, ?, ?, ?)";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			
			
			pstat.setString(1, fileName);
			pstat.setString(2, id);
			pstat.setString(3, date);
			pstat.setString(4, projectName);
			pstat.setString(5, className);
			pstat.executeUpdate();

			pstat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
