package kr.happyjob.study.stdsmt.model;

public class StdsmtQnaModel {
	
	private int bd_no;
	private String bd_title;
	private String bd_contents;
	private String bd_date;
	private String name;
	
	public int getBd_no() {
		return bd_no;
	}
	public void setBd_no(int bd_no) {
		this.bd_no = bd_no;
	}
	public String getBd_title() {
		return bd_title;
	}
	public void setBd_title(String bd_title) {
		this.bd_title = bd_title;
	}
	public String getBd_contents() {
		return bd_contents;
	}
	public void setBd_contents(String bd_contents) {
		this.bd_contents = bd_contents;
	}
	public String getBd_date() {
		return bd_date;
	}
	public void setBd_date(String bd_date) {
		this.bd_date = bd_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "StdsmtQnaModel [bd_no=" + bd_no + ", bd_title=" + bd_title + ", bd_contents=" + bd_contents
				+ ", bd_date=" + bd_date + ", name=" + name + "]";
	}
}
