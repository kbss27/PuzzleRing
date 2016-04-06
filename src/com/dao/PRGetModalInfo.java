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
	
	public ArrayList<String> getTodo(){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		
		try {
			con = ds.getConnection();

			String sql = "select project_name from project_detail where project_progress = 0";
			PreparedStatement pstat = con.prepareStatement(sql);

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
	
	public ArrayList<String> getInprogress(){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		
		try {
			con = ds.getConnection();

			String sql = "select project_name from project_detail where project_progress = 50";
			PreparedStatement pstat = con.prepareStatement(sql);

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
	
	public ArrayList<String> getDone(){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		
		try {
			con = ds.getConnection();

			String sql = "select project_name from project_detail where project_progress = 100";
			PreparedStatement pstat = con.prepareStatement(sql);

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
