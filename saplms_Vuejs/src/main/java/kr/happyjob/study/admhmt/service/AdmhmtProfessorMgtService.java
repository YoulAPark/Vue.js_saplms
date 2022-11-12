package kr.happyjob.study.admhmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admhmt.model.AdmhmtProfessorMgtModel;

public interface AdmhmtProfessorMgtService {
	
	public List<AdmhmtProfessorMgtModel> professorList(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
		
	public int registerProfessor(Map<String, Object> paramMap) throws Exception;
}
