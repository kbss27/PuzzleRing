package com.controller;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRBoard;
import com.vo.Board_Info;

import java.util.ArrayList;

public class PRController_board {

	PRBoard model;
	//constructor.
	public PRController_board() {
		model = new PRBoard();

	}

	/*
	 * goboard method to go to board of homepage.
	 */
	public void goboard(HttpServletRequest req, HttpServletResponse res){
		
		ArrayList<Board_Info> listinfo = new ArrayList<Board_Info>();
		listinfo = model.getlistInfo();
		
		for(int i = 0; i < listinfo.size(); i++){
			model.updateindex(listinfo.get(i).getIndex(), listinfo.get(i).getTitle());
		}
				
		req.setAttribute("listinfo", listinfo);
		
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/community.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * gowrite method to write something in the board.
	 */
	public void gowrite(HttpServletRequest req, HttpServletResponse res){
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/write.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
	} 
	/*
	 * writeok method to write board information if it is not fault such as duplication.
	 */
	public void writeok(HttpServletRequest req, HttpServletResponse res){
	
		String id = req.getSession().getAttribute("login").toString();
		String title = req.getParameter("title");
		String username = req.getParameter("name");
		String password = req.getParameter("password");
		String memo = req.getParameter("memo");
		
		System.out.println("info"+id+":"+title+":"+username+":"+password+":"+memo);
		
		model.setboard(id, title, username, password, memo);
	
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/writeandboard.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * goview method to show main view of board.
	 */
	public void goview(HttpServletRequest req, HttpServletResponse res){
		//�꽆�뼱媛�湲곗쟾�뿉 �젙蹂대떎媛��졇���꽌�꽆湲곗옄.
		String index = req.getParameter("idx");
		ArrayList<Board_Info> listinfo = new ArrayList<Board_Info>();
		listinfo = model.getviewinfo(index);
		
		req.setAttribute("listinfo", listinfo);
		
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/view_Form.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * godelete method to delete board information from database.
	 */
	public void godelete(HttpServletRequest req, HttpServletResponse res){
		String tm = req.getParameter("idx");
		//model.del(tm);	//�뜲�씠�꽣踰좎씠�뒪�뿉�꽌 吏��썱�쑝�땲 num�떎�떆 �뾽�뜲�씠�듃�빐�빞�빀�땲�떎.
		//model.updateInfo(t_id, u_id, seats);
		req.setAttribute("index", tm);
		
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/delete_Form.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * deleteind method to act as deleting information on board. you can check if deleting success.
	 */
	public void deleteind(HttpServletRequest req, HttpServletResponse res){
		//this deleteind is to act as deleting information on board.
		String idx = req.getParameter("index");
		String pass = req.getParameter("password");
		
		if(model.del(idx, pass)){
			req.setAttribute("success", "success");
		}else{
			req.setAttribute("success", "fail");
		}
		
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/writeandboard.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * setmodify method to modify the board information.
	 */
	public void setmodify(HttpServletRequest req, HttpServletResponse res){
		//this setmodify is to set going to modify form.
		String index = req.getParameter("idx");
		ArrayList<Board_Info> tn = new ArrayList<Board_Info>();
		tn = model.modify(index);
		
		req.setAttribute("modify", tn);
		
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/modify_Form.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * realmodify method to modify board if password is right.
	 */
	public void realmodify(HttpServletRequest req, HttpServletResponse res){

		//this realmodify is to modify board.
		String title = req.getParameter("title");
		String name = req.getParameter("name");
		String pass = req.getParameter("password");
		String memo = req.getParameter("memo");
		
		System.out.println(model.realmodify(title, name, pass, memo));
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/writeandboard.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * contactus method to go to contact_Form to show developers on this project.
	 */
	public void contactus(HttpServletRequest req, HttpServletResponse res){
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/contact_Form.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
