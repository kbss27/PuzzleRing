package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Member;


public class PRMember {

	DataSource ds;

	/**
	 * Create db pool
	 */
	public PRMember() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public boolean m_login(String id, String pass) {
		boolean isLogin = false;
		try { 
			Connection con = ds.getConnection();
			String sql = "select * from member where id=? and password=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, id);
			pstat.setString(2, pass);

			ResultSet rs = pstat.executeQuery();
			if (rs.next()) {
				isLogin = true;

			} else {
				isLogin = false;
			}

			rs.close();
			pstat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isLogin;
	}
	
	public boolean m_join(Member m) {
		boolean isJoin = false;
		Connection con;
		try {
			con = ds.getConnection();

			String sql = "insert into member(id, password, email, info, project_total, project_success, project_failed) values(?,?,?,?,?,?,?)";
			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, m.getM_id());
			pstat.setString(2, m.getM_password());
			pstat.setString(3, m.getM_email());
			pstat.setString(4, m.get_info());
			pstat.setInt(5, 0);
			pstat.setInt(6, 0);
			pstat.setInt(7, 0);

			//System.out.println(sql);

			pstat.executeUpdate();
			isJoin = true;

			pstat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isJoin;
	}
	
}
