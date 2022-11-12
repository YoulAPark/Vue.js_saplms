package kr.happyjob.study.stdsst.controller;

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

import kr.happyjob.study.login.service.LoginService;
import kr.happyjob.study.stdsst.model.StdsstNoticeModel;
import kr.happyjob.study.stdsst.service.StdsstNoticeService;
import kr.happyjob.study.system.model.NoticeModel;




@Controller
@RequestMapping("/supportC/")
public class StdsstNoticeController {
	
	@Autowired
	   StdsstNoticeService noticeService;
	
	 // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	
	 @RequestMapping("notice.do")
	   public String stdNoticePage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      logger.info("+ Start " + className + ".initComnCod");
	     
	      
	      logger.info("+ End " + className + ".initComnCod");

	      return "stdsst/notice";
	   }
	 
	 //리스트 출력
	 @RequestMapping("noticeList.do")
	   public String stdNoticeList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      logger.info("+ Start " + className + ".initComnCod");
	      String title = (String) paramMap.get("title");
	      String content = (String) paramMap.get("content");
			
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("title", title);
			paramMap.put("content", content);
			
			// 공지사항 목록 조회
			List<StdsstNoticeModel> noticeList = noticeService.getNoticeList(paramMap);
			model.addAttribute("notice", noticeList);
			
			// 목록 수 추출해서 보내기
			int noticeCnt = noticeService.getNoticeCnt(paramMap);
			
		    model.addAttribute("noticeCnt", noticeCnt);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    
		   
	      	
	      logger.info("+ End " + className + ".initComnCod");

	      return "stdsst/noticeList";
	   }

	 
	 @RequestMapping("detailNotice.do")
	 @ResponseBody
	 public Map<String, Object> thisNoticeDetail( @RequestParam Map<String, Object> paramMap)throws Exception{
		 logger.info("+ Start " + className + ".initComnCod");
		 String result="";
			
			// 선택된 게시판 1건 조회 
		 StdsstNoticeModel detailNotice = noticeService.noticeDetail(paramMap);
		 	//게시판 조회시 조회수 1 증가
		 noticeService.updateCnt(paramMap);
		 
			if(detailNotice != null) {
				result = "SUCCESS";  // 성공시 찍습니다. 
			}else {
				result = "FAIL / 불러오기에 실패했습니다.";  // null이면 실패입니다.
			}
			System.out.println("결과>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+result);
			System.out.println("결과 내용>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+detailNotice.getBd_contents());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("resultMsg", result); // success 용어 담기 
			resultMap.put("result", detailNotice); // 리턴 값 해쉬에 담기 
			//resultMap.put("resultComments", comments);
		
			
		 logger.info("+ End " + className + ".initComnCod");
		 return resultMap;
	 }
	 
	 
}
