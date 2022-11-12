package kr.happyjob.study.admjmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admjmt.model.AdmjmtJoblnfoModel;
import kr.happyjob.study.admsst.model.AdmsstNoticeModel;

public interface AdmjmtJobInfoDao {
	
	public List<AdmjmtJoblnfoModel> listjobInfoMgt(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	public AdmjmtJoblnfoModel selectJobinfo(Map<String, Object> paramMap) throws Exception;
	
	public void insertjobInfo(Map<String, Object> paramMap) throws Exception;
	public void updatejobInfo(Map<String, Object> paramMap) throws Exception;
	public void deletejobInfo(Map<String, Object> paramMap) throws Exception;

	
}

