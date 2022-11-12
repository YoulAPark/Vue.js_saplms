package kr.happyjob.study.pfssmt.model;

import java.sql.Date;

public class PfsSmtSurveyRstVo {
	
	private int li_no; //강의번호
	private String li_nm; //강의명
	private String tname; //교수명
	private String loginID; //학생번호 (학생loginID)
	private String name; //학생명
	private String ci_nm; //강의실명
	private int sv_cj; //설문총점
	
	private String li_date; //강의시작일
	private String li_redate; //강의종료일
	
	private String sv_date; //설문등록일
	
	
	
	
	public String getLi_date() {
		return li_date;
	}
	public void setLi_date(String li_date) {
		this.li_date = li_date;
	}
	public String getLi_redate() {
		return li_redate;
	}
	public void setLi_redate(String li_redate) {
		this.li_redate = li_redate;
	}
	public String getSv_date() {
		return sv_date;
	}
	public void setSv_date(String sv_date) {
		this.sv_date = sv_date;
	}
	public int getLi_no() {
		return li_no;
	}
	public void setLi_no(int li_no) {
		this.li_no = li_no;
	}
	public String getLi_nm() {
		return li_nm;
	}
	public void setLi_nm(String li_nm) {
		this.li_nm = li_nm;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCi_nm() {
		return ci_nm;
	}
	public void setCi_nm(String ci_nm) {
		this.ci_nm = ci_nm;
	}
	public int getSv_cj() {
		return sv_cj;
	}
	public void setSv_cj(int sv_cj) {
		this.sv_cj = sv_cj;
	}
	

	
	

}
