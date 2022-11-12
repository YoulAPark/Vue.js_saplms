package kr.happyjob.study.pfssst.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admpmt.model.ClassroomInfoModel;
import kr.happyjob.study.pfssst.model.PfssstLecNoticeModel;

public interface PfssstLecNoticeDao {

	/**  목록 조회 */
	public List<PfssstLecNoticeModel> listLecNotice(Map<String, Object> paramMap) throws Exception;
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;	
	
	public PfssstLecNoticeModel selectLecNotice(Map<String, Object> paramMap) throws Exception;
	
	public void insertLecNotice(Map<String, Object> paramMap) throws Exception;
	public void updateLecNotice(Map<String, Object> paramMap) throws Exception;
	public void deleteLecNotice(Map<String, Object> paramMap) throws Exception;
	
	public List<ClassroomInfoModel> listroominfo(Map<String, Object> paramMap) throws Exception;
}
