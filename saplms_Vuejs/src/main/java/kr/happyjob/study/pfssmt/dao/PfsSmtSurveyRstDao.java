package kr.happyjob.study.pfssmt.dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import kr.happyjob.study.pfssmt.model.PfsSmtSurveyRstVo;

public interface PfsSmtSurveyRstDao {
	// 설문 결과 목록
	public List<PfsSmtSurveyRstVo> surveyRstList(Map<String, Object> paramMap) throws Exception;
	// 설문 결과 
	public int SurveyRstCnt(Map<String, Object> paramMap) throws Exception;

}
