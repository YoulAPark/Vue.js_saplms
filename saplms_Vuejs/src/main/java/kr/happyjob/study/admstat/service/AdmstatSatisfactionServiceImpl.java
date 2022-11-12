package kr.happyjob.study.admstat.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admsmt.model.AdmsmtLecListMgtModel;
import kr.happyjob.study.admsmt.service.AdmsmtLecListMgtService;
import kr.happyjob.study.admstat.dao.AdmstatSatisfactionDao;
import kr.happyjob.study.admstat.model.AdmstatSatisfactionModel;
import kr.happyjob.study.stdsst.model.StdsstLecDataModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import kr.happyjob.study.admsmt.dao.AdmsmtLecListMgtDao;

@Service
public class AdmstatSatisfactionServiceImpl implements AdmstatSatisfactionService {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	 
	@Autowired
	AdmstatSatisfactionDao admstatSatisfactionDao;

	
	
	
	
	/** 강의 목록 조회 */
	@Override
	public List<AdmstatSatisfactionModel> listSatisfactionList(Map<String, Object> paramMap) {
		List<AdmstatSatisfactionModel> admstatSatisfactionModel = admstatSatisfactionDao.listSatisfactionList(paramMap);
		
		return admstatSatisfactionModel;
	}

	/** 강의 카운트 조회 */
	@Override
	public int countSatisfactionList(Map<String, Object> paramMap) {
		int totalCntSatisfactopnList = admstatSatisfactionDao.countSatisfactionList(paramMap);
		
		return totalCntSatisfactopnList;
	}

	
	
//	차트
	@Override
	public List<Map<String, Object>> selectSatisfactionList() {
		List<Map<String,Object>> list = this.selectSatisfactionList();
		
		
		
		return list;
	}
	


	
	
	
	
	

	
}
