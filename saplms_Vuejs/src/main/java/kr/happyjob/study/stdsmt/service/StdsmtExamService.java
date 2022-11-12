package kr.happyjob.study.stdsmt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsmt.model.StdsmtAnswerModel;
import kr.happyjob.study.stdsmt.model.StdsmtExamModel;

public interface StdsmtExamService {

	List<StdsmtExamModel> examLecList(Map<String, Object> paramMap);
	int searchlistcnt(Map<String, Object> paramMap);
	ArrayList<StdsmtExamModel> selectoneExampaper(Map<String, Object> paramMap);
	String selectForGrading(Map<String, Object> paramMap);
	void insertAnswerPaper(Map<String, Object> paramMap);
	List<StdsmtExamModel> selectResultpaper(Map<String, Object> paramMap);
	String sum_score(Map<String, Object> paramMap);

}
