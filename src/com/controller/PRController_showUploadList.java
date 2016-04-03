package com.controller;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRShowUploadList;
import com.vo.UploadFile;


public class PRController_showUploadList {
	PRShowUploadList file;
	
	public PRController_showUploadList() {
		file = new PRShowUploadList();
	}
	
	public void showUploadList(HttpServletRequest req, HttpServletResponse res) {
		ArrayList<UploadFile> files;
		files = file.getFileList();

		System.out.println("-- file list --");
		for(int i = 0; i < files.size(); i++) {
			System.out.println(files.get(i).getFileName());
			System.out.println(files.get(i).getProjectName());
			System.out.println(files.get(i).getClassName());
			System.out.println(files.get(i).getDate());
			System.out.println(files.get(i).getId());
			System.out.println("----------------------");
		}
		req.setAttribute("lists", files);
		RequestDispatcher dis = req.getRequestDispatcher("/form/project_detail.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
