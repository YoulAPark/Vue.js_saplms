package kr.happyjob.study.admpmt.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;

public interface AdmpmtClassroomMgtDao {

	public List<AdmpmtClassroomMgtModel> classroomList(Map<String, Object> paramMap) throws Exception;
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	public List<AdmpmtClassroomMgtModel> classEquipList(int li_no);
	public void insertClassroom(Map<String, Object> paramMap);
	public void updateClassroom(Map<String, Object> paramMap);
	public void deleteClassroom(Map<String, Object> paramMap);
	public void insertEquip(Map<String, Object> paramMap);
	public void updateEquip(Map<String, Object> paramMap);
	public void deleteEquip(Map<String, Object> paramMap);
	public AdmpmtClassroomMgtModel searchoneClassroom(Map<String, Object> paramMap);
	public AdmpmtClassroomMgtModel searchoneEquip(Map<String, Object> paramMap);

}
