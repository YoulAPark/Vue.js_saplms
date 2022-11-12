package kr.happyjob.study.stdsmt.model;

import java.util.ArrayList;

public class StdsmtAnswerModel {
	private int li_no;
	private String loginID;
	private int test_cd;
	private int qst_cd;
	private String ss_answer;
	private int ss_score;
	private ArrayList<StdsmtAnswerModel> anslist;
	
	public int getLi_no() {
		return li_no;
	}
	public void setLi_no(int li_no) {
		this.li_no = li_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getTest_cd() {
		return test_cd;
	}
	public void setTest_cd(int test_cd) {
		this.test_cd = test_cd;
	}
	public int getQst_cd() {
		return qst_cd;
	}
	public void setQst_cd(int qst_cd) {
		this.qst_cd = qst_cd;
	}
	public String getSs_answer() {
		return ss_answer;
	}
	public void setSs_answer(String ss_answer) {
		this.ss_answer = ss_answer;
	}
	public int getSs_score() {
		return ss_score;
	}
	public void setSs_score(int ss_score) {
		this.ss_score = ss_score;
	}
	public ArrayList<StdsmtAnswerModel> getAnslist() {
		return anslist;
	}
	public void setAnslist(ArrayList<StdsmtAnswerModel> anslist) {
		this.anslist = anslist;
	}
}
