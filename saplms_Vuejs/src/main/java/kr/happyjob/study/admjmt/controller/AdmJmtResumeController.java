package kr.happyjob.study.admjmt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admjmt.model.AdmJmtResumeOutputVo;
import kr.happyjob.study.admjmt.model.AdmJmtResumeVo;
import kr.happyjob.study.admjmt.service.AdmJmtResumeService;
import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.stdsmt.model.StdSmtLecListVo;

// /careerA/resume.do
@Controller
@RequestMapping("/careerA")
public class AdmJmtResumeController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmJmtResumeService admJmtResumeService;
	
	/* 초기 메뉴마스터 화면 설정 */
	@RequestMapping("/resume.do")
	public String Lecinfo(HttpServletRequest request, HttpServletResponse response)
				throws Exception {
		logger.info("초기화면시작");

			return "/admjmt/Resume";

	}
	
	// 이력서 과정명 목록조회 
	@RequestMapping("/resumeLmList.do")
	public String ResumeLmList(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpServletResponse response, HttpSession session)
				throws Exception {
			//과정명 목록조회 및 검색
			logger.info("paramMap :" + paramMap);
			
			
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
			int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
			
			//paramMap.put("", paramMap.get("se"))
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			
		  
			List<AdmJmtResumeVo> ResumeLmList = admJmtResumeService.ResumeLmList(paramMap);
			model.addAttribute("ResumeLmList",ResumeLmList);
			
			int ResumeLmListCnt = admJmtResumeService.ResumeLmListCnt(paramMap);
			model.addAttribute("ResumeLmListCnt",ResumeLmListCnt);
			
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("currentPageComnGrpCod",currentPage);
			
			return "/admjmt/ResumeLmList";
			
		}
	
	//이력서 과정명 수강자 목록조회
	@RequestMapping("/resumeUserList.do")
	public String resumeUserList(Model model, @RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		
		logger.info("수강자목록 :" + className + ".resumeUserList");
		logger.info("paramMap :" + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;// 페이지 시작 row 번호
		int li_no = Integer.parseInt((String)paramMap.get("li_no")); // 강의번호 셋팅
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		paramMap.put("li_no", li_no);
		
		//이력서 과정명 수강자 목록조회
		List<AdmJmtResumeVo> resumeUserList= admJmtResumeService.resumeUserList(paramMap);
		model.addAttribute("resumeUserList",resumeUserList);
		
		int UserListCnt = admJmtResumeService.resumeUserListCnt(paramMap);
		model.addAttribute("UserListCnt",UserListCnt);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnDtlCod",currentPage);
		model.addAttribute("li_no",li_no);
		
		//logger.info("resumeUserList" + resumeUserList.get(li_no));
		logger.info("+ End " + className + ".listComnDtlCod");
		
		
		return "/admjmt/ResumeUserList";
	}
	
	// 이력서창 모달 콜백함수
	@RequestMapping("/resumeOutput.do")
	@ResponseBody
	public Map<String, Object> selectResumeOutput(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectFileupload");
		logger.info("   - paramMap : " + paramMap);
		
		AdmJmtResumeOutputVo searchoner = admJmtResumeService.selectResumeOutput(paramMap);
		
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchoner", searchoner);
		
		//logger.info("searchoner :" + returnmap.get(searchoner));
		logger.info("+ End " + className + ".selectFileupload");

		return returnmap;
	}	
	
	
	

}
