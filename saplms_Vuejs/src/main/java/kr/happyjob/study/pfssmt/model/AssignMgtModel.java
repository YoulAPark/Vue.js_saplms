package kr.happyjob.study.pfssmt.model;

public class AssignMgtModel {
	
	private int as_no;
	private int att_no;
	private int att_size;
	private String li_nm;
	private String as_date;
	private String as_contents;
	private String name;
	private String att_ori;
	private String att_nli;
	private String att_mul;
	
	public int getAs_no() {
		return as_no;
	}
	public void setAs_no(int as_no) {
		this.as_no = as_no;
	}
	public int getAtt_no() {
		return att_no;
	}
	public void setAtt_no(int att_no) {
		this.att_no = att_no;
	}
	public int getAtt_size() {
		return att_size;
	}
	public void setAtt_size(int att_size) {
		this.att_size = att_size;
	}
	public String getLi_nm() {
		return li_nm;
	}
	public void setLi_nm(String li_nm) {
		this.li_nm = li_nm;
	}
	public String getAs_date() {
		return as_date;
	}
	public void setAs_date(String as_date) {
		this.as_date = as_date;
	}
	public String getAs_contents() {
		return as_contents;
	}
	public void setAs_contents(String as_contents) {
		this.as_contents = as_contents;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAtt_ori() {
		return att_ori;
	}
	public void setAtt_ori(String att_ori) {
		this.att_ori = att_ori;
	}
	public String getAtt_nli() {
		return att_nli;
	}
	public void setAtt_nli(String att_nli) {
		this.att_nli = att_nli;
	}
	public String getAtt_mul() {
		return att_mul;
	}
	public void setAtt_mul(String att_mul) {
		this.att_mul = att_mul;
	}
	@Override
	public String toString() {
		return "AssignMgtModel [as_no=" + as_no + ", att_no=" + att_no + ", att_size=" + att_size + ", li_nm=" + li_nm
				+ ", as_date=" + as_date + ", as_contents=" + as_contents + ", name=" + name + ", att_ori=" + att_ori
				+ ", att_nli=" + att_nli + ", att_mul=" + att_mul + "]";
	}
}
