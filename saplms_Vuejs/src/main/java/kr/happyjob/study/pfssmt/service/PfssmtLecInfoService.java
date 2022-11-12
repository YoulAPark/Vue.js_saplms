package kr.happyjob.study.pfssmt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;
import kr.happyjob.study.pfssmt.model.PfssmtLecInfoModel;

public interface PfssmtLecInfoService {

	public List<PfssmtLecInfoModel> lecturelist(Map<String, Object> paramMap) throws Exception;
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	public PfssmtLecInfoModel selectOneLecture(Map<String, Object> paramMap) throws Exception;
	public void insertLec(Map<String, Object> paramMap);
	public void updateLec(Map<String, Object> paramMap);
	public void deleteLec(Map<String, Object> paramMap);
	public List<AdmpmtClassroomMgtModel> classroomNum();
	

}
