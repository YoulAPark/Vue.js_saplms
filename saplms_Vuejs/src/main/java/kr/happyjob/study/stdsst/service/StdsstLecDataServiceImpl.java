package kr.happyjob.study.stdsst.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.stdsst.model.StdsstLecDataModel;
import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.stdsst.dao.StdsstLecDataDao;

@Service
public class StdsstLecDataServiceImpl implements StdsstLecDataService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StdsstLecDataDao stdsstLecDataDao;
    
	@Override
	public List<StdsstLecDataModel> listStdsstLecData(Map<String, Object> paramMap) throws Exception {
		List<StdsstLecDataModel> listStdsstLecData = stdsstLecDataDao.listStdsstLecData(paramMap);
		
		return listStdsstLecData;
	}
 
	@Override
	public int countListStdsstLecData(Map<String, Object> paramMap) throws Exception {
		int totalCount = stdsstLecDataDao.countListStdsstLecData(paramMap);
		
		return totalCount;
	}

	@Override
	public StdsstLecDataModel selectStdsstLecData(Map<String, Object> paramMap) throws Exception {
		StdsstLecDataModel StdsstLecDataModel = stdsstLecDataDao.selectStdsstLecData(paramMap);
		return StdsstLecDataModel;
	}

	@Override
	public StdsstLecDataModel selectFileupload(Map<String, Object> paramMap) throws Exception {
		StdsstLecDataModel selectupload = stdsstLecDataDao.selectFileupload(paramMap);
		
		return selectupload;
	}
	
}
