package kr.happyjob.study.admpmt.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admpmt.dao.AdmpmtClassroomMgtDao;
import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;

@Service
public class AdmpmtClassroomMgtServiceImpl implements AdmpmtClassroomMgtService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	AdmpmtClassroomMgtDao dao;
	
	
	public List<AdmpmtClassroomMgtModel> classroomList(Map<String, Object> paramMap) throws Exception{
	
		logger.info("+ Start Service " + className + ".classroomList");
		logger.info("   - paramMap : " + paramMap);
		
		List<AdmpmtClassroomMgtModel> classroomList = dao.classroomList(paramMap);
		
		logger.info("+ End Service " + className + ".classroomList");
		
		return classroomList;
	};

	public int searchlistcnt(Map<String, Object> paramMap) throws Exception{
		
		logger.info("+ Start Service " + className + ".searchlistcnt");
		
		int searchlistcnt = dao.searchlistcnt(paramMap);
		
		logger.info("+ End Service " + className + ".searchlistcnt");
		
		return searchlistcnt;
	};
	
	public List<AdmpmtClassroomMgtModel> classEquipList(int li_no){
		
		List<AdmpmtClassroomMgtModel> classEquipList = dao.classEquipList(li_no);
		
		return classEquipList;
	};
	
	public void insertClassroom(Map<String, Object> paramMap){
		dao.insertClassroom(paramMap);
	};
	public void updateClassroom(Map<String, Object> paramMap){
		dao.updateClassroom(paramMap);
	};
	public void deleteClassroom(Map<String, Object> paramMap){
		dao.deleteClassroom(paramMap);
	};
	
	public void insertEquip(Map<String, Object> paramMap){
		dao.insertEquip(paramMap);
	};
	public void updateEquip(Map<String, Object> paramMap){
		dao.updateEquip(paramMap);
	};
	public void deleteEquip(Map<String, Object> paramMap){
		dao.deleteEquip(paramMap);
	};
	
	public AdmpmtClassroomMgtModel searchoneClassroom(Map<String, Object> paramMap){
		AdmpmtClassroomMgtModel result = dao.searchoneClassroom(paramMap);
		return result;
	};
	
	public AdmpmtClassroomMgtModel searchoneEquip(Map<String, Object> paramMap){
		AdmpmtClassroomMgtModel result = dao.searchoneEquip(paramMap);
		return result;
	};
}
