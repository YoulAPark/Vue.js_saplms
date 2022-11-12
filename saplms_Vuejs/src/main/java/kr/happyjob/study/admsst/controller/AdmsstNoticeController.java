package kr.happyjob.study.admsst.controller;

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

import kr.happyjob.study.admsst.model.AdmsstNoticeModel;
import kr.happyjob.study.admsst.service.AdmsstNoticeService;


@Controller
@RequestMapping("/supportA/")
public class AdmsstNoticeController {
	
	@Autowired
	AdmsstNoticeService admsstNoticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("notice.do")
	public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".notice");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".notice");

		return "admsst/notice";
	}

	@RequestMapping("listNotice.do")
	public String listnotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		
		List<AdmsstNoticeModel> searchlist = admsstNoticeService.listNotice(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt = admsstNoticeService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listNotice");

		return "admsst/noticelist";
	}
		// 단건 조회
	@RequestMapping("selectNotice.do")
	@ResponseBody
	public Map<String, Object> selectNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectNotice");
		logger.info("   - paramMap : " + paramMap);			
		int bd_no=Integer.parseInt((String)paramMap.get("bd_no"));
		paramMap.put("bd_no", bd_no);
		AdmsstNoticeModel searchone = admsstNoticeService.selectNotice(paramMap);
		logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+searchone.getBd_cnt());
		logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+searchone.getBd_contents());
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		
		logger.info("+ End " + className + ".selectNotice");

		return returnmap;
	}	

	@RequestMapping("saveNotice.do")
	@ResponseBody
	public Map<String, Object> saveNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveNotice");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			admsstNoticeService.insertNotice(paramMap);
		} else if("U".equals(action)) {
			admsstNoticeService.updateNotice(paramMap);
		} else if("D".equals(action)) {
			admsstNoticeService.deleteNotice(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveNotice");

		return returnmap;
	}		
	
	
}  

