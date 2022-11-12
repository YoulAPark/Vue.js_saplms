package kr.happyjob.study.pfssst.model;



public class PfssstLecNoticeModel {
	
	private int li_no;				// 강의 코드
	private int li_type;			// 분류 : 재직자, 실업자
    private String li_nm;			// 강의명, 과정명
    private String loginID;			// 사용자ID
    private String li_date;			// 강의시작날짜
    private String li_redate;		// 강의종료날짜
    private int li_ap;				// 신청인원
    private int li_garden;			// 정원
    private String name;			// (사용자정보 : 강사)이름
    private String ci_nm;			// (강의실 정보)강의실명
    private String detail_name;		// (공통코드)상세코드
    private String hp;				// (사용자정보)연락처
    private String email;			// (사용자정보)이메일
    private String li_target;		// 수업목표
    private String li_ad;			// 출석(방법)
    private String li_plan;			// 강의계획
    private int li_no2;
    private String detail_code;
    
    
    
	public String getDetail_code() {
		return detail_code;
	}
	public void setDetail_code(String detail_code) {
		this.detail_code = detail_code;
	}
	public int getLi_no2() {
		return li_no2;
	}
	public void setLi_no2(int li_no2) {
		this.li_no2 = li_no2;
	}
	public String getLi_target() {
		return li_target;
	}
	public void setLi_target(String li_target) {
		this.li_target = li_target;
	}
	public String getLi_ad() {
		return li_ad;
	}
	public void setLi_ad(String li_ad) {
		this.li_ad = li_ad;
	}
	public String getLi_plan() {
		return li_plan;
	}
	public void setLi_plan(String li_plan) {
		this.li_plan = li_plan;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLi_no() {
		return li_no;
	}
	public void setLi_no(int li_no) {
		this.li_no = li_no;
	}
	public int getLi_type() {
		return li_type;
	}
	public void setLi_type(int li_type) {
		this.li_type = li_type;
	}
	public String getLi_nm() {
		return li_nm;
	}
	public void setLi_nm(String li_nm) {
		this.li_nm = li_nm;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
	public int getLi_ap() {
		return li_ap;
	}
	public void setLi_ap(int li_ap) {
		this.li_ap = li_ap;
	}
	public int getLi_garden() {
		return li_garden;
	}
	public void setLi_garden(int li_garden) {
		this.li_garden = li_garden;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCi_nm() {
		return ci_nm;
	}
	public void setCi_nm(String ci_nm) {
		this.ci_nm = ci_nm;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}  
}
