package kr.happyjob.study.pfssst.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.pfssst.dao.PfssstEnrollDao;
import kr.happyjob.study.pfssst.model.PfssstEnrollModel;

@Service
public class PfssstEnrollServiceImpl implements PfssstEnrollService {
	
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
	PfssstEnrollDao pfssstEnrollDao;
	
	/** 목록 조회 */
	public List<PfssstEnrollModel> listenroll(Map<String, Object> paramMap) throws Exception {
		
		List<PfssstEnrollModel> listenroll = pfssstEnrollDao.listenroll(paramMap);
		
		return listenroll;
	}	
	
    public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = pfssstEnrollDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
    
    public PfssstEnrollModel selectenroll(Map<String, Object> paramMap) throws Exception {
		
    	PfssstEnrollModel selectupload = pfssstEnrollDao.selectenroll(paramMap);
		
		return selectupload;
	}
    
  public List<PfssstEnrollModel> linoone(Map<String, Object> paramMap) throws Exception {
		
	  List<PfssstEnrollModel> one = pfssstEnrollDao.linoone(paramMap);
		
		return one;
	}
    
	public void insertenroll(Map<String, Object> paramMap) throws Exception {
		
		paramMap.put("fileyn", "N");
		pfssstEnrollDao.insertenroll(paramMap);
		
		return ;
	}
	
	public void updateenroll(Map<String, Object> paramMap) throws Exception {
		
		pfssstEnrollDao.updateenroll(paramMap);
		
		return ;
	}
	
	public void deleteenroll(Map<String, Object> paramMap) throws Exception {
		
		pfssstEnrollDao.deleteenroll(paramMap);
		
		return ;
	}
	
public void insertFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
	

   	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
		String logicalpath = virtualRootPath + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			pfssstEnrollDao.insertFileinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		pfssstEnrollDao.insertenroll(paramMap);
    	
    }
    
    public void updateFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
    	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
    	PfssstEnrollModel selectenroll = pfssstEnrollDao.selectenroll(paramMap);
    	    	
        String oldFilNm = selectenroll.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			pfssstEnrollDao.deleteFileinfobybdno(paramMap);
	    	File oldfile = new File(selectenroll.getAtt_mul());
	    	oldfile.delete();			
		}
    	
 
    	
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
		
		String logicalpath = virtualRootPath + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			pfssstEnrollDao.insertFileinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		
		pfssstEnrollDao.updateenroll(paramMap);
    	
    }
    
    public void deleteFileuploadatt(Map<String, Object> paramMap) throws Exception {
		
    	PfssstEnrollModel selectenroll = pfssstEnrollDao.selectenroll(paramMap);
    	
        String oldFilNm = selectenroll.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			pfssstEnrollDao.deleteFileinfobybdno(paramMap);
	    	File oldfile = new File(selectenroll.getAtt_mul());
	    	oldfile.delete();			
		}
    	
		pfssstEnrollDao.deleteenroll(paramMap);
		
		return ;
	}

	@Override
	public PfssstEnrollModel selectFileupload(Map<String, Object> paramMap) throws Exception {
		PfssstEnrollModel selectupload = pfssstEnrollDao.selectenroll2(paramMap);
		
		return selectupload;
	}

}
