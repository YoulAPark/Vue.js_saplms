package kr.happyjob.study.stdsmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsmt.dao.StdsmtSurveyDao;
import kr.happyjob.study.stdsmt.model.StdsmtSurveyContentModel;
import kr.happyjob.study.stdsmt.model.StdsmtSurveyModel;

@Service
public class StdsmtSurveyServiceImpl implements StdsmtSurveyService{

	@Autowired
	StdsmtSurveyDao StdsmtSurveyDao;

	@Override
	public List<StdsmtSurveyModel> surveyLecList(Map<String, Object> paramMap) throws Exception {
		List<StdsmtSurveyModel> surveyLecList = StdsmtSurveyDao.surveyLecList(paramMap);
		return surveyLecList;
	}

	@Override
	public int surveyLecListCnt(Map<String, Object> paramMap) throws Exception {
		return StdsmtSurveyDao.surveyLecListCnt(paramMap);
	}

	@Override
	public List<StdsmtSurveyContentModel> surveyContentList(Map<String, Object> paramMap) throws Exception {
		List<StdsmtSurveyContentModel> surveyContentList = StdsmtSurveyDao.surveyContentList(paramMap);
		return surveyContentList;
	}

	@Override
	public int surveyContentCnt(Map<String, Object> paramMap) throws Exception {
		return StdsmtSurveyDao.surveyContentCnt(paramMap);
	}

	@Override
	public void insertSurvey(Map<String, Object> paramMap) throws Exception {
		StdsmtSurveyDao.insertSurvey(paramMap);
		return;
	}
	
}
