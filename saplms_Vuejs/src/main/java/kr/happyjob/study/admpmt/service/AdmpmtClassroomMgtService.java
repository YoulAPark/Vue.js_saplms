package kr.happyjob.study.admpmt.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;

public interface AdmpmtClassroomMgtService {

	List<AdmpmtClassroomMgtModel> classroomList(Map<String, Object> paramMap) throws Exception;

	int searchlistcnt(Map<String, Object> paramMap) throws Exception;

	List<AdmpmtClassroomMgtModel> classEquipList(int li_no);

	void insertClassroom(Map<String, Object> paramMap);
	void updateClassroom(Map<String, Object> paramMap);
	void deleteClassroom(Map<String, Object> paramMap);

	void insertEquip(Map<String, Object> paramMap);
	void updateEquip(Map<String, Object> paramMap);
	void deleteEquip(Map<String, Object> paramMap);

	AdmpmtClassroomMgtModel searchoneClassroom(Map<String, Object> paramMap);

	AdmpmtClassroomMgtModel searchoneEquip(Map<String, Object> paramMap);

}
