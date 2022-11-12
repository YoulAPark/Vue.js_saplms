package kr.happyjob.study.admpmt.model;

public class AdmpmtClassroomMgtModel {
	
	private int li_no;		//강의실 코드
	private int ce_no;		//장비 코드
	private String ci_nm;	//강의실 이름
	private String ci_size;	//강의실 크기
	private int ci_number;	//좌석 수
	private String ci_note; //강의실 비고
	private int lec_cnt;	//강의실당 강의수
	
	private String ce_nm;	//장비명
	private int ce_ea;		//장비 개수
	private String ce_note;	//장비 비고


	public int getLi_no() {
		return li_no;
	}
	public void setLi_no(int li_no) {
		this.li_no = li_no;
	}
	public int getCe_no() {
		return ce_no;
	}
	public void setCe_no(int ce_no) {
		this.ce_no = ce_no;
	}
	public String getCi_nm() {
		return ci_nm;
	}
	public void setCi_nm(String ci_nm) {
		this.ci_nm = ci_nm;
	}
	public String getCi_size() {
		return ci_size;
	}
	public void setCi_size(String ci_size) {
		this.ci_size = ci_size;
	}
	public int getCi_number() {
		return ci_number;
	}
	public void setCi_number(int ci_number) {
		this.ci_number = ci_number;
	}
	public String getCi_note() {
		return ci_note;
	}
	public void setCi_note(String ci_note) {
		this.ci_note = ci_note;
	}
	public String getCe_nm() {
		return ce_nm;
	}
	public void setCe_nm(String ce_nm) {
		this.ce_nm = ce_nm;
	}
	public int getCe_ea() {
		return ce_ea;
	}
	public void setCe_ea(int ce_ea) {
		this.ce_ea = ce_ea;
	}
	public String getCe_note() {
		return ce_note;
	}
	public void setCe_note(String ce_note) {
		this.ce_note = ce_note;
	}
	public int getLec_cnt() {
		return lec_cnt;
	}
	public void setLec_cnt(int lec_cnt) {
		this.lec_cnt = lec_cnt;
	}
	
}
