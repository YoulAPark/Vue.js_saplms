package kr.happyjob.study.admsmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admsmt.dao.AdmsmtExamMgtDao;
import kr.happyjob.study.admsmt.model.AdmsmtExamMgtModel;

@Service
public class AdmsmtExamMgtServiceImpl implements AdmsmtExamMgtService{

	@Autowired
	AdmsmtExamMgtDao examDao;

	@Override
	public List<AdmsmtExamMgtModel> getExamList(Map<String, Object> paramMap) throws Exception {
		List<AdmsmtExamMgtModel> examList=examDao.getExamList(paramMap);
		return examList;
	}
	
	@Override
	public int getTotalExam(Map<String, Object> paramMap) throws Exception {
		int total=examDao.getTotalExam(paramMap);
		return total;
	}



	@Override
	public List<AdmsmtExamMgtModel> questionDetailList(Map<String, Object> paramMap) throws Exception {
		List<AdmsmtExamMgtModel> questionList=examDao.questionDetailList(paramMap);
		return questionList;
	}

	@Override
	public void questionUpdate(Map<String, Object> paramMap) throws Exception {
		examDao.questionUpdate(paramMap);
		
	}

	@Override
	public void questionDelete(Map<String, Object> paramMap) throws Exception {
		examDao.questionDelete(paramMap);
		
	}

	@Override
	public void questionInsert(Map<String, Object> paramMap) throws Exception {
		examDao.questionInsert(paramMap);
	}

	@Override
	public void testDeleteGo(Map<String, Object> paramMap) throws Exception {
		examDao.beforeTestDeleteGo(paramMap);
		examDao.testDeleteGo(paramMap);
		
	}

	@Override
	public void testInsert(Map<String, Object> paramMap) throws Exception {
		examDao.testInsert(paramMap);
		
	}

	@Override
	public List<AdmsmtExamMgtModel> getExamList2(Map<String, Object> paramMap) throws Exception {
		List<AdmsmtExamMgtModel> examList=examDao.getExamList2(paramMap);
		return examList;
	}

	@Override
	public void testUpdate(Map<String, Object> paramMap) throws Exception {
		examDao.testUpdate(paramMap);
		
	}

	@Override
	public int testMaxNumber() throws Exception {
		return examDao.testMaxNumber();
	}

	@Override
	public int questionMaxNumber(Map<String, Object> paramMap) throws Exception {
		
		return examDao.questionMaxNumber(paramMap);
	}

	
	
	
	
	
	

}
