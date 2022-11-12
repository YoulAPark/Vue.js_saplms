package kr.happyjob.study.admsmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admsmt.dao.AdmsmtSurveyMgtDao;
import kr.happyjob.study.admsmt.model.AdmsmtSurveyMgtModel;

@Service("AdmsmtSurveyMgtService")
public class AdmsmtSurveyMgtServiceImpl implements AdmsmtSurveyMgtService{
	
	@Autowired
	AdmsmtSurveyMgtDao admsmtSurveyMgtDao;
	
	/** 설문 카운트 조회 */
	@Override
	public int listSurveyCnt(Map<String, Object> paramMap) throws Exception{
		int listSurveyCnt = admsmtSurveyMgtDao.listSurveyCnt(paramMap);
		return listSurveyCnt;
	}
	
	/** 설문 조회 */
	@Override
	public List<AdmsmtSurveyMgtModel> listSurvey(Map<String, Object> paramMap) throws Exception{
		List<AdmsmtSurveyMgtModel> listSurvey = admsmtSurveyMgtDao.listSurvey(paramMap);
		return listSurvey;
	}

	/** 과목별 설문 상세 카운트 조회 */
	@Override
	public int selectSurveyListCnt(Map<String, Object> paramMap) throws Exception{
		return admsmtSurveyMgtDao.selectSurveyListCnt(paramMap);
	}
	
	/** 과목별 설문 상세 조회 */
	@Override
	public List<AdmsmtSurveyMgtModel> selectSurveyList(Map<String, Object> paramMap) throws Exception{
		List<AdmsmtSurveyMgtModel> selectSurveyList = admsmtSurveyMgtDao.selectSurveyList(paramMap);
		return selectSurveyList;
	}

}