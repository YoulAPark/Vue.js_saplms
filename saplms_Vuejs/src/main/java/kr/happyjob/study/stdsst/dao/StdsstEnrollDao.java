package kr.happyjob.study.stdsst.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.stdsst.model.StdsstEnrollModel;

public interface StdsstEnrollDao {
	
	public List<StdsstEnrollModel> listenroll(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	public StdsstEnrollModel selectenroll(Map<String, Object> paramMap) throws Exception;
	
	public void insertenroll(Map<String, Object> paramMap) throws Exception;
	public void updateenroll(Map<String, Object> paramMap) throws Exception;
	public void deleteenroll(Map<String, Object> paramMap) throws Exception;
	
	
}
