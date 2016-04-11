package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PRGetModalInfo {
	DataSource ds;

	/**
	 * Create db pool
	 */
	public PRGetModalInfo() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public ArrayList<String> getTodo(String id){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		
		try {
			con = ds.getConnection();
			String sql = "select T.project_name from (select project_name, project_progress from project_detail where project_id in (select project_id from project_member_detail where project_member_name = ?) or project_creator= ?) as T where project_progress = 0";

			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, id);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				projects.add(rs.getString(1));
			}
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return projects;
	}
	
	public ArrayList<String> getInprogress(String id){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		
		try {
			con = ds.getConnection();

			String sql = "select T.project_name from (select project_name, project_progress from project_detail where project_id in (select project_id from project_member_detail where project_member_name = ?) or project_creator= ?) as T where project_progress = 50";

			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, id);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				projects.add(rs.getString(1));
			}
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return projects;
	}
	
	public ArrayList<String> getDone(String id){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		
		try {
			con = ds.getConnection();

			String sql = "select T.project_name from (select project_name, project_progress from project_detail where project_id in (select project_id from project_member_detail where project_member_name = ?) or project_creator= ?) as T where project_progress = 100";

			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, id);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				projects.add(rs.getString(1));
			}
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return projects;
	}
}
