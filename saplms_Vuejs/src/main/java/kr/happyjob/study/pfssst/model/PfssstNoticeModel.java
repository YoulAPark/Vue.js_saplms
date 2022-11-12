package kr.happyjob.study.pfssst.model;

public class PfssstNoticeModel {
	
	// 게시판 글 번호
	private int row_num;					// 공지사항 게시글 행 번호/갯수
	private int noticeNo;					// 공지사항 게시글 
	private int searchselect;			// 게시글 검색조건 셀렉트박스 인자 제목/내용
	
	private String loginId;					// 로그인중인 사용자 정보
	private String noticeTitle;				// 공지사항 제목
	private String noticeContent;			// 공지사항 내용
	private String noticeRegdate;			// 공지사항 등록일자
	private String from_date;				// 게시글 날짜검색 시작일자  *미사용
	private String to_date;					// 게시글 날짜검색 끝일자     *미사용
	private String searchvalue;				// 게시글 검색값
	
	
	
	public int getSearchselect() {
		return searchselect;
	}
	public void setSearchselect(int searchselect) {
		this.searchselect = searchselect;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeRegdate() {
		return noticeRegdate;
	}
	public void setNoticeRegdate(String noticeRegdate) {
		this.noticeRegdate = noticeRegdate;
	}
	
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}	
	public String getSearchvalue() {
		return searchvalue;
	}
	public void setSearchvalue(String searchvalue) {
		this.searchvalue = searchvalue;
	}
}
