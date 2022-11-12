package kr.happyjob.study.stdsst.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsst.dao.StdsstEnrollDao;
import kr.happyjob.study.stdsst.model.StdsstEnrollModel;

@Service
public class StdsstEnrollServiceImpl implements StdsstEnrollService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Autowired
	StdsstEnrollDao stdsstEnrollDao;
	
	/** 목록 조회 */
	public List<StdsstEnrollModel> listenroll(Map<String, Object> paramMap) throws Exception {
		
		List<StdsstEnrollModel> listenroll = stdsstEnrollDao.listenroll(paramMap);
		
		return listenroll;
	}	
	
    public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = stdsstEnrollDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
    
    public StdsstEnrollModel selectenroll(Map<String, Object> paramMap) throws Exception {
		
    	StdsstEnrollModel selectupload = stdsstEnrollDao.selectenroll(paramMap);
		
		return selectupload;
	}
    
	public void insertenroll(Map<String, Object> paramMap) throws Exception {
		
		stdsstEnrollDao.insertenroll(paramMap);
		
		return ;
	}
	
	public void updateenroll(Map<String, Object> paramMap) throws Exception {
		
		stdsstEnrollDao.updateenroll(paramMap);
		
		return ;
	}
	
	public void deleteenroll(Map<String, Object> paramMap) throws Exception {
		
		stdsstEnrollDao.deleteenroll(paramMap);
		
		return ;
	}

}
