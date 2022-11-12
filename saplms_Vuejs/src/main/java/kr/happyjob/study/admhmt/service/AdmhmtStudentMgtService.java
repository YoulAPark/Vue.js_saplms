package kr.happyjob.study.admhmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admhmt.model.AdmhmtStudentMgtModel;

public interface AdmhmtStudentMgtService {
	//학생목록조회
	public List<AdmhmtStudentMgtModel> studentList(Map<String, Object> paramMap)throws Exception;
	//학생수조회
	public int studentListCnt(Map<String, Object> paramMap)throws Exception;
	//학생 등록
	public int studentRegist(Map<String, Object> paramMap)throws Exception;


}
