package com.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRMember;
import com.vo.Member;


public class PRController_member {

	PRMember model;

	public PRController_member() {
		model = new PRMember();
	}
/*
	public void login(HttpServletRequest req, HttpServletResponse res) {
		RequestDispatcher dis = req.getRequestDispatcher("form/login.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
*/
	public void login(HttpServletRequest req, HttpServletResponse res) {
		try {
			//req, res통해서 통신한다.
			//?id=kbss27&pass=1234
			//request객체는 url.
			//ttt
			String id = req.getParameter("id");
			String pass = req.getParameter("password");
			// String pass = controller.getEncSHA256(hash_pass);

			boolean isLogin = model.m_login(id, pass);
			
			if (isLogin == true) {

				req.setAttribute("id", id);
				
				RequestDispatcher dis = req
						.getRequestDispatcher("/form/main.jsp");

				dis.forward(req, res);

			} else {
				System.out.println("false");
				//	req.getRequestDispatcher("/form/loginFail.jsp").forward(req, res);;
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	public void join(HttpServletRequest req, HttpServletResponse res) {
		RequestDispatcher dis = req.getRequestDispatcher("form/join.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void joinprocess(HttpServletRequest req, HttpServletResponse res) {
		
		
		Member new_member = new Member(req.getParameter("id"), req.getParameter("password"), req.getParameter("e_mail"),
				req.getParameter("information"));
		
		if(model.m_join(new_member)){
			RequestDispatcher dis = req.getRequestDispatcher("form/home.jsp");
			try {
				dis.forward(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			System.out.println("join 실패");
		}
		
	}

}
