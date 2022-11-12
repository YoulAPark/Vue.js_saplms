package kr.happyjob.study.stdsmt.controller;

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

import kr.happyjob.study.stdsmt.model.StdsmtCommentModel;
import kr.happyjob.study.stdsmt.model.StdsmtQnaModel;
import kr.happyjob.study.stdsmt.service.StdsmtQnaService;

@Controller
@RequestMapping("/commuD/")
public class StdsmtQnaController {
	
	@Autowired
	StdsmtQnaService stdsmtQnaService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("qna.do")
	public String Qna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qna");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".qna");
		
		return "stdsmt/Qna";
	}
	
	@RequestMapping("qnaList.do")
	public String QnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaList");
		logger.info("   - paramMap : " + paramMap);
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
		
		List<StdsmtQnaModel> qnaList = stdsmtQnaService.qnaList(paramMap);
		model.addAttribute("qnaList", qnaList);
		
		int searchlistcnt = stdsmtQnaService.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".qnaList");
		
		return "stdsmt/QnaList";
	}
	
	@RequestMapping("commentList.do")
	public String CommentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".commentList");
		logger.info("   - paramMap : " + paramMap);
		
		List<StdsmtCommentModel> commentList = stdsmtQnaService.getComment(paramMap);
		model.addAttribute("commentList", commentList);
		
		int searchlistcnt2 = stdsmtQnaService.searchlistcnt2(paramMap);
		model.addAttribute("searchlistcnt2", searchlistcnt2);
		
		logger.info("+ End " + className + ".commentList");
		
		return "stdsmt/CommentList";
	}
	
	@RequestMapping("uploadQna.do")
	@ResponseBody
	public Map<String, Object> Qnaupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Qnaupload");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			stdsmtQnaService.insertQna(paramMap);
		} else if("U".equals(action)) {
			stdsmtQnaService.updateQna(paramMap);
		} else if("D".equals(action)) {
			stdsmtQnaService.deleteQna(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".Qnaupload");

		return returnmap;
	}
	
	@RequestMapping("selectQna.do")
	@ResponseBody
	public Map<String, Object> selectQna(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, StdsmtQnaModel stdsmtQnaModel, StdsmtCommentModel stdsmtCommentModel, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".selectQna");
		logger.info("   - paramMap : " + paramMap);	
		
		StdsmtQnaModel qna = stdsmtQnaService.getQna(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("qna", qna);
		
		logger.info("+ End " + className + ".selectQna");
		
		return returnmap;
	}
	
	@RequestMapping("insertComment.do")
	@ResponseBody
	public Map<String, Object> insertComment(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".insertComment");
		logger.info("   - paramMap : " + paramMap);	
				
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("U".equals(action)) {
			stdsmtQnaService.insertComment(paramMap);
		} else if("D".equals(action)) {
			stdsmtQnaService.deleteComment(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".insertComment");
				
		return returnmap;
	}
	@RequestMapping("deleteComment.do")
	@ResponseBody
	public Map<String, Object> deleteComment(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".deleteComment");
		logger.info("   - paramMap : " + paramMap);	
				
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
				
		
		stdsmtQnaService.deleteComment(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".deleteComment");
				
		return returnmap;
	}
}
