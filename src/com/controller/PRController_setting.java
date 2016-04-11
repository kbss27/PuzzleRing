package com.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRSetting;
import com.vo.Member;

public class PRController_setting {
	PRSetting model;
	public PRController_setting()
	{
		model = new PRSetting();
		
	}
	public void goSetting(HttpServletRequest req, HttpServletResponse res){
		
		String ID = req.getParameter("user_id");
		
		req.setAttribute("member", model.getUserInfo(ID));
		RequestDispatcher dis = req.getRequestDispatcher("/form/setting_form.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
