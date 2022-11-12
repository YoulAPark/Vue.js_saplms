package kr.happyjob.study.stdsmt.model;

public class StdsmtExamModel {

	private int li_no;				//강의코드
	private String li_nm;			//강의명
	
	private int test_cd;			//시험번호
	private String test_nm;			//시험명
	private int qst_cd;				//문제번호
	private String qst_contents;	//문제내용
	private String qst_answer;		//정답
	private String view1;			//보기1
	private String view2;			//보기2
	private String view3;			//보기3
	private String view4;			//보기4
	private int score;				//문제 배점
	
	private String loginID;			//사용자ID
	private String ss_answer;		//제출답안
	private int ss_score;			//문제당 획득 점수
	private int count;				//문항 개수
	private int status;				//시험 응시 완료 or 미완료 구분용
	private int sum_score;			//시험 점수(학생)
	
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
	public String getQst_contents() {
		return qst_contents;
	}
	public void setQst_contents(String qst_contents) {
		this.qst_contents = qst_contents;
	}
	public String getQst_answer() {
		return qst_answer;
	}
	public void setQst_answer(String qst_answer) {
		this.qst_answer = qst_answer;
	}
	public String getView1() {
		return view1;
	}
	public void setView1(String view1) {
		this.view1 = view1;
	}
	public String getView2() {
		return view2;
	}
	public void setView2(String view2) {
		this.view2 = view2;
	}
	public String getView3() {
		return view3;
	}
	public void setView3(String view3) {
		this.view3 = view3;
	}
	public String getView4() {
		return view4;
	}
	public void setView4(String view4) {
		this.view4 = view4;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
	public String getTest_nm() {
		return test_nm;
	}
	public void setTest_nm(String test_nm) {
		this.test_nm = test_nm;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getSum_score() {
		return sum_score;
	}
	public void setSum_score(int sum_score) {
		this.sum_score = sum_score;
	}
	

}
