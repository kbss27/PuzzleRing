<<<<<<< HEAD
package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Project_overview;

public class PRCheckProjectState {
	DataSource ds;
	int id;
	int count;
	public PRCheckProjectState()
	{
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	public int checkProjectState(String project_name){
		
		try {
			Connection con = ds.getConnection();
			String sql = "select project_id from project_detail where project_name=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, project_name);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next())
			{
				id = rs.getInt(1);
			}
			pstat.close();
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			Connection con = ds.getConnection();
			String sql = "select Count(class_name) from class_detail where project_id=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setInt(1, id);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next())
			{
				count = rs.getInt(1);
			}
			pstat.close();
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}
=======
package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Project_overview;

public class PRCheckProjectState {
	DataSource ds;
	int id;
	int count;
	public PRCheckProjectState()
	{
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	public int checkProjectState(String project_name){
		
		try {
			Connection con = ds.getConnection();
			String sql = "select project_id from project_detail where project_name=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, project_name);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next())
			{
				id = rs.getInt(1);
			}
			pstat.close();
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			Connection con = ds.getConnection();
			String sql = "select Count(class_name) from class_detail where project_id=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setInt(1, id);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next())
			{
				count = rs.getInt(1);
			}
			pstat.close();
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}
>>>>>>> 351cf939fd9a38581ae639cb731ed0a7b278792c
}