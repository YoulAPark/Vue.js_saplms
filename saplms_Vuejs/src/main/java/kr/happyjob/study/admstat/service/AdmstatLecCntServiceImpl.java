package kr.happyjob.study.admstat.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admstat.dao.AdmstatLecCntDao;
import kr.happyjob.study.admstat.model.AdmstatLecCntModel;

@Service
public class AdmstatLecCntServiceImpl implements AdmstatLecCntService {

	@Autowired
	AdmstatLecCntDao admstatLecCntDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/** 목록 조회 */
	public List<AdmstatLecCntModel> listLecCnt(Map<String, Object> paramMap) throws Exception {
		
		List<AdmstatLecCntModel> cntlist = admstatLecCntDao.listLecCnt(paramMap);
		
		return cntlist;
	}
	
    public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = admstatLecCntDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
    
    public AdmstatLecCntModel listLecCntchart(Map<String, Object> paramMap) throws Exception {
    	
    	AdmstatLecCntModel listLecCntchart = admstatLecCntDao.listLecCntchart(paramMap);
    	
    	return listLecCntchart;
    }
}
