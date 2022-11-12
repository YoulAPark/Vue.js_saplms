package kr.happyjob.study.stdsst.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsst.model.StdsstEnrollModel;

public interface StdsstEnrollService {
	
	public List<StdsstEnrollModel> listenroll(Map<String, Object> paramMap) throws Exception; // 리스트
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception; // 리스트 총 목록
	
	public StdsstEnrollModel selectenroll(Map<String, Object> paramMap) throws Exception; // 레코드 단건
	
	public void insertenroll(Map<String, Object> paramMap) throws Exception; // 수강과목관리 테이블 insert
	public void updateenroll(Map<String, Object> paramMap) throws Exception;
	public void deleteenroll(Map<String, Object> paramMap) throws Exception;
	

}
