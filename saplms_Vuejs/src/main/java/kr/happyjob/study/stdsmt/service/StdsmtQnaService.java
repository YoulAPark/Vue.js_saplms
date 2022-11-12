package kr.happyjob.study.stdsmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsmt.model.StdsmtCommentModel;
import kr.happyjob.study.stdsmt.model.StdsmtQnaModel;

public interface StdsmtQnaService {
	
	public List<StdsmtQnaModel> qnaList(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt2(Map<String, Object> paramMap) throws Exception;
		
	public void insertQna(Map<String, Object> paramMap) throws Exception;
	
	public void updateQna(Map<String, Object> paramMap) throws Exception;
	
	public void deleteQna(Map<String, Object> paramMap) throws Exception;
	
	public StdsmtQnaModel getQna(Map<String, Object> paramMap) throws Exception;
	
	public void insertComment(Map<String, Object> paramMap) throws Exception;
	
	public void deleteComment(Map<String, Object> paramMap) throws Exception;
	
	public List<StdsmtCommentModel> getComment(Map<String, Object> paramMap) throws Exception;
}
