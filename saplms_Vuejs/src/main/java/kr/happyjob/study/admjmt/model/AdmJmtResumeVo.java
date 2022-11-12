package kr.happyjob.study.admjmt.model;

public class AdmJmtResumeVo {
	
	private int li_no; //과정번호
	private String li_nm; //과정명
	private String li_date; //강의시작일자
	private String li_redate; //강의종료일자
	private String li_ap; //신청인원

	private int ss_score; //맞춘점수
	private String name; //성명
	private String userID; // 선택된이력서ID
	
 
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
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
	public String getLi_ap() {
		return li_ap;
	}
	public void setLi_ap(String li_ap) {
		this.li_ap = li_ap;
	}
	public int getSs_score() {
		return ss_score;
	}
	public void setSs_score(int ss_score) {
		this.ss_score = ss_score;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
