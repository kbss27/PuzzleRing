package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Member;
import com.vo.Project_overview;

public class PRCreateClassMethod {
	DataSource ds;
	Project_overview overview;
	public PRCreateClassMethod()
	{
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	public Project_overview createClassMethod(String project_name){
		
		try {
			Connection con = ds.getConnection();
			String sql = "select project_creator,project_type,project_content from project_detail where project_name=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, project_name);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next())
			{
				overview = new Project_overview(rs.getString(1),project_name,rs.getString(2),rs.getString(3));
			}
			pstat.close();
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//Project_overview overview = new Project_overview(project_creator,project_name,project_type,project_detail);
		return overview;
	}
}