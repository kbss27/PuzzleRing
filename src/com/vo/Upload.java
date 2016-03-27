/*upload source code*/
package com.vo;

public class Upload {
	private String id;
	private String fileName;
	private String date;
	
	
	public Upload(String id, String fileName, String date) {
		this.id = id;
		this.fileName = fileName;
		this.date = date;
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
