package kr.happyjob.study.stdsmt.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.stdsmt.model.StdsmtReportModel;
import kr.happyjob.study.stdsmt.service.StdsmtReportService;


@Controller
@RequestMapping("/manageC/")
public class StdsmtReportController {
	

	@Autowired
	StdsmtReportService stdsmtReportService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	

	// 처음 로딩때 과제제출 목록 출력
	@RequestMapping("report.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initreport");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
		
		
		paramMap.put("loginID", loginID);
	
		logger.info("   - loginID : " + loginID);
		
		List<StdsmtReportModel> myLecList = stdsmtReportService.myLecList(paramMap);
		
		model.addAttribute("leclist", myLecList);
		logger.info("   - loginID :" + myLecList);
		
		return "stdsmt/report";
	}


	// 과제목록 리스트 출력
	@RequestMapping("reportList.do")
	public String reportList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("   - paramMap : " + paramMap);
		String title = (String) paramMap.get("title");
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	    int pageIndex = (currentPage - 1) * pageSize;
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("title", title);
		
		// 공지사항 목록 조회
		List<StdsmtReportModel> stdsmtreportList = stdsmtReportService.stdsmtReportList(paramMap);
		model.addAttribute("report", stdsmtreportList);
		
		// 목록 수 추출해서 보내기
		int stdsmtreportCnt = stdsmtReportService.stdsmtReportCnt(paramMap);
		
	    model.addAttribute("reportCnt", stdsmtreportCnt);
	    model.addAttribute("pageSize", pageSize);
	    model.addAttribute("currentPage",currentPage);
	    
	    return "stdsmt/reportList";
	}
	

	// 과제 목록 단건조회
		@RequestMapping("selectreport.do")
		@ResponseBody
		public Map<String, Object> selectreport(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".selectReport");
			logger.info("   - paramMap : " + paramMap);
			
			
			StdsmtReportModel selectreport = stdsmtReportService.selectreport(paramMap);
		
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			returnmap.put("result", "SUCESS");
			returnmap.put("searchone", selectreport);
			
			logger.info("+ End " + className + ".selectreport");
		
			
			return returnmap;
		}	
		
	@RequestMapping("downloadfile.do")
	public void downloadfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".downloadfile");
		logger.info("   - paramMap : " + paramMap);			
		
		StdsmtReportModel searchone = stdsmtReportService.selectreport(paramMap);

		logger.info("   - searchone.getAtt_mul() : " + searchone.getAtt_mul());			
		
		
		
		//물리경로 조회해서 담기 
		String file = searchone.getAtt_mul();

		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(searchone.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		
	    return;
	}
	
	
		@RequestMapping("saveFileuploadatt.do")
		@ResponseBody
		public Map<String, Object> saveFileuploadatt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".saveFileuploadatt");
			logger.info("   - paramMap : " + paramMap);			
			
			paramMap.put("loginID",(String) session.getAttribute("loginId"));
			
			String action = String.valueOf(paramMap.get("action"));
			
			if("I".equals(action)) {
				stdsmtReportService.insertReportFileatt(paramMap,request);
			} else if("U".equals(action)) {
				stdsmtReportService.updateReportFileatt(paramMap,request);
			} else if("D".equals(action)) {
				stdsmtReportService.deleteReportFileatt(paramMap);
			}
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			returnmap.put("result", "SUCESS");
			
			logger.info("+ End " + className + ".saveFileuploadatt");

			return returnmap;
		}
		
		// 파일 내용 업데이트
		@RequestMapping("saveFileupload.do")
		@ResponseBody
		public Map<String, Object> saveFileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".saveFileupload");
			logger.info("   - paramMap : " + paramMap);			
			
			paramMap.put("loginID",(String) session.getAttribute("loginId"));
			
			String action = String.valueOf(paramMap.get("action"));
			
			if("U".equals(action)) {
				stdsmtReportService.updateStdsmtReport(paramMap);
			}
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			returnmap.put("result", "SUCESS");
			
			logger.info("+ End " + className + ".saveFileupload");

			return returnmap;
		}		
		
		
		
		// 강사 이름 변경
				@RequestMapping("changeproname.do")
				@ResponseBody
				public Map<String, Object> changeproname(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
						HttpServletResponse response, HttpSession session) throws Exception {
					
					logger.info("+ Start " + className + ".changeproname");
					logger.info("   - paramMap : " + paramMap);
					
					
					StdsmtReportModel changeproname = stdsmtReportService.changeproname(paramMap);
				
					
					Map<String, Object> returnmap = new HashMap<String, Object>();
					
					returnmap.put("result", "SUCESS");
					returnmap.put("searchone", changeproname);
					
					logger.info("+ End " + className + ".changeproname");
				
					
					return returnmap;
				}	
}



