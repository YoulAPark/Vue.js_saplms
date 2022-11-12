package kr.happyjob.study.pfssmt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admpmt.model.AdmpmtClassroomMgtModel;
import kr.happyjob.study.pfssmt.dao.PfssmtLecInfoDao;
import kr.happyjob.study.pfssmt.model.PfssmtLecInfoModel;

@Service
public class PfssmtLecInfoServiceImpl implements PfssmtLecInfoService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PfssmtLecInfoDao dao;
	
	public List<PfssmtLecInfoModel> lecturelist(Map<String, Object> paramMap){
		
		List<PfssmtLecInfoModel> lecturelist = dao.lecturelist(paramMap);
				
		return lecturelist;
	};
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception{
			
		int searchlistcnt = dao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
	
	public PfssmtLecInfoModel selectOneLecture(Map<String, Object> paramMap) throws Exception{
		
		PfssmtLecInfoModel result = dao.selectOneLecture(paramMap); 
		
		return result;
	}
	
	public void insertLec(Map<String, Object> paramMap){
		dao.insertLec(paramMap);
	};
	
	
	public void updateLec(Map<String, Object> paramMap){
		dao.updateLec(paramMap);
	};
	
	
	public void deleteLec(Map<String, Object> paramMap){
		dao.deleteLec(paramMap);
	};
	
	public List<AdmpmtClassroomMgtModel> classroomNum(){
		return dao.classroomNum();
	};
}
