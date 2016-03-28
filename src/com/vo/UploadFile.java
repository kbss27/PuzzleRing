/*upload source code*/
package com.vo;

public class UploadFile {
	private String id;
	private String fileName;
	private String date;
	private String projectName;
	private String className;
	
	public UploadFile() {}
	public UploadFile(String fileName, String id, String date, String projectName, String className) {
		this.id = id;
		this.fileName = fileName;
		this.date = date;
		this.projectName = projectName;
		this.className = className;
	}
	
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
