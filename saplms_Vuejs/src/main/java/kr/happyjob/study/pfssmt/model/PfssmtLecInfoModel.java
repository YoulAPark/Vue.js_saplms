package kr.happyjob.study.pfssmt.model;

import lombok.Data;

@Data
public class PfssmtLecInfoModel {

	private int li_no;
	private String li_nm;
	private String li_teachernm;
	private String li_date;
	private String li_redate;
	private int li_garden;
	private int li_ap;
	private String li_target;
	private String li_plan;
	private String li_contents;
	private String li_ad;
	private int li_type;
	private int li_no2;
	private int test_cd;
	private int att_no;
	private String name;
	private String detail_name;
	private String loginID;
	private int numOfStd;			//수강인원수
	
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
	public String getLi_teachernm() {
		return li_teachernm;
	}
	public void setLi_teachernm(String li_teachernm) {
		this.li_teachernm = li_teachernm;
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
	public int getLi_garden() {
		return li_garden;
	}
	public void setLi_garden(int li_garden) {
		this.li_garden = li_garden;
	}
	public int getLi_ap() {
		return li_ap;
	}
	public void setLi_ap(int li_ap) {
		this.li_ap = li_ap;
	}
	public String getLi_target() {
		return li_target;
	}
	public void setLi_target(String li_target) {
		this.li_target = li_target;
	}
	public String getLi_plan() {
		return li_plan;
	}
	public void setLi_plan(String li_plan) {
		this.li_plan = li_plan;
	}
	public String getLi_contents() {
		return li_contents;
	}
	public void setLi_contents(String li_contents) {
		this.li_contents = li_contents;
	}
	public String getLi_ad() {
		return li_ad;
	}
	public void setLi_ad(String li_ad) {
		this.li_ad = li_ad;
	}
	public int getLi_type() {
		return li_type;
	}
	public void setLi_type(int li_type) {
		this.li_type = li_type;
	}
	public int getLi_no2() {
		return li_no2;
	}
	public void setLi_no2(int li_no2) {
		this.li_no2 = li_no2;
	}
	public int getTest_cd() {
		return test_cd;
	}
	public void setTest_cd(int test_cd) {
		this.test_cd = test_cd;
	}
	public int getAtt_no() {
		return att_no;
	}
	public void setAtt_no(int att_no) {
		this.att_no = att_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getNumOfStd() {
		return numOfStd;
	}
	public void setNumOfStd(int numOfStd) {
		this.numOfStd = numOfStd;
	}
	
	
}
