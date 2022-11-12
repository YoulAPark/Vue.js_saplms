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

import kr.happyjob.study.admjmt.model.AdmjmtJoblnfoModel;
import kr.happyjob.study.admjmt.service.AdmjmtJoblnfoService;
import kr.happyjob.study.admsst.model.AdmsstNoticeModel;

@Controller
@RequestMapping("/careerA/")
public class AdmjmtJoblnfoController {
	
	@Autowired
	AdmjmtJoblnfoService admjmtJoblnfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		  
	/**
	 * 파일 업로드 샘플 초기화면
	 */
	@RequestMapping("jobInfoMgt.do")
	public String jobInfoMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".jobInfoMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".jobInfoMgt");

		return "admjmt/joblnfo";
	}
	
	@RequestMapping("listjobInfoMgt.do")
	public String listjobInfoMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listjobInfoMgt");
		logger.info("   - paramMap : " + paramMap);			
		logger.info("   - paramMap :~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ");
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<AdmjmtJoblnfoModel> listjobInfo = admjmtJoblnfoService.listjobInfoMgt(paramMap);		
		model.addAttribute("listjobInfo", listjobInfo);
		
		int searchlistcnt = admjmtJoblnfoService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listFileupload");

		return "admjmt/joblnfolist";
	}
	
	// 단건 조회
	@RequestMapping("selectJobinfo.do")
	@ResponseBody
	public Map<String, Object> selectJobinfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectJobinfo");
		logger.info("   - paramMap : " + paramMap);			
		int em_no=Integer.parseInt((String)paramMap.get("em_no"));
		paramMap.put("em_no", em_no);
		AdmjmtJoblnfoModel searchone = admjmtJoblnfoService.selectJobinfo(paramMap);
/*		logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+searchone.getBd_cnt());
		logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+searchone.getBd_contents());*/
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		
		logger.info("+ End " + className + ".selectJobinfo");

		return returnmap;
	}	
	
	@RequestMapping("savejobInfo.do")
	@ResponseBody
	public Map<String, Object> saveNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".savejobInfo");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			admjmtJoblnfoService.insertjobInfo(paramMap);
		} else if("U".equals(action)) {
			admjmtJoblnfoService.updatejobInfo(paramMap);
		} else if("D".equals(action)) {
			admjmtJoblnfoService.deletejobInfo(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".savejobInfo");

		return returnmap;
	}		

}
