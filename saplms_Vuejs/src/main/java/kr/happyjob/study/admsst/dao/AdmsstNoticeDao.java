package kr.happyjob.study.admsst.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admsst.model.AdmsstNoticeModel;

public interface AdmsstNoticeDao {
	
	/**  목록 조회 */
	public List<AdmsstNoticeModel> listNotice(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;	
	
	public AdmsstNoticeModel selectNotice(Map<String, Object> paramMap) throws Exception;
	
	public void insertNotice(Map<String, Object> paramMap) throws Exception;
	public void updateNotice(Map<String, Object> paramMap) throws Exception;
	public void deleteNotice(Map<String, Object> paramMap) throws Exception;

}
