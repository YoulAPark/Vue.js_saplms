package kr.happyjob.study.pfssmt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.pfssmt.model.AssignMgtModel;

public interface AssignMgtService {

	/**  목록 조회 */
	public List<AssignMgtModel> listAssignMgt(Map<String, Object> paramMap) throws Exception;
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	public AssignMgtModel selectAssignMgt(Map<String, Object> paramMap) throws Exception;
	
	public void insertFileupload(Map<String, Object> paramMap) throws Exception;
	public void updateFileupload(Map<String, Object> paramMap) throws Exception;
	public void deleteFileupload(Map<String, Object> paramMap) throws Exception;
	
	public void insertFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	public void updateFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	public void deleteFileuploadatt(Map<String, Object> paramMap) throws Exception;
}
