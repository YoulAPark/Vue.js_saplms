package kr.happyjob.study.stdsmt.model;

public class StdsmtReportModel {
	// 게시판 글 번호
		private int row_num;
		private int reportNo;
		
		private int att_no;
		private int att_size;
		
		private String loginId;
		private String reportTitle;
		private String reportContent;
		private String reportRegdate;
		private String from_date;
		private String to_date;
		private String proName;
		private String li_nm;
		private String li_no;
		private String stdName;
		private String stdId;
		
		
		private String att_ori;
		private String att_nli;
		private String att_mul;
       
		
		
		public String getLi_no() {
			return li_no;
		}
		public void setLi_no(String li_no) {
			this.li_no = li_no;
		}
		public int getRow_num() {
			return row_num;
		}
		public void setRow_num(int row_num) {
			this.row_num = row_num;
		}
		public int getReportNo() {
			return reportNo;
		}
		public void setReportNo(int reportNo) {
			this.reportNo = reportNo;
		}
		public String getLoginId() {
			return loginId;
		}
		public void setLoginId(String loginId) {
			this.loginId = loginId;
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
		public String getReportTitle() {
			return reportTitle;
		}
		public void setReportTitle(String reportTitle) {
			this.reportTitle = reportTitle;
		}
		public String getReportContent() {
			return reportContent;
		}
		public void setReportContent(String reportContent) {
			this.reportContent = reportContent;
		}
		public String getReportRegdate() {
			return reportRegdate;
		}
		public void setReportRegdate(String reportRegdate) {
			this.reportRegdate = reportRegdate;
		}
		public String getproName() {
			return proName;
		}
		public void setproName(String proName) {
			this.proName = proName;
		}
		public String getLi_nm() {
			return li_nm;
		}
		public void setLi_nm(String li_nm) {
			this.li_nm = li_nm;
		}
		public String getStdName() {
			return stdName;
		}
		public void setStdName(String stdName) {
			this.stdName = stdName;
		}
		public String getStdId() {
			return stdId;
		}
		public void setStdId(String stdId) {
			this.stdId = stdId;
		}
		
		
		
		
		//추가구문 
		
		
		
		public int getBd_no() {
			return bd_no;
		}
		public void setBd_no(int bd_no) {
			this.bd_no = bd_no;
		}
		public String getBd_title() {
			return bd_title;
		}
		public void setBd_title(String bd_title) {
			this.bd_title = bd_title;
		}
		public String getLoginID() {
			return loginID;
		}
		public void setLoginID(String loginID) {
			this.loginID = loginID;
		}
		public String getBd_contents() {
			return bd_contents;
		}
		public void setBd_contents(String bd_contents) {
			this.bd_contents = bd_contents;
		}
		public String getBd_date() {
			return bd_date;
		}
		public void setBd_date(String bd_date) {
			this.bd_date = bd_date;
		}
		public int getBd_type() {
			return bd_type;
		}
		public void setBd_type(int bd_type) {
			this.bd_type = bd_type;
		}
		public int getAtt_no() {
			return att_no;
		}
		public void setAtt_no(int att_no) {
			this.att_no = att_no;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getAtt_ori() {
			return att_ori;
		}
		public void setAtt_ori(String att_ori) {
			this.att_ori = att_ori;
		}
		public String getAtt_nli() {
			return att_nli;
		}
		public void setAtt_nli(String att_nli) {
			this.att_nli = att_nli;
		}
		public String getAtt_mul() {
			return att_mul;
		}
		public void setAtt_mul(String att_mul) {
			this.att_mul = att_mul;
		}
		public int getAtt_size() {
			return att_size;
		}
		public void setAtt_size(int att_size) {
			this.att_size = att_size;
		}
		private int bd_no;
		private String bd_title;
		private String loginID;
		private String bd_contents;
		private String bd_date;
		private int bd_type;
		private String name;
		
		
		
		/*
		
	      li_nm
	      stdName
	      stdId
	      reportcontents
	      reportRegdate
	      proName*/

		
		// 공지사항 복붙		
		
		/*
		public int getRow_num() {
			return row_num;
		}
		public void setRow_num(int row_num) {
			this.row_num = row_num;
		}
		public int getReportNo() {
			return reportNo;
		}
		public void setReportNo(int reportNo) {
			this.reportNo = reportNo;
		}
		public String getLoginId() {
			return loginId;
		}
		public void setLoginId(String loginId) {
			this.loginId = loginId;
		}
		public String getreportTitle() {
			return reportTitle;
		}
		public void setreportTitle(String reportTitle) {
			this.reportTitle = reportTitle;
		}
		public String getreportContent() {
			return reportContent;
		}
		public void setreportContent(String reportContent) {
			this.reportContent = reportContent;
		}
		public String getreportRegdate() {
			return reportRegdate;
		}
		public void setreportRegdate(String reportRegdate) {
			this.reportRegdate = reportRegdate;
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
*/
		

		//파일업로드 복붙
		
		/*
		public int getBd_no() {
			return bd_no;
		}
		public void setBd_no(int bd_no) {
			this.bd_no = bd_no;
		}
		public String getBd_title() {
			return bd_title;
		}
		public void setBd_title(String bd_title) {
			this.bd_title = bd_title;
		}
		public String getLoginID() {
			return loginID;
		}
		public void setLoginID(String loginID) {
			this.loginID = loginID;
		}
		public String getBd_contents() {
			return bd_contents;
		}
		public void setBd_contents(String bd_contents) {
			this.bd_contents = bd_contents;
		}
		public String getBd_date() {
			return bd_date;
		}
		public void setBd_date(String bd_date) {
			this.bd_date = bd_date;
		}
		public int getBd_type() {
			return bd_type;
		}
		public void setBd_type(int bd_type) {
			this.bd_type = bd_type;
		}
		public int getAtt_no() {
			return att_no;
		}
		public void setAtt_no(int att_no) {
			this.att_no = att_no;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getAtt_ori() {
			return att_ori;
		}
		public void setAtt_ori(String att_ori) {
			this.att_ori = att_ori;
		}
		public String getAtt_nli() {
			return att_nli;
		}
		public void setAtt_nli(String att_nli) {
			this.att_nli = att_nli;
		}
		public String getAtt_mul() {
			return att_mul;
		}
		public void setAtt_mul(String att_mul) {
			this.att_mul = att_mul;
		}
		public int getAtt_size() {
			return att_size;
		}
		public void setAtt_size(int att_size) {
			this.att_size = att_size;
		}
		private int bd_no;
		private String bd_title;
		private String loginID;
		private String bd_contents;
		private String bd_date;
		private int bd_type;
		private int att_no;
		private String name;
		private String att_ori;
		private String att_nli;
		private String att_mul;
		private int att_size;
		
		*/


}
