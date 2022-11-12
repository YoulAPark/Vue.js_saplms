package kr.happyjob.study.stdsmt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.stdsmt.model.StdsmtReportModel;

public interface StdsmtReportService {

	// 과제목록 리스트 조회
	public List<StdsmtReportModel> stdsmtReportList(Map<String, Object> paramMap)throws Exception ;
	
	// 과제목록 목록 카운트 조회
	public int stdsmtReportCnt(Map<String, Object> paramMap)throws Exception ;
	
	// 과제목록 단건조회
	public StdsmtReportModel selectreport(Map<String, Object> paramMap) throws Exception;
	
	// 과제목록 수정
	public void updateStdsmtReport(Map<String, Object> paramMap) throws Exception;

	public void insertReportFileatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	public void updateReportFileatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	public void deleteReportFileatt(Map<String, Object> paramMap) throws Exception;
	
	
	
	// 강사네이밍 자동변경 
	public StdsmtReportModel changeproname(Map<String, Object> paraMap) throws Exception;
	
	public List<StdsmtReportModel> myLecList(Map<String, Object> paraMap) throws Exception;
	
}
