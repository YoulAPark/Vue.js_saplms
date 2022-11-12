package kr.happyjob.study.stdsmt.model;

public class StdsmtCommentModel {
	
	private int bd_no;
	private int cm_no;
	private String cm_date;
	private String cm_contents;
	private String name;
	
	public int getBd_no() {
		return bd_no;
	}
	public void setBd_no(int bd_no) {
		this.bd_no = bd_no;
	}
	public int getCm_no() {
		return cm_no;
	}
	public void setCm_no(int cm_no) {
		this.cm_no = cm_no;
	}
	public String getCm_date() {
		return cm_date;
	}
	public void setCm_date(String cm_date) {
		this.cm_date = cm_date;
	}
	public String getCm_contents() {
		return cm_contents;
	}
	public void setCm_contents(String cm_contents) {
		this.cm_contents = cm_contents;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "StdsmtCommentModel [bd_no=" + bd_no + ", cm_no=" + cm_no + ", cm_date=" + cm_date + ", cm_contents="
				+ cm_contents + ", name=" + name + "]";
	}
}
