package kr.happyjob.study.admhmt.model;

public class AdmhmtStudentMgtModel {








//	loc,
//	birthday,


//	user_dept
	
	
	private String name; // 학생명
	private String status_yn; // 상태
	private String loginID; // 학생번호(로그인ID)
	private String password; // 비밀번호
	private String hp; // 연락처
	private String classes; // 담당반
	private String regdate; // 가입일자
	private String user_type; // 사용자타입
	private String sex; // 성별
	private String email; // 이메일
	private String loc; // 거주지역
	private String birthday; // 생년월일
	private String user_dept; // 학과
	
	public String getStatus_yn() {
		return status_yn;
	}
	public void setStatus_yn(String status_yn) {
		this.status_yn = status_yn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes = classes;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	

}
