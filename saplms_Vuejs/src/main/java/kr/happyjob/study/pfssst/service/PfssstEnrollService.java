package kr.happyjob.study.pfssst.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.pfssst.model.PfssstEnrollModel;

public interface PfssstEnrollService {
	
	public List<PfssstEnrollModel> listenroll(Map<String, Object> paramMap) throws Exception; // 리스트
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception; // 리스트 총 목록
	
	public PfssstEnrollModel selectenroll(Map<String, Object> paramMap) throws Exception; // 레코드 단건
	
	public List<PfssstEnrollModel> linoone(Map<String, Object> paramMap) throws Exception; // li_no 없는 강의명
	
	public void insertenroll(Map<String, Object> paramMap) throws Exception; // 수강과목관리 테이블 insert
	public void updateenroll(Map<String, Object> paramMap) throws Exception;
	public void deleteenroll(Map<String, Object> paramMap) throws Exception;
	
	public void insertFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception; // 파일 insert
	public void updateFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception; // 파일 update
	public void deleteFileuploadatt(Map<String, Object> paramMap) throws Exception; // 파일 delete

	public PfssstEnrollModel selectFileupload(Map<String, Object> paramMap)throws Exception;
	

}
