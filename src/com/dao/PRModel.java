package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Project_detail;

public class PRModel {
	DataSource ds;

	/**
	 * Create db pool
	 */
	public PRModel() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public ArrayList<Project_detail> getTodayProject(){
		Connection con;
		ArrayList<Project_detail> projects = new ArrayList<Project_detail>();
		
		try {
			con = ds.getConnection();

			Project_detail tmp = new Project_detail();
			String sql = "select project_id, project_name, project_content, project_type from todayNewProject";
			PreparedStatement pstat = con.prepareStatement(sql);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				tmp.setProject_name(rs.getString(2));
				tmp.setProject_content(rs.getString(3));
				tmp.setProject_type(rs.getString(4));
			}
			projects.add(tmp);
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return projects;
	}
	
	public void updateTodayProject(){
		Connection con;
		ArrayList<String> projects = new ArrayList<String>();
		//Date today = new Date();
		Calendar cal = Calendar.getInstance();
		
		try {
			con = ds.getConnection();

			String year = Integer.toString(cal.get(Calendar.YEAR));
			String month = Integer.toString(cal.get(Calendar.MONTH)+1);
			String day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
			
			if(month.length()!=2){
				month = "0"+month;
			}
			if(day.length()!=2){
				day = "0"+day;
			}
			String today = year+"-"+month+"-"+day;
			System.out.println(year+"-"+month+"-"+day);
			
			String sql = "delete from todayNewProject where Date != ?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, today);
			
			pstat.execute();
			pstat.close();
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
