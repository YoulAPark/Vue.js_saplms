package kr.happyjob.study.admsmt.model;

public class AdmsmtSurveyMgtModel {
	
	private int li_type;			// 강의 분류 코드
	
	private String li_typeNm;		// 강의 분류 코드명
	
	private int lecNo;				// 강의코드
	
	private String lecNm;			// 강의명(과목)
	
	private String teacherNm;		// 강사명
	
	private String studentNm;		// 설문참여 학생명
	
	private String lecSdate;		// 강의시작일
	
	private String lecEdate;		// 강의종료일
	
	private int svSum;				// (강의별 학생이 준)총평점
	
	private int eachSum;			// (학생별 강의에 대한)총평점
	
	private String svAnswer;		// 설문답(주관식 1문항)
	
	private int svAttendCnt;		// 설문참여인원

	public int getLi_type() {
		return li_type;
	}

	public void setLi_type(int li_type) {
		this.li_type = li_type;
	}

	public String getLi_typeNm() {
		return li_typeNm;
	}

	public void setLi_typeNm(String li_typeNm) {
		this.li_typeNm = li_typeNm;
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

	public int getSvSum() {
		return svSum;
	}

	public void setSvSum(int svSum) {
		this.svSum = svSum;
	}

	public int getEachSum() {
		return eachSum;
	}

	public void setEachSum(int eachSum) {
		this.eachSum = eachSum;
	}

	public String getSvAnswer() {
		return svAnswer;
	}

	public void setSvAnswer(String svAnswer) {
		this.svAnswer = svAnswer;
	}

	public int getSvAttendCnt() {
		return svAttendCnt;
	}

	public void setSvAttendCnt(int svAttendCnt) {
		this.svAttendCnt = svAttendCnt;
	}
	
}
