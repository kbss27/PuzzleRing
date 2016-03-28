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

	public ArrayList<UploadFile> getFileList() {
		Connection con;
		ArrayList<UploadFile> files = new ArrayList<UploadFile>();
		UploadFile file;
		try {
			con = ds.getConnection();

			String sql = "select id, fileName, date, projectName, className from uploadlist order by date desc";
			PreparedStatement pstat = con.prepareStatement(sql);
			
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
}
