package kr.happyjob.study.admjmt.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admjmt.dao.AdmjmtJobInfoDao;
import kr.happyjob.study.admjmt.model.AdmjmtJoblnfoModel;
import kr.happyjob.study.admsst.model.AdmsstNoticeModel;

@Service
public class AdmjmtJoblnfoServiceImpl implements AdmjmtJoblnfoService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmjmtJobInfoDao admjmtJobInfoDao;

	/** 목록 조회 */
	public List<AdmjmtJoblnfoModel> listjobInfoMgt(Map<String, Object> paramMap) throws Exception {
		
		
		List<AdmjmtJoblnfoModel> listjobInfo = admjmtJobInfoDao.listjobInfoMgt(paramMap);	
		
		return listjobInfo;
	}
	
	   public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
			
			int searchlistcnt = admjmtJobInfoDao.searchlistcnt(paramMap);
			
			return searchlistcnt;
		}
	   
	   public AdmjmtJoblnfoModel selectJobinfo(Map<String, Object> paramMap) throws Exception {
			
		   AdmjmtJoblnfoModel selectupload = admjmtJobInfoDao.selectJobinfo(paramMap);
			
			return selectupload;
		}
	   
	   public void insertjobInfo(Map<String, Object> paramMap) throws Exception {
			
		   admjmtJobInfoDao.insertjobInfo(paramMap);
			
			return ;
		}

		
		public void updatejobInfo(Map<String, Object> paramMap) throws Exception {
			
			admjmtJobInfoDao.updatejobInfo(paramMap);
			
			return ;
		}

		
		public void deletejobInfo(Map<String, Object> paramMap) throws Exception {
			
			admjmtJobInfoDao.deletejobInfo(paramMap);
			
			return ;
		}

}


