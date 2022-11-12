package kr.happyjob.study.admhmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admhmt.dao.AdmhmtProfessorMgtDao;
import kr.happyjob.study.admhmt.model.AdmhmtProfessorMgtModel;

@Service("professorMgtService")
public class AdmhmtProfessorMgtServiceImpl implements AdmhmtProfessorMgtService {
	
	@Autowired
	private AdmhmtProfessorMgtDao professorMgtDao;
	
	@Override
	public List<AdmhmtProfessorMgtModel> professorList(Map<String, Object> paramMap) throws Exception {
		return professorMgtDao.professorList(paramMap);
	}
	
	@Override
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		return professorMgtDao.searchlistcnt(paramMap);
	}
	
	@Override
	public int registerProfessor(Map<String, Object> paramMap) throws Exception {
		int ret = professorMgtDao.registerProfessor(paramMap);
		return ret;
	}
}
