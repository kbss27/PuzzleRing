package com.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


public class PRAjax{
	DataSource ds;

	public PRAjax() {
		System.out.println("fef");
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}

	public void getIssueData(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// TODO Auto-generated method stub

		try{
			Connection con = ds.getConnection();

			//First, find info from my id
			String sql = "select project_name, project_progress from project_detail where project_id in (select project_id from project_member_detail where project_member_name = ?) or project_creator= ?";

			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, req.getSession().getAttribute("login").toString());
			pstat.setString(2, req.getSession().getAttribute("login").toString());

			ResultSet rs = pstat.executeQuery();

			JSONArray  arr = new JSONArray();

			while(rs.next()){

				JSONObject obj;

				obj = new JSONObject();

				obj.put("projectName", rs.getString(1));
				obj.put("projectProgress", rs.getInt(2));

				arr.add(obj);
			}

			res.setContentType("application/json");

			PrintWriter out = res.getWriter();

			out.write(arr.toJSONString());

			rs.close();
			pstat.close();
			con.close();
		}catch(SQLException e){
			e.printStackTrace();
		}

	}
	public void getIssueDatahome(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// TODO Auto-generated method stub

		try{
			Connection con = ds.getConnection();

			String sql = "select project_name, project_progress from project_detail";

			PreparedStatement pstat = con.prepareStatement(sql);
			
			ResultSet rs = pstat.executeQuery();

			JSONArray  arr = new JSONArray();

			while(rs.next()){

				JSONObject obj;

				obj = new JSONObject();

				obj.put("projectName", rs.getString(1));
				obj.put("projectProgress", rs.getInt(2));

				arr.add(obj);
			}

			res.setContentType("application/json");

			PrintWriter out = res.getWriter();

			out.write(arr.toJSONString());

			rs.close();
			pstat.close();
			con.close();
		}catch(SQLException e){
			e.printStackTrace();
		}

	}
	
	public void getIssueProject(HttpServletRequest req, HttpServletResponse res) throws IOException {
		// TODO Auto-generated method stub

		try{
			Connection con = ds.getConnection();

			String sql = "select className, id, date from uploadlist where projectName = ? order by date desc";

			PreparedStatement pstat = con.prepareStatement(sql);
			String p_name=(String)req.getParameter("project_name");
			//System.out.println(p_name);
			
			pstat.setString(1, p_name);
			
			ResultSet rs = pstat.executeQuery();

			JSONArray  arr = new JSONArray();

			while(rs.next()){

				JSONObject obj;

				obj = new JSONObject();

				obj.put("className", rs.getString(1));
				obj.put("id", rs.getString(2));
				obj.put("date", rs.getString(3));

				arr.add(obj);
			}

			res.setContentType("application/json");

			PrintWriter out = res.getWriter();

			out.write(arr.toJSONString());

			rs.close();
			pstat.close();
			con.close();
		}catch(SQLException e){
			e.printStackTrace();
		}

	}
}