package kr.happyjob.study.stdsst.model;

import java.util.Date;

public class StdsstLecDataModel {

   // 자료코드
   private int le_no;

   // 강의코드
   private int li_no;

   // 제목
   private String le_title;

   // 작성자
   private String le_nm;
    
   // 내용
   private String le_contents;

   // 파일번호
   private int att_no;

   private String le_date;
   
   private String att_ori;
   private String att_nli;
   private String att_mul;
   private int att_size;
   
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

public int getAtt_size() {
	return att_size;
}

public void setAtt_size(int att_size) {
	this.att_size = att_size;
}

public String getLe_date() {
	return le_date;
}

public void setLe_date(String le_date) {
	this.le_date = le_date;
}

public int getLe_no() {
	return le_no;
}

public void setLe_no(int le_no) {
	this.le_no = le_no;
}

public int getLi_no() {
	return li_no;
}

public void setLi_no(int li_no) {
	this.li_no = li_no;
}

public String getLe_title() {
	return le_title;
}

public void setLe_title(String le_title) {
	this.le_title = le_title;
}

public String getLe_nm() {
	return le_nm;
}

public void setLe_nm(String le_nm) {
	this.le_nm = le_nm;
}

public String getLe_contents() {
	return le_contents;
}

public void setLe_contents(String le_contents) {
	this.le_contents = le_contents;
}

public int getAtt_no() {
	return att_no;
}

public void setAtt_no(int att_no) {
	this.att_no = att_no;
}


}