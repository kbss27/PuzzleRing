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

public class PRCreateProject {
	DataSource ds;
	/**
	 * Create db pool
	 */
	public PRCreateProject() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public boolean createProject(String project_creator, String project_name, String project_content){
		int p_id=0, count=1;
		int pro_id=0;
		try {
			Connection con = ds.getConnection();
			String sql = "update member set project_total = (project_total+1) where id=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, project_creator);
			
			pstat.executeUpdate();
		
			pstat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		try{
			Connection con = ds.getConnection();
			String sql = "insert into project_detail(project_name, project_content, project_creator, project_members, project_methods, project_progress) values(?, ?, ?, ?, ?, ?)";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			
			pstat.setString(1, project_name);
			pstat.setString(2, project_content);
			pstat.setString(3, project_creator);
			pstat.setInt(4, 0);
			pstat.setInt(5, 0);
			pstat.setInt(6, 0);
			
			pstat.executeUpdate();

			pstat.close();
			con.close();
			//�븯硫댁꽌 today's new project�� my porject new瑜� �뾽�뜲�씠�듃.
			}catch(SQLException e){
				e.printStackTrace();
			}//Project ID 먼저 얻어야 한다.
		
		try{
			Connection con = ds.getConnection();
			String sql = "select project_id from project_detail order by project_id desc";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery();
			
			if(rs.next()){
				pro_id = rs.getInt(1);
			}
			
			rs.close();
			pstat.close();
			con.close();
			//�븯硫댁꽌 today's new project�� my porject new瑜� �뾽�뜲�씠�듃.
			}catch(SQLException e){
				e.printStackTrace();
			}
		/*
		 * insert 하기 전에 오늘 날짜가 아닌 것들 지우는 것이 필요.
		 */
		Date curDate = new Date();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		sdf.format(curDate);
		System.out.println(sdf.format(curDate));
		

		
		try{
			Connection con = ds.getConnection();
			String sql = "delete from todayNewProject where Date != ?";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			
			pstat.setString(1, sdf.format(curDate));
			
			pstat.executeUpdate();

			pstat.close();
			con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}

		
		try{
			Connection con = ds.getConnection();
			String sql = "insert into todayNewProject(project_id, project_name, Date) values(?, ?, SYSDATE())";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			
			pstat.setInt(1, pro_id);
			pstat.setString(2, project_name);
			
			pstat.executeUpdate();

			pstat.close();
			con.close();
			return true;
			//�븯硫댁꽌 today's new project�� my porject new瑜� �뾽�뜲�씠�듃.
			}catch(SQLException e){
				e.printStackTrace();
			}
				
		return false;
	}
	
	public int getTotal(String project_creator){
		int count=0;

		try {			
			Connection con = ds.getConnection();
			String sql = "select project_total from member where id = ?";
			
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, project_creator);
			
			ResultSet rs = pstat.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			} else {
				
			}
			
			pstat.close();
			con.close();
			return count;
		} catch (SQLException e) {
			System.out.println("constructor exception");
			e.printStackTrace();
		}
		return count;
	}
}
