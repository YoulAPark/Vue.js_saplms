package kr.happyjob.study.admstat.model;

import java.util.Date;

public class AdmstatSatisfactionModel {
	

	private String li_nm;
	private String li_date;
	private String li_redate;
	private int sv_count;
	private int sv_cj;
	private int sv_sumcj;
	private double sv_avgcj;
	private int sv_maxcj;
	private int sv_mincj;
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
	public int getSv_count() {
		return sv_count;
	}
	public void setSv_count(int sv_count) {
		this.sv_count = sv_count;
	}
	public int getSv_cj() {
		return sv_cj;
	}
	public void setSv_cj(int sv_cj) {
		this.sv_cj = sv_cj;
	}
	public int getSv_sumcj() {
		return sv_sumcj;
	}
	public void setSv_sumcj(int sv_sumcj) {
		this.sv_sumcj = sv_sumcj;
	}
	public double getSv_avgcj() {
		return sv_avgcj;
	}
	public void setSv_avgcj(double sv_avgcj) {
		this.sv_avgcj = sv_avgcj;
	}
	public int getSv_maxcj() {
		return sv_maxcj;
	}
	public void setSv_maxcj(int sv_maxcj) {
		this.sv_maxcj = sv_maxcj;
	}
	public int getSv_mincj() {
		return sv_mincj;
	}
	public void setSv_mincj(int sv_mincj) {
		this.sv_mincj = sv_mincj;
	}
		
	
	
}