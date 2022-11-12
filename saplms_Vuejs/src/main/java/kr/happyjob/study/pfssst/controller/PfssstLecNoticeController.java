package kr.happyjob.study.pfssst.controller;

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

import kr.happyjob.study.pfssst.model.PfssstLecNoticeModel;
import kr.happyjob.study.pfssst.service.PfssstLecNoticeService;
import kr.happyjob.study.admpmt.model.ClassroomInfoModel;


@Controller
@RequestMapping("/supportD/")
public class PfssstLecNoticeController {
	
	@Autowired
	PfssstLecNoticeService pfssstLecNoticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	  
	/**
	 * 파일 업로드 샘플 초기화면
	 */
	@RequestMapping("lecNotice.do")
	public String lecNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecNotice");
		logger.info("   - paramMap : " + paramMap);
		
		List<ClassroomInfoModel> roominfolist = pfssstLecNoticeService.listroominfo(paramMap);
		
		model.addAttribute("roominfolist", roominfolist);
		
		logger.info("+ End " + className + ".lecNotice");

		
		
		return "pfssst/lecNotice";
	}

	@RequestMapping("listLecNotice.do")
	public String listLecNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listLecNotice");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<PfssstLecNoticeModel> searchlist = pfssstLecNoticeService.listLecNotice(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = pfssstLecNoticeService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listLecNotice");

		return "pfssst/lecNoticelist";
	}
		
	@RequestMapping("selectLecNotice.do")
	@ResponseBody
	public Map<String, Object> selectLecNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectLecNotice");
		logger.info("   - paramMap : " + paramMap);			
		
		PfssstLecNoticeModel searchone = pfssstLecNoticeService.selectLecNotice(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		logger.info("+ End " + className + ".selectLecNotice");

		return returnmap;
	}	

	@RequestMapping("saveLecNotice.do")
	@ResponseBody
	public Map<String, Object> saveLecNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveLecNotice");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			pfssstLecNoticeService.insertLecNotice(paramMap);
		} else if("U".equals(action)) {
			pfssstLecNoticeService.updateLecNotice(paramMap);
		} else if("D".equals(action)) {
			pfssstLecNoticeService.deleteLecNotice(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveLecNotice");

		return returnmap;
	}	
	
}  
