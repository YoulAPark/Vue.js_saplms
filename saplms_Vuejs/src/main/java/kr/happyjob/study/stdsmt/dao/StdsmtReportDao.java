package kr.happyjob.study.stdsmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsmt.model.StdsmtReportModel;

public interface StdsmtReportDao {

	
	// 공지사항 리스트 조회
	public List<StdsmtReportModel> stdsmtReportList(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 목록 카운트 조회
	public int stdsmtReportCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 공지사항 단건 조회
	public StdsmtReportModel stdsmtReportDetail(Map<String, Object> paramMap)throws Exception ;

	// 과제 제출 단건조회
	public StdsmtReportModel selectreport(Map<String, Object> paramMap) throws Exception;
	
	
	
	// 과제 파일 업로드,수정,삭제

	public int updateStdsmtReport(Map<String, Object> paramMap) throws Exception;
	
	public void insertReportFileatt(Map<String, Object> paramMap) throws Exception;
	public void updateReportFileatt(Map<String, Object> paramMap) throws Exception;
	public void deleteReportFileatt(Map<String, Object> paramMap) throws Exception;
	
	public void insertReportinfo(Map<String, Object> paramMap) throws Exception;
	
	
	public void deleteReportinfobyasnno(Map<String, Object> paramMap) throws Exception;

	// 강사 이름 변경
	
	public StdsmtReportModel changeproname(Map<String, Object> paramMap);
	
	public List<StdsmtReportModel> myLecList(Map<String, Object> paramMap);

}

