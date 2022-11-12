package kr.happyjob.study.pfssst.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pfssst.model.PfssstEnrollModel;

public interface PfssstEnrollDao {
	
	public List<PfssstEnrollModel> listenroll(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	public PfssstEnrollModel selectenroll(Map<String, Object> paramMap) throws Exception;
	
	public List<PfssstEnrollModel> linoone(Map<String, Object> paramMap) throws Exception;
	
	public void insertenroll(Map<String, Object> paramMap) throws Exception;
	public void updateenroll(Map<String, Object> paramMap) throws Exception;
	public void deleteenroll(Map<String, Object> paramMap) throws Exception;
	
	public void insertFileinfo(Map<String, Object> paramMap) throws Exception;
	public void deleteFileinfobybdno(Map<String, Object> paramMap) throws Exception;

	public PfssstEnrollModel selectenroll2(Map<String, Object> paramMap) throws Exception;

	//public PfssstEnrollModel selectFileupload(Map<String, Object> paramMap) throws Exception;
	
}
