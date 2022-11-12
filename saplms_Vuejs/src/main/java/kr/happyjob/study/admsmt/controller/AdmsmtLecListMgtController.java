package kr.happyjob.study.admsmt.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.admsmt.model.AdmsmtLecListMgtModel;
import kr.happyjob.study.admsmt.service.AdmsmtLecListMgtService;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.service.ComnCodService;

@Controller
@RequestMapping("/manageA/")
public class AdmsmtLecListMgtController {
	 
	@Autowired
	AdmsmtLecListMgtService admsmtLecListMgtService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 초기화면
	 */
	@RequestMapping("lecListMgt.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		return "admsmt/lecListMgt";
	}
	
	
	
//	  강의 목록 조회

	@RequestMapping("listLecList.do")
	public String listComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listComnDtlCod");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 상세코드 목록 조회
		List<AdmsmtLecListMgtModel> admsmtLecListMgtModel = admsmtLecListMgtService.listAdmsmtLecList(paramMap);
		model.addAttribute("admsmtLecListMgtModel", admsmtLecListMgtModel);
		
		// 공통 상세코드 목록 카운트 조회
		int totalCount = admsmtLecListMgtService.countListAdmsmtLecList(paramMap);
		model.addAttribute("totalCntAdmsmtLecList", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnDtlCod",currentPage);
		
		logger.info("+ End " + className + ".listComnDtlCod");

		return "/admsmt/lecListMgtList";
	}	

	
	
	/**
	 * 수강인원 목록 조회
	 */
	@RequestMapping("listLecPersonList.do")
	public String listComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listComnGrpCod");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<AdmsmtLecListMgtModel> admsmtLecPersonListMgtModel = admsmtLecListMgtService.listAdmsmtLecPersonList(paramMap);
		model.addAttribute("admsmtLecPersonListMgtModel", admsmtLecPersonListMgtModel);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = admsmtLecListMgtService.countListAdmsmtLecPersonList(paramMap);
		model.addAttribute("totalCntAdmsmtLecPersonList", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageAdmsmtLecList",currentPage);
		
		logger.info("+ End " + className + ".listComnGrpCod");
		

		return "/admsmt/lecListMgtPersonList";
	}	


	


	/*학생 단건 조회*/
	
	@RequestMapping("selectLecPersonList.do")
	@ResponseBody
	public Map<String, Object> selectComnDtlCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("   - paramMap : " + paramMap);
		
	
	
		// 공통 상세 코드 단건 조회
		
		AdmsmtLecListMgtModel selectAdmsmtLecPersonList = admsmtLecListMgtService.selectAdmsmtLecPersonList(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.print("값=:"+(String)selectAdmsmtLecPersonList.getLoginID());
		resultMap.put("selectAdmsmtLecPersonList", selectAdmsmtLecPersonList);
		
		return resultMap;
	}
	
	

	/*휴학 업데이트*/
	
	@RequestMapping("updateSb_yn.do")
	@ResponseBody
	public void updateSb_yn (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("   - paramMap : " + paramMap);
		
		
		int li_no = Integer.parseInt(String.valueOf(paramMap.get("li_no")));
	      
	      paramMap.put("li_no", li_no);

	      admsmtLecListMgtService.updateSb_yn(paramMap);
			
		
	      String msg ="성공.";
			
	   	  PrintWriter w = response.getWriter();
		  w.write("<script>alert('"+msg+"');history.go(-1);</script>");
	      w.flush();
	      w.close();
		
		
		return; 
	
	}
	
	

}
