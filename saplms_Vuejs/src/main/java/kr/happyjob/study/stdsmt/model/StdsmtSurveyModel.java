package kr.happyjob.study.stdsmt.model;

public class StdsmtSurveyModel {
	
	private int lecNo;				// 강의번호
	
	private String lecNm;			// 강의명(과목)
	
	private String teacherNm; 		// 강사명

	private String studentNm;		// 수강생명
	
	private String lecSdate;		// 강의시작일
	
	private String lecEdate;		// 강의종료일
	
	private int surveyConfirm; 		// 특정 강의에 설문참여확인(결과가 0-안함, 1-완료)

	public int getSurveyConfirm() {
		return surveyConfirm;
	}

	public void setSurveyConfirm(int surveyConfirm) {
		this.surveyConfirm = surveyConfirm;
	}
	
	public int getLecNo() {
		return lecNo;
	}

	public void setLecNo(int lecNo) {
		this.lecNo = lecNo;
	}

	public String getLecNm() {
		return lecNm;
	}

	public void setLecNm(String lecNm) {
		this.lecNm = lecNm;
	}

	public String getTeacherNm() {
		return teacherNm;
	}

	public void setTeacherNm(String teacherNm) {
		this.teacherNm = teacherNm;
	}

	public String getStudentNm() {
		return studentNm;
	}

	public void setStudentNm(String studentNm) {
		this.studentNm = studentNm;
	}

	public String getLecSdate() {
		return lecSdate;
	}

	public void setLecSdate(String lecSdate) {
		this.lecSdate = lecSdate;
	}

	public String getLecEdate() {
		return lecEdate;
	}

	public void setLecEdate(String lecEdate) {
		this.lecEdate = lecEdate;
	}

}
