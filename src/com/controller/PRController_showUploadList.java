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
	
	public void showUploadSecondList(HttpServletRequest req, HttpServletResponse res) {
		ArrayList<UploadFile> files;
		ArrayList<String> classlist;		
		ArrayList<String> class_list_progress;
		ArrayList<String> uploadlist_progress;
		
		String url;
		//String p_name = (String)req.getSession().getAttribute("project_name");
		String p_name = req.getParameter("project_name");
		
		
		
		
		PRCheckProjectState state = new PRCheckProjectState();
		System.out.println("-- file list --" + "  "+p_name);
		
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
		
		//여기로 들어왔다는 의미는 업로드를 하긴 했다는 의미니까. project_progress 체크하는 부분 실행하자.
		//우선 class_detail에서의 개수를 찾자.
		
		class_list_progress = file.getSumClass(p_name);
		
		//이번에는 uploadlist에서 class들 찾아넣자.
		
		uploadlist_progress = file.getUploadList(p_name);
		int stateOfprogress = 0;
		
		System.out.println("class list = "+ class_list_progress.size() + "   uploadlist size =  " + uploadlist_progress.size());
		
		if((uploadlist_progress.size() < class_list_progress.size()) && uploadlist_progress.size() > 0){
			//기존 class_detail의 class개수보다 작고 0보다는 크다면 50
			stateOfprogress = 50; // In progress;
		}else if(uploadlist_progress.size() >= class_list_progress.size()){
			stateOfprogress = 100; // Done;
		}
		
		//이제 update시키자.
		file.updateProgress(stateOfprogress, p_name);
		
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
