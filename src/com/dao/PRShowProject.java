package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Member;
import com.vo.Project_detail;

public class PRShowProject {
	DataSource ds;

	/**
	 * Create db pool
	 */
	public PRShowProject() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public ArrayList<Project_detail> getProjectDetail(String creator){
		Connection con;
		ArrayList<Project_detail> myprojects = new ArrayList<Project_detail>();
		Project_detail p_detail;
		try {
			con = ds.getConnection();

			String sql = "select project_name, project_content from project_detail where project_creator = ? order by project_id desc";
			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, creator);
			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				//System.out.println(rs.getString(1)+" " +rs.getString(2)+" " +rs.getString(3));
				p_detail = new Project_detail(rs.getString(1), rs.getString(2), rs.getString(3));
				myprojects.add(p_detail);
			}
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return myprojects;
	}
}
