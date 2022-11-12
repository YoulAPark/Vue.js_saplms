package kr.happyjob.study.pfssst.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admpmt.model.ClassroomInfoModel;
import kr.happyjob.study.pfssst.dao.PfssstLecNoticeDao;
import kr.happyjob.study.pfssst.model.PfssstLecNoticeModel;

@Service
public class PfssstLecNoticeServiceImpl implements PfssstLecNoticeService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PfssstLecNoticeDao pfssstLecNoticeDao;
	
	/** 목록 조회 */
	public List<PfssstLecNoticeModel> listLecNotice(Map<String, Object> paramMap) throws Exception {
		
		List<PfssstLecNoticeModel> listNotice = pfssstLecNoticeDao.listLecNotice(paramMap);
		
		return listNotice;
	}
	
    public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = pfssstLecNoticeDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
    
    public PfssstLecNoticeModel selectLecNotice(Map<String, Object> paramMap) throws Exception {
		
    	PfssstLecNoticeModel selectNotice = pfssstLecNoticeDao.selectLecNotice(paramMap);
		
		return selectNotice;
	}
    
    public void insertLecNotice(Map<String, Object> paramMap) throws Exception {
		
//    	.put("key", "value"); key 값은 중복되면 안된다고 합니다.
    	paramMap.put("fileyn", "N");
    	paramMap.put("filepro", "N");
    	pfssstLecNoticeDao.insertLecNotice(paramMap);
		
		return ;
	}
    
    public void updateLecNotice(Map<String, Object> paramMap) throws Exception {
		
    	pfssstLecNoticeDao.updateLecNotice(paramMap);
		
		return ;
	}
    
    public void deleteLecNotice(Map<String, Object> paramMap) throws Exception {
		
    	pfssstLecNoticeDao.deleteLecNotice(paramMap);
		
		return ;
	}
    
    
    public List<ClassroomInfoModel> listroominfo(Map<String, Object> paramMap) throws Exception {
    	
    	return pfssstLecNoticeDao.listroominfo(paramMap);
    } 
    
}
