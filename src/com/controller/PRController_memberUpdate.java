package com.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRMember;
import com.dao.PRUpdateMember;
import com.vo.Member;

public class PRController_memberUpdate {

PRUpdateMember model;
PRMember model2;
public PRController_memberUpdate()
{
	model = new PRUpdateMember();
	model2 = new PRMember();
}
public void joinprocess(HttpServletRequest req, HttpServletResponse res) {
		
	String id = req.getParameter("id");
	String password = req.getParameter("password");
	String email = req.getParameter("email");
	String info = req.getParameter("info");
	
		System.out.println(id + password + email + info);
		model.updateMember(id,password,email,info);
		

		if(model2.m_login(id,password)){
			req.setAttribute("id", id);
			RequestDispatcher dis = req.getRequestDispatcher("form/main.jsp");
			try {
				dis.forward(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			System.out.println("수정실패");
		}
		
	}
}
