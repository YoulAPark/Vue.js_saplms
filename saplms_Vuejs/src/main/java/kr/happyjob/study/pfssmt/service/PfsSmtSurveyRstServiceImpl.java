package kr.happyjob.study.pfssmt.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pfssmt.dao.PfsSmtSurveyRstDao;
import kr.happyjob.study.pfssmt.model.PfsSmtSurveyRstVo;

@Service
public class PfsSmtSurveyRstServiceImpl implements PfsSmtSurveyRstService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	PfsSmtSurveyRstDao pfsSmtSurveyRstDao;

	@Override
	public List<PfsSmtSurveyRstVo> surveyRstList(Map<String, Object> paramMap) throws Exception {
		List<PfsSmtSurveyRstVo> surveyRstList = pfsSmtSurveyRstDao.surveyRstList(paramMap);
		logger.info("서비스임플까지는 호출");

		return surveyRstList;
	}

	@Override
	public int SurveyRstCnt(Map<String, Object> paramMap) throws Exception {
		int SurveyRstCnt = pfsSmtSurveyRstDao.SurveyRstCnt(paramMap);
		return SurveyRstCnt;
	}

}
