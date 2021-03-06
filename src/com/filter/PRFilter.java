package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ajax.PRAjax;
import com.controller.PRController_createClassMethod;
import com.controller.PRController_createProject;
import com.controller.PRController_createProject2;
import com.controller.PRController_createProject3;
import com.controller.PRController_main;
import com.controller.PRController_member;
import com.controller.PRController_memberUpdate;
import com.controller.PRController_setting;
import com.controller.PRController_showProject;
import com.controller.PRController_showUploadList;



public class PRFilter implements Filter {
	
	PRController_createClassMethod controller_create_class_method;
	PRController_member controller_member;
	PRController_main controller_main;
	PRController_createProject controller_project_process;
	PRController_createProject2 controller_project_process2;
	PRController_createProject3 controller_project_process3;
	PRController_showProject controller_show_project;
	PRController_setting controller_setting;
	PRController_showProject controller_test;
	PRController_memberUpdate controller_member_update;
	PRController_showUploadList controller_show_upload;

	PRAjax prAjax;
	
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		//controller_member = new PRController_member();
		controller_main = new PRController_main();
		controller_member = new PRController_member();
		controller_project_process = new PRController_createProject();
		controller_project_process2 = new PRController_createProject2();
		controller_project_process3 = new PRController_createProject3();
		controller_create_class_method = new PRController_createClassMethod();
		controller_show_project = new PRController_showProject();
		controller_setting = new PRController_setting();
		controller_test = new PRController_showProject();
		controller_member_update = new PRController_memberUpdate();
		controller_show_upload = new PRController_showUploadList();
		prAjax = new PRAjax();
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		req.setCharacterEncoding("EUC-KR");

		String reqString = req.getServletPath();
		
		if(reqString.equals("/main.do")){
			controller_main.mainAll(req, res);
		}else if (reqString.equals("/login.do")){
			controller_member.login(req, res);
		}else if (reqString.equals("/join.do")){
			controller_member.join(req, res);
		}else if (reqString.equals("/joinprocess.do")){
			controller_member.joinprocess(req, res);
		}else if (reqString.equals("/createproject_process.do")){
			controller_project_process.createProcess(req, res);
		}else if (reqString.equals("/createproject.do")){
			controller_project_process.createProject(req, res);
		}else if (reqString.equals("/showproject.do")){
			controller_show_project.showproject(req, res);
		}else if(reqString.equals("/test.do")) {
			controller_test.showproject(req, res);
		}else if(reqString.equals("/showUploadList.do")) {
			controller_show_upload.showUploadList(req, res);
		}else if(reqString.equals("/showUploadSecondList.do")) {
			controller_show_upload.showUploadSecondList(req, res);
		}else if (reqString.equals("/ajaxIssue.do")){
	         prAjax.getIssueData(req,res);//main.jsp.
	    }else if (reqString.equals("/ajaxIssuehome.do")){
	         prAjax.getIssueDatahome(req,res);//home.jsp
	    }else if (reqString.equals("/createproject2.do")){
			controller_project_process2.createProject2(req, res);
		}else if (reqString.equals("/setting.do")){
			controller_setting.goSetting(req, res);
		}else if (reqString.equals("/memberUpdate.do")){
			controller_member_update.joinprocess(req, res);
		}else if (reqString.equals("/ajax_project_detail_Issue.do")){
			prAjax.getIssueProject(req, res);
		}else if (reqString.equals("/usermain.do")){
			controller_member.mainlogin(req, res);
		}else if(reqString.equals("/logout.do")){
			controller_main.logout(req, res);
		}else if (reqString.equals("/createproject3.do")){
			controller_project_process3.createProject3(req, res);
		}else if (reqString.equals("/createClassMethod.do")){
	         controller_create_class_method.createClassMethod(req, res);
	    }else if (reqString.equals("/projectList.do")){
	    	controller_main.projectList(req, res);
	    }
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}
}
