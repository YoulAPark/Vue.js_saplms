package kr.happyjob.study.admsmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admsmt.model.AdmsmtSurveyMgtModel;

public interface AdmsmtSurveyMgtService {
	
	/** 설문 카운트 조회 */
	public int listSurveyCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 설문  조회 */
	public List<AdmsmtSurveyMgtModel> listSurvey(Map<String, Object> paramMap) throws Exception;

	/** 과목별 설문 상세 카운트 조회 */
	public int selectSurveyListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 과목별 설문 상세 조회 */
	public List<AdmsmtSurveyMgtModel> selectSurveyList(Map<String, Object> paramMap) throws Exception;
	
}
