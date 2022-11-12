package kr.happyjob.study.admhmt.model;

public class AdmhmtProfessorMgtModel {
	
	private String name;
	private String loginID;
	private String password;
	private String hp;
	private String icclass;
	private String regdate;
	
	public AdmhmtProfessorMgtModel() {
		
	}
	
	public AdmhmtProfessorMgtModel(String name, String loginID, String password, String hp, String icclass, String regdate) {
		this.name = name;
		this.loginID = loginID;
		this.password = password;
		this.hp = hp;
		this.icclass = icclass;
		this.regdate = regdate;
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
	public String getIcclass() {
		return icclass;
	}
	public void setIcclass(String icclass) {
		this.icclass = icclass;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "ProfessorMgtModel [name=" + name + ", loginID=" + loginID + ", password=" + password + ", hp=" + hp
				+ ", icclass=" + icclass + ", regdate=" + regdate + "]";
	}
	
}
