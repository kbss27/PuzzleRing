package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Class_detail;
import com.vo.Method_detail;

public class PRCreateProject2 {
	DataSource ds;
	/**
	 * Create db pool
	 */
	
	ArrayList<Class_detail> cd = new ArrayList<Class_detail>();
	ArrayList<Method_detail> md = new ArrayList<Method_detail>();
	
	public PRCreateProject2() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public boolean createProject2(String class_detail, String method_detail){
		
		try {
			
			if(makeClassList(class_detail))
				System.out.println("Success insert class_detail in class");
			
			if(makeMethodList(method_detail))
				System.out.println("Success insert method_detail in class");
			Connection con = ds.getConnection();
			
			Statement stmt2 = con.createStatement();
			ResultSet rs = stmt2.executeQuery("select max(project_id) from project_detail");
			ResultSetMetaData rsmd = rs.getMetaData();
			int colnum = rsmd.getColumnCount();
			int projectId=0;
			while(rs.next()){
				for(int i=1;i<=colnum;i++)
				{
					projectId = rs.getInt(i);
				}
			}

			String sql = "insert into class_detail(class_am, class_name, project_id) values(?, ?, ?)";
			PreparedStatement pstat = con.prepareStatement(sql);
			
			for(int i=0;i<cd.size();i++)
			{
				pstat.setString(1, cd.get(i).getClass_am());
				pstat.setString(2, cd.get(i).getClass_name());
				
				pstat.setInt(3, projectId);
				pstat.executeUpdate();
			}
			pstat.close();
			sql = "insert into method_detail(class_info, method_am, method_type,method_modifier,method_name,class_id) values(?, ?, ?, ?, ?, ?)";
			pstat = con.prepareStatement(sql);
			for(int i=0;i<md.size();i++)
			{
				
				pstat.setString(1, md.get(i).getClass_name());
				pstat.setString(2, md.get(i).getMethod_am());
				pstat.setString(3, md.get(i).getMethod_type());
				pstat.setString(4, md.get(i).getMethod_modifier());
				pstat.setString(5, md.get(i).getMethod_name());
				pstat.setInt(6, 0);
				pstat.executeUpdate();
				
			}
			pstat.close();
			return true;
			//con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean makeClassList(String class_detail)
	{
		String token;
		StringTokenizer st = new StringTokenizer(class_detail," \n");
		while(st.hasMoreTokens())
		{
			Class_detail temp_class = new Class_detail();
			token = st.nextToken();
			temp_class.setClass_am(token);
			token = st.nextToken();
			temp_class.setClass_name(delete_last_char(token));
			cd.add(temp_class);
		}
		
		return true;
	}
	
	public boolean makeMethodList(String method_detail)
	{
		String token;
		StringTokenizer st = new StringTokenizer(method_detail," \n");
		while(st.hasMoreTokens())
		{
			Method_detail temp_method = new Method_detail();
			token = st.nextToken();
			temp_method.setMethod_am(token);
			token = st.nextToken();
			temp_method.setMethod_type(token);
			token = st.nextToken();
			temp_method.setMethod_modifier(token);
			token = st.nextToken();
			temp_method.setMethod_name(token);
			token = st.nextToken();
			temp_method.setClass_name(delete_last_char(token));
			md.add(temp_method);
		}
		
		return true;
	}
	
	
	public String delete_last_char(String s) {

	    String phrase = s;

	    String rephrase = null;
	    if (phrase != null && phrase.length() > 1) {
	        rephrase = phrase.substring(0, phrase.length() - 1);
	    }

	    return rephrase;
	}
	
	
}
