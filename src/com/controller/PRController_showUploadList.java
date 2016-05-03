package com.controller;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRCheckProjectState;
import com.dao.PRCreateClassMethod;
import com.dao.PRShowUploadList;
import com.vo.Project_detail;
import com.vo.Project_overview;
import com.vo.UploadFile;


public class PRController_showUploadList {
	PRShowUploadList file;
	PRCreateClassMethod model;
	public PRController_showUploadList() {
		file = new PRShowUploadList();
		model = new PRCreateClassMethod();
	}
	
	public void showUploadList(HttpServletRequest req, HttpServletResponse res) {
		ArrayList<UploadFile> files;
		ArrayList<String> classlist;		
		
		String url;
		//String p_name = (String)req.getSession().getAttribute("project_name");
		String p_name = req.getParameter("project_name");
		
		
		
		
		PRCheckProjectState state = new PRCheckProjectState();
		System.out.println("-- file list --");
		
		if(state.checkProjectState(p_name)==0)
		{
			Project_overview overview = model.createClassMethod(p_name);
			req.setAttribute("project_overview", overview);
			url = "/form/project_detailNoClass.jsp";
		}
		else
		{
			classlist = file.getClassList(p_name);
			files = file.getFileList(p_name);
			for(int i = 0; i < files.size(); i++) {
				System.out.println(files.get(i).getFileName());
				System.out.println(files.get(i).getProjectName());
				System.out.println(files.get(i).getClassName());
				System.out.println(files.get(i).getDate());
				System.out.println(files.get(i).getId());
				System.out.println("----------------------");
			}
			
			
			req.setAttribute("lists", files);
			req.setAttribute("classlist", classlist);
			req.setAttribute("content", file.getcontent(p_name));
			
			url="/form/project_detail.jsp?project_name="+p_name;
		}
		
		
		
		RequestDispatcher dis = req.getRequestDispatcher(url);
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	
	
	public void showClasses(HttpServletRequest req, HttpServletResponse res) {
		
	}
}
