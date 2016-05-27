package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Project_detail;
import com.vo.UploadFile;

public class PRShowUploadList {
	DataSource ds;
	public PRShowUploadList() {
		try {
			InitialContext context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc/mysql");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<UploadFile> getFileList(String projectName) {
		Connection con;
		ArrayList<UploadFile> files = new ArrayList<UploadFile>();
		UploadFile file;
		try {
			con = ds.getConnection();

			String sql = "select fileName, id, date, projectName, className from uploadlist where projectName = ? order by date desc";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, projectName);
			
			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				file = new UploadFile(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
				System.out.println(file.getId() + " / " + file.getFileName() + " / " + file.getDate() + " / " + file.getProjectName() + " / " + file.getClassName());
				files.add(file);
				
				System.out.println("Current size :: " + files.size());
			}
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return files;
	}
	
	public ArrayList<String> getClassList(String projectName) {
		Connection con;
		ArrayList<String> classlist = new ArrayList<String>();
		
		try {
			con = ds.getConnection();

			String sql = "select class_name from class_detail where project_id in (select project_id from project_detail where project_name = ?)";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, projectName);
			
			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				classlist.add(rs.getString(1));
			}
			
			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return classlist;
	}
	
	
	public UploadFile getFile(String fileName) {
		Connection con;
		UploadFile file = null;
		try {
			System.out.println("Test file name:: " + fileName);
			con = ds.getConnection();
			String sql = "select fileName, id, date, projectName, className from uploadlist where fileName = ?";
			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, fileName);

			ResultSet rs = pstat.executeQuery();

			file = new UploadFile(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
			System.out.println("Test :: " + file.getFileName());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return file;
	}
	
	public String getcontent(String p_name){
		Connection con;
		String content="";
		try {
			con = ds.getConnection();
			String sql = "select project_content from project_detail where project_name=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			System.out.println("project name =   "+p_name);
			pstat.setString(1, p_name);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				content = rs.getString(1); 
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("ddddddddddddd          :   "+content);
		return content;
	}
	
	public ArrayList<String> getSumClass(String p_name){
		Connection con;
		ArrayList<String> classlist = new ArrayList<String>();
		try {
			con = ds.getConnection();
			String sql = "select class_name from class_detail where project_id in (select project_id from project_detail where project_name = ?)";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, p_name);

			System.out.println("test getsum = "+p_name);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				classlist.add(rs.getString(1)); 
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return classlist;
	}
	public ArrayList<String> getUploadList(String p_name){
		Connection con;
		ArrayList<String> classUploadList = new ArrayList<String>();
		System.out.println("test getuploadlist = "+p_name);
		try {
			con = ds.getConnection();
			String sql = "select distinct className from uploadlist where projectName = ?";
			PreparedStatement pstat = con.prepareStatement(sql);
			//System.out.println("project name =   "+p_name);
			pstat.setString(1, p_name);

			ResultSet rs = pstat.executeQuery();
			
			while(rs.next()){
				classUploadList.add(rs.getString(1)); 
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return classUploadList;
	}
	
	public void updateProgress(int state, String p_name){
		
		Connection con;
		
		try {
			con = ds.getConnection();
			String sql = "update project_detail set project_progress = ? where project_name = ?";
			PreparedStatement pstat = con.prepareStatement(sql);
			//System.out.println("project name =   "+p_name);
			
			pstat.setInt(1, state);
			pstat.setString(2, p_name);
			
			pstat.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}

	}
}
