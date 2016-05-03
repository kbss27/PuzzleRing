package com.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.vo.Board_Info;

public class PRBoard  {
	DataSource ds;

	/**
	 * Create db pool
	 */
	public PRBoard() {
		try {
			InitialContext context = new InitialContext();
			//get data source by path.
			ds = (DataSource) context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	/*
	 * setboard method to set information on board and database.
	 */
	public void setboard(String id, String title, String u_name, String password, String content){
		try{
		Connection con = ds.getConnection();
		String sql = "insert into Board_info(writer, title, content, time, hit, password, board_num) values(?, ?, ?, SYSDATE(), ?, ?, ?)";
		
		PreparedStatement pstat = con.prepareStatement(sql);
		
		pstat.setString(1, id);
		pstat.setString(2, title);
		pstat.setString(3, content);
		pstat.setInt(4, 0);
		pstat.setString(5, password);
		pstat.setInt(6, 0);
		
		pstat.executeUpdate();

		pstat.close();
		con.close();
		
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	public void updateindex(String index, String title){

		try{
			//踰덊샇 �젣紐� �옉�꽦�옄 �옉�꽦�씪 議고쉶�닔.
			Connection con = ds.getConnection();
			String sql = "update Board_info set board_num = ? where title = ?";

			PreparedStatement pstat = con.prepareStatement(sql);
			pstat.setString(1, index);
			pstat.setString(2, title);

			pstat.executeUpdate();

			pstat.close();

			con.close();

		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	/*
	 * getlistInfo method to get information of board from database.
	 */
	public ArrayList<Board_Info> getlistInfo(){
		
		ArrayList<Board_Info> tmp = new ArrayList<Board_Info>();
		
		int tmpindex=0;
		
		try{
		//踰덊샇 �젣紐� �옉�꽦�옄 �옉�꽦�씪 議고쉶�닔.
		Connection con = ds.getConnection();
		String sql = "select title, writer, time, hit from Board_info";
		
		PreparedStatement pstat = con.prepareStatement(sql);
		
		ResultSet rs = pstat.executeQuery();
	
		while(rs.next()){
			System.out.println(tmpindex);
			Board_Info b_info = new Board_Info();
			
			b_info.setIndex(Integer.toString(tmpindex++));
			b_info.setTitle(rs.getString(1));
			b_info.setName(rs.getString(2));
			b_info.setTime(rs.getString(3));
			b_info.setHit(rs.getString(4));
			
			tmp.add(b_info);
		}
		
		rs.close();
		pstat.close();
		con.close();
		
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return tmp;
	}
	/*
	 * getviewinfo method to get 
	 */
	public ArrayList<Board_Info> getviewinfo(String idx){
		
		ArrayList<Board_Info> tmp = new ArrayList<Board_Info>();

		String hittime="";
		try{
			Connection con = ds.getConnection();
			String sql = "select board_num, hit, writer, time, title, content from Board_info where board_num=?";
			PreparedStatement pstat = con.prepareStatement(sql);
			
			pstat.setString(1, idx);
			
			ResultSet rs = pstat.executeQuery();
		
			while(rs.next()){
				
				Board_Info b_info = new Board_Info();	
				b_info.setIndex(rs.getString(1));
				b_info.setHit(rs.getString(2));
				hittime=rs.getString(2);
				b_info.setName(rs.getString(3));
				b_info.setTime(rs.getString(4));
				b_info.setTitle(rs.getString(5));
				b_info.setMemo(rs.getString(6));
				
				tmp.add(b_info);
			}
			
			rs.close();
			pstat.close();
			con.close();
			
			}catch(SQLException e){
				e.printStackTrace();
			}
		
		try{
			//踰덊샇 �젣紐� �옉�꽦�옄 �옉�꽦�씪 議고쉶�닔.
			Connection con = ds.getConnection();
			String sql = "update Board_info set hit = ? where board_num = ?";

			PreparedStatement pstat = con.prepareStatement(sql);
			
			pstat.setString(1, Integer.toString((Integer.parseInt(hittime)+1)));
			pstat.setString(2, idx);

			pstat.executeUpdate();

			pstat.close();

			con.close();

		}catch(SQLException e){
			e.printStackTrace();
		}
		return tmp;
	}
	/*
	 * del method to return password is correct. if password is correct, delete from database.
	 */
	public boolean del(String tm, String pass){
		try{
	
			Connection con = ds.getConnection();
			String sql = "select * from Board_info where board_num=? and password=?";
	
		
			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, tm);
			pstat.setString(2, pass);
			
			ResultSet rs = pstat.executeQuery();
			
			if(rs.next()){
				rs.close();
				pstat.close();
				String sql2 = "delete from Board_info where board_num=?";
				PreparedStatement pstat2 = con.prepareStatement(sql2);
				pstat2.setString(1, tm);
				
				pstat2.executeUpdate();
				pstat2.close();
				con.close();
				return true;
			}else{
				
				rs.close();
				pstat.close();
				con.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
	/*
	 * modify method to modify the Board_info in database if it is correct.
	 */
	public ArrayList<Board_Info> modify(String index){
		
		ArrayList<Board_Info> tmp = new ArrayList<Board_Info>();
		
		try{
			
			Connection con = ds.getConnection();
			String sql = "select title, writer, password, content from Board_info where board_num=?";
	
			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, index);
			
			ResultSet rs = pstat.executeQuery();
			while(rs.next()){
				Board_Info b_info = new Board_Info();
				b_info.setTitle(rs.getString(1));
				b_info.setName(rs.getString(2));
				b_info.setpass(rs.getString(3));
				b_info.setMemo(rs.getString(4));
				tmp.add(b_info);
			}
			rs.close();
			pstat.close();
			con.close();
		}catch(SQLException e){
			
			e.printStackTrace();
		}
		
		return tmp;
	}
	/*
	 * remodify method to update Board_info in database.
	 */
	public boolean realmodify(String title, String name, String pass, String content){
		System.out.println("check1");
		try{
		
			Connection con = ds.getConnection();
			String sql = "select * from Board_info where writer=? and password=?";
		
			PreparedStatement pstat = con.prepareStatement(sql);

			pstat.setString(1, name);
			pstat.setString(2, pass);
			System.out.println("check2");
			ResultSet rs = pstat.executeQuery();
			
			if(rs.next()){
				rs.close();
				pstat.close();
				String sql2 = "update Board_info set title = ?, content = ? where writer = ?";
				PreparedStatement pstat2 = con.prepareStatement(sql2);
				pstat2.setString(1, title);
				pstat2.setString(2, content);
				pstat2.setString(3, name);
				
				pstat2.executeUpdate();
				pstat2.close();
				con.close();
				return true;
			}else{
				
				rs.close();
				pstat.close();
				con.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
}
