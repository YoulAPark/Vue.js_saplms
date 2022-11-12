package kr.happyjob.study.admhmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admhmt.model.AdmhmtProfessorMgtModel;

public interface AdmhmtProfessorMgtDao {
	
	public List<AdmhmtProfessorMgtModel> professorList(Map<String, Object> paramMap);
	
	public int searchlistcnt(Map<String, Object> paramMap);
			
	public int registerProfessor(Map<String, Object> paramMap);
}
