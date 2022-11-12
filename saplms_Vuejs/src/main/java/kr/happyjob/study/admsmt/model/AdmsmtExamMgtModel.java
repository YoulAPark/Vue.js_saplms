package kr.happyjob.study.admsmt.model;

public class AdmsmtExamMgtModel {
	
	private int test_cd; //시험번호
	private String test_nm;// 시험문제명(시험지)
	private String useyn; //사용유무
	private int qst_cd; //문제번호
	private String qst_contents; //문제내용
	private String qst_answer; //정답
	private String view1; //보기1
	private String view2;//보기2
	private String view3;//보기3
	private String view4;//보기4
	private int score; //문제점수
	private int total; //총 시험지 수(시험문제명) 
	
	
	
	public int getQst_cd() {
		return qst_cd;
	}
	public void setQst_cd(int qst_cd) {
		this.qst_cd = qst_cd;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getTest_cd() {
		return test_cd;
	}
	public void setTest_cd(int test_cd) {
		this.test_cd = test_cd;
	}
	public String getTest_nm() {
		return test_nm;
	}
	public void setTest_nm(String test_nm) {
		this.test_nm = test_nm;
	}
	public String getUseyn() {
		return useyn;
	}
	public void setUseyn(String useyn) {
		this.useyn = useyn;
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
	
	
	
	
	
	
	
	
		
	
}
