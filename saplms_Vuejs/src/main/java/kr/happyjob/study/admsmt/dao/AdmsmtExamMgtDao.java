package kr.happyjob.study.admsmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admsmt.model.AdmsmtExamMgtModel;

public interface AdmsmtExamMgtDao {

	public List<AdmsmtExamMgtModel> getExamList(Map<String, Object> paramMap) throws Exception;
	
	public int getTotalExam(Map<String, Object> paramMap) throws Exception;

	public List<AdmsmtExamMgtModel> questionDetailList(Map<String, Object> paramMap) throws Exception;

	public void questionUpdate(Map<String, Object> paramMap) throws Exception;

	public void questionDelete(Map<String, Object> paramMap) throws Exception;

	public void questionInsert(Map<String, Object> paramMap) throws Exception;

	public void testDeleteGo(Map<String, Object> paramMap) throws Exception;

	public void beforeTestDeleteGo(Map<String, Object> paramMap)throws Exception;

	public void testInsert(Map<String, Object> paramMap) throws Exception;

	public List<AdmsmtExamMgtModel> getExamList2(Map<String, Object> paramMap)throws Exception;

	public void testUpdate(Map<String, Object> paramMap)throws Exception;

	public int testMaxNumber() throws Exception;

	public int questionMaxNumber(Map<String, Object> paramMap) throws Exception;

	

	


	
	

}
