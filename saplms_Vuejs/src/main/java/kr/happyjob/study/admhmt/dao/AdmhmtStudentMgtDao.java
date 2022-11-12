package kr.happyjob.study.admhmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admhmt.model.AdmhmtStudentMgtModel;

public interface AdmhmtStudentMgtDao {

	public List<AdmhmtStudentMgtModel> studentList(Map<String, Object> paramMap)throws Exception;

	public int studentListCnt(Map<String, Object> paramMap)throws Exception;
	
	public int studentRegist(Map<String, Object> paramMap)throws Exception;

	

}
