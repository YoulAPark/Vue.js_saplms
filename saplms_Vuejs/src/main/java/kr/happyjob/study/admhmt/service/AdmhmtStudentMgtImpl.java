package kr.happyjob.study.admhmt.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admhmt.dao.AdmhmtStudentMgtDao;
import kr.happyjob.study.admhmt.model.AdmhmtStudentMgtModel;

@Service
public class AdmhmtStudentMgtImpl implements AdmhmtStudentMgtService  {

	@Autowired
	AdmhmtStudentMgtDao admhmtStudentMgtDao;
	@Override
	public List<AdmhmtStudentMgtModel> studentList(Map<String, Object> paramMap) throws Exception {
		List<AdmhmtStudentMgtModel> studentList = admhmtStudentMgtDao.studentList(paramMap);
		return studentList;
	}

	@Override
	public int studentListCnt(Map<String, Object> paramMap) throws Exception {
		int studentListCnt = admhmtStudentMgtDao.studentListCnt(paramMap);
		return studentListCnt;
	}
	
	@Override
	public int studentRegist(Map<String, Object> paramMap) throws Exception {
		int studentRegist =  admhmtStudentMgtDao.studentRegist(paramMap);
		return studentRegist;
	}

}
