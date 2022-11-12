package kr.happyjob.study.admsmt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admsmt.model.AdmsmtExamMgtModel;
import kr.happyjob.study.admsmt.service.AdmsmtExamMgtService;
import kr.happyjob.study.stdsst.model.StdsstNoticeModel;
import kr.happyjob.study.stdsst.service.StdsstNoticeService;

@Controller
@RequestMapping("/manageA/")
public class AdmsmtExamMgtController {
	
	@Autowired
	AdmsmtExamMgtService examService;
	
	// Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	
	
	  
	//관리자 시험문제 관리 페이지 매핑
	@RequestMapping("examMgt.do")
	public String examManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session)throws Exception {
		logger.info("+ Start " + className + ".initComnCod");
		
		
		logger.info("+ End " + className + ".initComnCod");
		
		return "admsmt/examMgt";
	}
	
	
	//시험지 목록 출력
	@RequestMapping("testList.do")
	public String getLecList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception{
		logger.info("+ Start " + className + ".initComnCod");
	      String testName = (String) paramMap.get("search");

			int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		    int pageIndex = (currentPage - 1) * pageSize;
			
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			paramMap.put("testName", testName);
		
			
			// 강의 목록 조회
			List<AdmsmtExamMgtModel> testList = examService.getExamList(paramMap);
			model.addAttribute("testList", testList);
			
			// 목록 수 추출해서 보내기
			int examCnt = examService.getTotalExam(paramMap);
			logger.info("총 시험지 목록수 " + examCnt );
			
		    model.addAttribute("examCnt", examCnt);
		    model.addAttribute("pageSize", pageSize);
		    model.addAttribute("currentPage",currentPage);
		    
		   
	      	
	      logger.info("+ End " + className + ".initComnCod");

	      return "admsmt/examMgtList";
		
	}
	
	
	
		
			
		// 시험지 등록	
		@RequestMapping("insertTest.do")
		public String testInsertGoGo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		HttpServletResponse response, HttpSession session) throws Exception{
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("시험지 등록 컨트롤러 도착했다");
				
				//sql 타입이 맞게 int로 바꿔줌
				int testNo=Integer.parseInt((String)paramMap.get("testNo"));
			
				//바꿔준걸 넣어줌
				paramMap.put("testNo",testNo );
			
				//등록시작
				examService.testInsert(paramMap);
		
						
				logger.info("+ End " + className + ".initComnCod");
			return "admsmt/examMgtList3";
					
			}		
		
		

			// 시험지 수정	
			@RequestMapping("updateTest.do")
			public String testUpdateGoGo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			logger.info("+ Start " + className + ".initComnCod");
			logger.info("시험지 수정 컨트롤러 도착했다");
					
					//sql 타입이 맞게 int로 바꿔줌
					int testNo=Integer.parseInt((String)paramMap.get("testNo"));
				
					//바꿔준걸 넣어줌
					paramMap.put("testNo",testNo );
				
					//등록시작
					examService.testUpdate(paramMap);
			
							
					logger.info("+ End " + className + ".initComnCod");
				return "admsmt/examMgtList3";
						
				}		
			
	
			//시험지의 문제들 출력
			@RequestMapping("examQuestionList.do")
			public String getExamDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception{
				logger.info("+ Start " + className + ".initComnCod");
				String testNo=(String) paramMap.get("examNo");
				System.out.println("컨트롤러로 들어온 시험지 번호>>"+testNo);
				// 선택된 시험지 문제 목록
				List<AdmsmtExamMgtModel> questionList = examService.questionDetailList(paramMap);
				int questionCnt=questionList.size();
		 
				if(questionList != null) {
					System.out.println("성공결과 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");  // 성공시 찍습니다. 
				}else {
				
					System.out.println("실패결과 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"); 
				}
		
				System.out.println("문제수 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+questionCnt+"개"); 
				model.addAttribute("testNo", testNo);
				model.addAttribute("questionCnt", questionCnt);
				model.addAttribute("questionList", questionList);
			
			 logger.info("+ End " + className + ".initComnCod");
			
		
			 return "admsmt/examMgtList2";
		}
	
	

		
		//시험지의 문제수정
		@RequestMapping("questionUpdate.do")
		public String updateGoGo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception{
			 logger.info("+ Start " + className + ".initComnCod");
			
				 examService.questionUpdate(paramMap);
				
				
			 logger.info("+ End " + className + ".initComnCod");
			return "admsmt/examMgtList3";
			
		}
	

		//시험지의 문제삭제
		@RequestMapping("questionDeleteGo.do")
		public String deleteGoGo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception{
			logger.info("+ Start " + className + ".initComnCod");
			logger.info("문제 삭제 컨트롤러 도착했다");
			examService.questionDelete(paramMap);
	
					
			logger.info("+ End " + className + ".initComnCod");
		return "admsmt/examMgtList3";
				
		}	
			
		
		
		// 문제등록	
		@RequestMapping("questionInsert.do")
		public String insertGoGo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
			logger.info("+ Start " + className + ".initComnCod");
			logger.info("문제 등록 컨트롤러 도착했다");
			
			//sql 타입이 맞게 int로 바꿔줌
			int examNo=Integer.parseInt((String)paramMap.get("examNo"));
			int questionNo=Integer.parseInt((String)paramMap.get("questionNo"));
			int score=Integer.parseInt((String)paramMap.get("score"));
			//바꿔준걸 넣어줌
			paramMap.put("examNo",examNo );
			paramMap.put("questionNo",questionNo );
			paramMap.put("score", score);
			//등록시작
			examService.questionInsert(paramMap);
	
					
			logger.info("+ End " + className + ".initComnCod");
		return "admsmt/examMgtList3";
				
		}	
			
	//시험지 삭제
	 @RequestMapping("testDelete.do")
	 public String deleteTest( @RequestParam Map<String, Object> paramMap, Model model)throws Exception{
		 logger.info("+ Start " + className + ".initComnCod");
		 
		System.out.println("시험지 삭제 컨트롤러 들어옴");	
		 examService.testDeleteGo(paramMap);
			
		
		 logger.info("+ End " + className + ".initComnCod");
		 return "admsmt/examMgtList3";
	 }	
	 
	 
	 //시험지 번호 가장 높은 번호 에서 +1 불러오기
	 @RequestMapping("testMaxNumber.do")
	 @ResponseBody
	 public Map<String,Object> testMaxNumber( @RequestParam Map<String, Object> paramMap, Model model)throws Exception{
		 logger.info("+ Start " + className + ".initComnCod");
		 
		Map<String, Object> result = new HashMap<String, Object> ();
		System.out.println("시험번호 가져오는 컨트롤러 들어옴");	
		
		int testMaxNum=examService.testMaxNumber();
		result.put("testMaxNum", testMaxNum);
		
		 logger.info("+ End " + className + ".initComnCod");
		 return result;
	 }	
	 
	 
	//문제 번호 가장 높은 번호 에서 +1 불러오기
	 @RequestMapping("questionMaxNumber.do")
	 @ResponseBody
	 public Map<String,Object> questionMaxNumber( @RequestParam Map<String, Object> paramMap, Model model)throws Exception{
		 logger.info("+ Start " + className + ".initComnCod");
		 int examNo=Integer.parseInt((String)paramMap.get("examNo"));
		 paramMap.put("examNo",examNo );
		 
		Map<String, Object> result = new HashMap<String, Object> ();
		System.out.println("문제번호 가져오는 컨트롤러 들어옴");
		System.out.println(examNo);
		
		int questionMaxNum=examService.questionMaxNumber(paramMap);
		result.put("questionMaxNum", questionMaxNum);
		
		 logger.info("+ End " + className + ".initComnCod");
		 return result;
	 }	
	 
/*
		 
		 @RequestMapping("questionListData.do")
		 @ResponseBody
	 public Map<String,Object> questionDetailData( @RequestParam Map<String, Object> paramMap, Model model)throws Exception{
		 logger.info("+ Start " + className + ".initComnCod");
		 
			
			// 선택된 강의 문제 리스트 
		 List<AdmsmtExamMgtModel> questionList = examService.getQuestionList(paramMap);
			int cnt=questionList.size();
		 
			if(questionList != null) {
				System.out.println("문제 리스트 가져오기 성공~~~~~~~~~~~~~~~~~~~~");
			}else {
				System.out.println("문제 리스트 가져오기 실패~~~~~~~~~~~~~~~~~~~~");
			}
		Map<String, Object> result=new HashMap<String,Object>();	
			
		result.put("questionList", questionList);
		result.put("cnt", cnt);
		
	
		 logger.info("+ End " + className + ".initComnCod");
		 return result;
	 }	*/
		

}
