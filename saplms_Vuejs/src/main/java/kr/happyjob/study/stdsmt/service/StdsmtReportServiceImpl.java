package kr.happyjob.study.stdsmt.service;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.stdsmt.dao.StdsmtReportDao;
import kr.happyjob.study.stdsmt.model.StdsmtReportModel;

@Service
public class StdsmtReportServiceImpl implements StdsmtReportService {


	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.reportPath}")
	private String reportPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	
	@Autowired
	StdsmtReportDao stdsmtReportDao;

	@Override
	public List<StdsmtReportModel> stdsmtReportList(Map<String, Object> paramMap) throws Exception{

		List<StdsmtReportModel> stdsmtReportList = stdsmtReportDao.stdsmtReportList(paramMap);
		return stdsmtReportList;
	}


	@Override
	public List<StdsmtReportModel> myLecList(Map<String, Object> paramMap) throws Exception {
			
	    	List<StdsmtReportModel> myLecList = stdsmtReportDao.myLecList(paramMap);	
	    	
	    	
			return myLecList;
		}
	
	
	@Override
	public int stdsmtReportCnt(Map<String, Object> paramMap) throws Exception {
		int stdsmtReportCnt = stdsmtReportDao.stdsmtReportCnt(paramMap);
		return stdsmtReportCnt;
	}

	// 과제목록 단건조회
	@Override
    public StdsmtReportModel selectreport(Map<String, Object> paramMap) throws Exception {
				
    	StdsmtReportModel selectreport = stdsmtReportDao.selectreport(paramMap);	
    	
		return selectreport;
	}
			
    
    public void insertReportFileatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
    	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
    	// 파일중복 방지 난수생성
    	UUID rannm = UUID.randomUUID(); // UUID 메서드 사용 난수생성     -- 필요없음 
    	String ranname = rannm.toString().substring(0,4); // UUID 문자열 5자리만 자르기   -- 필요없음 
    	
		//파일저장
    	String FileData = File.separator + ranname;
    	
    	Iterator<String> files = multipartHttpServletRequest.getFileNames();
   	
    	System.out.println("multipartHttpServletRequest @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + multipartHttpServletRequest);
    	
    	String itemFilePath = reportPath + File.separator ; // 업로드 실제 경로 조립 (문자열생성)
		
    	/*String filPthNm = FileUtilCho.getPscFilNm(itemFilePath);*/
    	
    	FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath );
		
    	System.out.println("filPthNm @@@@@@@@@@@@@@@@@@@" +itemFilePath);
    	System.out.println("itemFilePath @@@@@@@@@@@@@@@@@@@" +itemFilePath);
		System.out.println("fileUtil @@@@@@@@@@@@@@@@@@@" +fileUtil);
		
		
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		/*ranname = ranname + fileInfo.get("file_loc") ;
		fileInfo.put("file_loc", ranname);*/
		
		System.out.println("report_fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo.get("file_nm"));
        
		String logicalpath = virtualRootPath + File.separator + reportPath + File.separator + fileInfo.get("file_nm");
		
		
		System.out.println("logicalpath @@@@@@@@@@@@@@@@@@@" +logicalpath);
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		System.out.println("FilNm @@@@@@@@@@@@@@@@@@@" +FilNm);
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			stdsmtReportDao.insertReportinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		/*paramMap.put("filepro", "Y");*/ 
		
		stdsmtReportDao.insertReportFileatt(paramMap);
    	
    }
    
	public void updateStdsmtReport(Map<String, Object> paramMap) throws Exception {
		
		stdsmtReportDao.updateStdsmtReport(paramMap);
		
		return ;
	}
    
    public void updateReportFileatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
    	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
    	StdsmtReportModel selectupload = stdsmtReportDao.selectreport(paramMap);
    	    	
        String oldFilNm = selectupload.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			stdsmtReportDao.deleteReportinfobyasnno(paramMap);
	    	File oldfile = new File(selectupload.getAtt_mul());
	    	oldfile.delete();			
		}
    	
 
    	
		//파일저장
		String itemFilePath = reportPath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
        //map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
        //map.put("loc_file_loc", fileExtension);
		
		String logicalpath = virtualRootPath + File.separator + reportPath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			stdsmtReportDao.insertReportinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		paramMap.put("filepro", "Y");
		
		stdsmtReportDao.updateReportFileatt(paramMap);
    	
    }
    
    public void deleteReportFileatt(Map<String, Object> paramMap) throws Exception {
		
    	StdsmtReportModel selectupload = stdsmtReportDao.selectreport(paramMap);
    	
        String oldFilNm = selectupload.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			stdsmtReportDao.deleteReportinfobyasnno(paramMap);
	    	File oldfile = new File(selectupload.getAtt_mul());
	    	oldfile.delete();			
		}
    	
		stdsmtReportDao.deleteReportFileatt(paramMap);
		
		return ;
	}
    
	
 
    
    @Override
    public StdsmtReportModel changeproname(Map<String, Object> paramMap) throws Exception {
				
    	StdsmtReportModel changeproname = stdsmtReportDao.changeproname(paramMap);	
    	
    	
		return changeproname;
	}


}
