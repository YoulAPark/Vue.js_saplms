package kr.happyjob.study.admjmt.model;

public class AdmJmtResumeOutputVo {
	//사용자 성명 연락처 거주지역 학과 강의번호 강의명 재직구분 답안지 합계점수 회사명 입사일 퇴사일 재직여부 파일번호 논리경로
	private String name; //사용자 성명
	private String hp; // 연락처
	private String loc; // 거주지역
	private String user_dept; //학과
	private int li_no; // 강의번호
	private String li_nm; //강의명
	private String li_type; // 재직자 실직자 구분과정
	private String ss_socre; // 답안지 점수
	private String sum; // 답안지 합계점수
	private String em_no; // 취업코드
	private String em_nm; // 회사명
	private String em_date; // 입사일
	private String em_redate; // 퇴사일
	private String em_du; // 재직여부
	private String bd_no; // 게시글코드
	private String att_no; // 파일번호
	private String att_nli; // 논리경로
	private String att_mul; // 물리경로
	private String att_size; // 사이즈
	
	public String getAtt_mul() {
		return att_mul;
	}
	public void setAtt_mul(String att_mul) {
		this.att_mul = att_mul;
	}
	public String getAtt_size() {
		return att_size;
	}
	public void setAtt_size(String att_size) {
		this.att_size = att_size;
	}
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	private String userID; // 선택된이력서ID
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public String getUser_dept() {
		return user_dept;
	}
	public void setUser_dept(String user_dept) {
		this.user_dept = user_dept;
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
	public String getLi_type() {
		return li_type;
	}
	public void setLi_type(String li_type) {
		this.li_type = li_type;
	}
	public String getSs_socre() {
		return ss_socre;
	}
	public void setSs_socre(String ss_socre) {
		this.ss_socre = ss_socre;
	}
	public String getSum() {
		return sum;
	}
	public void setSum(String sum) {
		this.sum = sum;
	}
	public String getEm_no() {
		return em_no;
	}
	public void setEm_no(String em_no) {
		this.em_no = em_no;
	}
	public String getEm_nm() {
		return em_nm;
	}
	public void setEm_nm(String em_nm) {
		this.em_nm = em_nm;
	}
	public String getEm_date() {
		return em_date;
	}
	public void setEm_date(String em_date) {
		this.em_date = em_date;
	}
	public String getEm_redate() {
		return em_redate;
	}
	public void setEm_redate(String em_redate) {
		this.em_redate = em_redate;
	}
	public String getEm_du() {
		return em_du;
	}
	public void setEm_du(String em_du) {
		this.em_du = em_du;
	}
	public String getBd_no() {
		return bd_no;
	}
	public void setBd_no(String bd_no) {
		this.bd_no = bd_no;
	}
	public String getAtt_no() {
		return att_no;
	}
	public void setAtt_no(String att_no) {
		this.att_no = att_no;
	}
	public String getAtt_nli() {
		return att_nli;
	}
	public void setAtt_nli(String att_nli) {
		this.att_nli = att_nli;
	}
	 

}
