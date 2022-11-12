package kr.happyjob.study.admsmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admsmt.model.AdmsmtExamMgtModel;



public interface AdmsmtExamMgtService {
	
	//시험지 목록 출력
	public List<AdmsmtExamMgtModel> getExamList(Map<String, Object> paramMap) throws Exception;
	
	//시험지 개수 출력
	public int getTotalExam (Map<String, Object> paramMap) throws Exception;
	
	//시험지 삭제
	public void testDeleteGo(Map<String, Object> paramMap)throws Exception;
	
	//시험지의 문제들 출력
	public List<AdmsmtExamMgtModel> questionDetailList(Map<String, Object> paramMap) throws Exception;

	//문제수정
	public void questionUpdate(Map<String, Object> paramMap)throws Exception;

	//문제삭제
	public void questionDelete(Map<String, Object> paramMap)throws Exception;

	// 문제 등록
	public void questionInsert(Map<String, Object> paramMap)throws Exception;

	public void testInsert(Map<String, Object> paramMap) throws Exception;

	public List<AdmsmtExamMgtModel> getExamList2(Map<String, Object> paramMap)throws Exception;

	public void testUpdate(Map<String, Object> paramMap) throws Exception;

	public int testMaxNumber()  throws Exception;

	public int questionMaxNumber(Map<String, Object> paramMap)  throws Exception;



	



	

	

	

	

	

}
