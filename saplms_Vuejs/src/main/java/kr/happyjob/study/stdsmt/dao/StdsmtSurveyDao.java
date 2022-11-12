package kr.happyjob.study.stdsmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsmt.model.StdsmtSurveyContentModel;
import kr.happyjob.study.stdsmt.model.StdsmtSurveyModel;

public interface StdsmtSurveyDao {
	
	/** 현재 수강 완료한 강의 리스트 */
	public List<StdsmtSurveyModel> surveyLecList(Map<String, Object> paramMap) throws Exception;

	/** 현재 수강 완료한 강의 리스트 갯수 */
	public int surveyLecListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 설문조사 항목(공통코드 테이블) */
	public List<StdsmtSurveyContentModel> surveyContentList(Map<String, Object> paramMap) throws Exception;
	
	/** 설문조사 항목 갯수 */
	public int surveyContentCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 설문조사 결과 등록  */
	public void insertSurvey(Map<String, Object> paramMap) throws Exception;

}
