package kr.happyjob.study.pfssmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pfssmt.model.PfsSmtSurveyRstVo;

public interface PfsSmtSurveyRstService {
	// 설문 결과 목록
	public List<PfsSmtSurveyRstVo> surveyRstList(Map<String, Object> paramMap) throws Exception;
	
	// 설문 결과 건수
	public int SurveyRstCnt(Map<String, Object> paramMap) throws Exception;
}

