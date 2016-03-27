package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;
import javax.naming.InitialContext;

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
	
	public void upLoad(String uploader, String fileName, String date) {
		try {
			Connection con = ds.getConnection();
			String sql = "insert into project_detail(project_name, project_content, project_creator, project_members, project_methods, project_progress) values(?, ?, ?, ?, ?, ?)";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			
			
			pstat.setString(1, uploader);
			pstat.setString(2, fileName);
			pstat.setString(3, date);
			pstat.setInt(4, 0);
			pstat.setInt(5, 0);
			pstat.setInt(6, 0);
			
			pstat.executeUpdate();

			pstat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
