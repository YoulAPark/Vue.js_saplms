package kr.happyjob.study.stdsmt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsmt.dao.StdsmtExamDao;
import kr.happyjob.study.stdsmt.model.StdsmtAnswerModel;
import kr.happyjob.study.stdsmt.model.StdsmtExamModel;

@Service
public class StdsmtExamServiceImpl implements StdsmtExamService {

	@Autowired
	StdsmtExamDao dao;
	
	public List<StdsmtExamModel> examLecList(Map<String, Object> paramMap){
		List<StdsmtExamModel> examLecList = dao.examLecList(paramMap);
		return examLecList;
	};
	public int searchlistcnt(Map<String, Object> paramMap){
		int searchlistcnt = dao.searchlistcnt(paramMap);
		return searchlistcnt;
	};
	
	public ArrayList<StdsmtExamModel> selectoneExampaper(Map<String, Object> paramMap){
		return dao.selectoneExampaper(paramMap);
	};
	
	public String selectForGrading(Map<String, Object> paramMap){
		return String.valueOf(dao.selectForGrading(paramMap));
	};
	
	public void insertAnswerPaper(Map<String, Object> paramMap){
		dao.insertAnswerPaper(paramMap);
	};
	
	public List<StdsmtExamModel> selectResultpaper(Map<String, Object> paramMap){
		return dao.selectResultpaper(paramMap);
	};
	
	public String sum_score(Map<String, Object> paramMap){
		return dao.sum_score(paramMap);
	};
}
