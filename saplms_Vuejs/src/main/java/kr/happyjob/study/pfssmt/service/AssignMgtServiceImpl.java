package kr.happyjob.study.pfssmt.service;

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

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.pfssmt.dao.AssignMgtDao;
import kr.happyjob.study.pfssmt.model.AssignMgtModel;;

@Service
public class AssignMgtServiceImpl implements AssignMgtService {

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
	AssignMgtDao assignMgtDao;
	
	/** 목록 조회 */
	public List<AssignMgtModel> listAssignMgt(Map<String, Object> paramMap) throws Exception {
		
		List<AssignMgtModel> listupload = assignMgtDao.listAssignMgt(paramMap);
		
		return listupload;
	}
	
    public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		
		int searchlistcnt = assignMgtDao.searchlistcnt(paramMap);
		
		return searchlistcnt;
	}
    
    public AssignMgtModel selectAssignMgt(Map<String, Object> paramMap) throws Exception {
		
		AssignMgtModel selectupload = assignMgtDao.selectAssignMgt(paramMap);
		
		return selectupload;
	}
    
    public void insertFileupload(Map<String, Object> paramMap) throws Exception {
		
    	paramMap.put("fileyn", "N");
    	paramMap.put("filepro", "N");
		assignMgtDao.insertFileupload(paramMap);
		
		return ;
	}
    
    public void updateFileupload(Map<String, Object> paramMap) throws Exception {
		
		assignMgtDao.updateFileupload(paramMap);
		
		return ;
	}
    
    public void deleteFileupload(Map<String, Object> paramMap) throws Exception {
		
		assignMgtDao.deleteFileupload(paramMap);
		
		return ;
	}
    
    
    public void insertFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
    	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
        //map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
        //map.put("loc_file_loc", fileExtension);
		
		String logicalpath = virtualRootPath + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			assignMgtDao.insertFileinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		paramMap.put("filepro", "Y");
		
		assignMgtDao.insertFileupload(paramMap);
    	
    }
    
    public void updateFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
    	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
    	AssignMgtModel selectupload = assignMgtDao.selectAssignMgt(paramMap);
    	    	
        String oldFilNm = selectupload.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			assignMgtDao.deleteFileinfobybdno(paramMap);
	    	File oldfile = new File(selectupload.getAtt_mul());
	    	oldfile.delete();			
		}
    	
 
    	
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
        //map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
        //map.put("loc_file_loc", fileExtension);
		
		String logicalpath = virtualRootPath + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			assignMgtDao.insertFileinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		paramMap.put("filepro", "Y");
		
		assignMgtDao.updateFileupload(paramMap);
    	
    }
    
    public void deleteFileuploadatt(Map<String, Object> paramMap) throws Exception {
		
    	AssignMgtModel selectupload = assignMgtDao.selectAssignMgt(paramMap);
    	
        String oldFilNm = selectupload.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			assignMgtDao.deleteFileinfobybdno(paramMap);
	    	File oldfile = new File(selectupload.getAtt_mul());
	    	oldfile.delete();			
		}
    	
		assignMgtDao.deleteFileupload(paramMap);
		
		return ;
	}
    
    
}
