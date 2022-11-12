package kr.happyjob.study.stdsmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsmt.dao.StdsmtQnaDao;
import kr.happyjob.study.stdsmt.model.StdsmtCommentModel;
import kr.happyjob.study.stdsmt.model.StdsmtQnaModel;

@Service("stdsmtQnaService")
public class StdsmtQnaServiceImpl implements StdsmtQnaService {
	
	@Autowired
	private StdsmtQnaDao stdsmtQnaDao;
	
	@Override
	public List<StdsmtQnaModel> qnaList(Map<String, Object> paramMap) throws Exception {
		return stdsmtQnaDao.qnaList(paramMap);
	}
	
	@Override
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		return stdsmtQnaDao.searchlistcnt(paramMap);
	}
	
	@Override
	public int searchlistcnt2(Map<String, Object> paramMap) throws Exception {
		return stdsmtQnaDao.searchlistcnt2(paramMap);
	}
	
	@Override
	public void insertQna(Map<String, Object> paramMap) throws Exception {
		stdsmtQnaDao.insertQna(paramMap);
		return;
	}
	
	@Override
	public void updateQna(Map<String, Object> paramMap) throws Exception {
		stdsmtQnaDao.updateQna(paramMap);
		return;
	}
	
	@Override
	public void deleteQna(Map<String, Object> paramMap) throws Exception {
		stdsmtQnaDao.deleteQna(paramMap);
		return;
	}

	@Override
	public StdsmtQnaModel getQna(Map<String, Object> paramMap) throws Exception {
		
		StdsmtQnaModel getQna = stdsmtQnaDao.getQna(paramMap);
		
		return getQna;
	}
	
	@Override
	public void insertComment(Map<String, Object> paramMap) throws Exception {
		stdsmtQnaDao.insertComment(paramMap);
		return;
	}
	
	@Override
	public void deleteComment(Map<String, Object> paramMap) throws Exception {
		stdsmtQnaDao.deleteComment(paramMap);
		return;
	}
	
	@Override
	public List<StdsmtCommentModel> getComment(Map<String, Object> paramMap) throws Exception {
		return stdsmtQnaDao.getComment(paramMap);
	}
}
