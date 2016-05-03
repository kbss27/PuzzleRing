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
			// get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean createProject(String project_creator, String project_name, String project_type,
			String project_content) {
		int p_id = 0, count = 1;
		int pro_id = 0;
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

		try {
			Connection con = ds.getConnection();
			String sql = "insert into project_detail(project_name, project_type, project_content, project_creator, project_members, project_methods, project_progress) values(?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, project_name);
			pstat.setString(2, project_type);
			pstat.setString(3, project_content);
			pstat.setString(4, project_creator);
			pstat.setInt(5, 0);
			pstat.setInt(6, 0);
			pstat.setInt(7, 0);

			pstat.executeUpdate();

			pstat.close();
			con.close();
			// 占쎈릭筌롫똻苑� today's new project占쏙옙 my porject new�몴占� 占쎈씜占쎈쑓占쎌뵠占쎈뱜.
		} catch (SQLException e) {
			e.printStackTrace();
		} // Project ID 癒쇱� �뼸�뼱�빞 �븳�떎.

		try {
			Connection con = ds.getConnection();
			String sql = "select project_id from project_detail order by project_id desc";

			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery();

			if (rs.next()) {
				pro_id = rs.getInt(1);
			}

			rs.close();
			pstat.close();
			con.close();
			// 占쎈릭筌롫똻苑� today's new project占쏙옙 my porject new�몴占� 占쎈씜占쎈쑓占쎌뵠占쎈뱜.
		} catch (SQLException e) {
			e.printStackTrace();
		}
		/*
		 * insert �븯湲� �쟾�뿉 �삤�뒛 �궇吏쒓� �븘�땶 寃껊뱾 吏��슦�뒗 寃껋씠 �븘�슂.
		 */
		Date curDate = new Date();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		sdf.format(curDate);
		System.out.println(sdf.format(curDate));

		try {
			Connection con = ds.getConnection();
			String sql = "delete from todayNewProject where Date != ?";

			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, sdf.format(curDate));

			pstat.executeUpdate();

			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			Connection con = ds.getConnection();
			String sql = "insert into todayNewProject(project_id, project_name, project_content, project_type, Date) values(?, ?, ?, ?, SYSDATE())";

			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setInt(1, pro_id);
			pstat.setString(2, project_name);
			pstat.setString(3, project_content);	//project_content
			pstat.setString(4, project_type);	//project_type

			pstat.executeUpdate();

			pstat.close();
			con.close();
			return true;
			// 占쎈릭筌롫똻苑� today's new project占쏙옙 my porject new�몴占� 占쎈씜占쎈쑓占쎌뵠占쎈뱜.
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public int getTotal(String project_creator) {
		int count = 0;

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
