package kr.happyjob.study.admstat.controller;

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
import kr.happyjob.study.admstat.model.AdmstatSatisfactionModel;
import kr.happyjob.study.admstat.service.AdmstatSatisfactionService;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.service.ComnCodService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/statistics/")
public class AdmstatSatisfactionController {
	 
	@Autowired
	AdmstatSatisfactionService admstatSatisfactionService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 초기화면
	 */
	@RequestMapping("satisfaction.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		return "admstat/satisfaction";
	}
	
	
	
//	  강의 목록 조회

	@RequestMapping("listSatisfaction.do")
	public String listComnDtlCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listComnDtlCod");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		 
		//  강의 목록 조회
		List<AdmstatSatisfactionModel> admstatSatisfactionModel = admstatSatisfactionService.listSatisfactionList(paramMap);
		model.addAttribute("admstatSatisfactionModel", admstatSatisfactionModel);
		
	
		
		
		
		//  강의 목록 카운트 조회
		int totalCount = admstatSatisfactionService.countSatisfactionList(paramMap);
		model.addAttribute("totalCntSatisfactopnList", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageComnDtlCod",currentPage);
		
		logger.info("+ End " + className + ".listComnDtlCod");

		return "/admstat/satisfactionList";
	}	

	
	


	/*차트 조회*/
	//리스폰스바디 어노테이션을 쓰면 json으로 리턴함
	@RequestMapping("selectSatisfactionList.do")
	@ResponseBody
	public Map<String, Object> selectComnDtlCod (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		List<Map<String,Object>> list = admstatSatisfactionService.selectSatisfactionList();
		
		
		logger.info("list : " + list.get(0).toString());
		
		//0. 최종적으로 리턴할 json 객체
		JSONObject data = new JSONObject();
		//1. cols 배열에 넣기
		JSONObject col1 = new JSONObject();
		JSONObject col2 = new JSONObject();
		
		JSONArray title = new JSONArray(); 
		col1.put("label", "상품명");
		col1.put("type", "string");
		col2.put("label", "금액");
		col2.put("type", "number");
		
		title.add(col1);
		title.add(col2);
		
		data.put("cols", title);
		
		//2. rows 배열에 넣기
		JSONArray body = new JSONArray();	//rows
		for(Map<String, Object> map : list) {
				
			//{"c":[{"v":"삼성 칼라 TV 29인치"}, {"v":14280000}]},;
			JSONObject prodName = new JSONObject();
			prodName.put("v", map.get("PROD_NAME"));
			JSONObject money = new JSONObject();
			money.put("v", map.get("MONEY"));	//금액
			
			JSONArray row = new JSONArray();
			row.add(prodName);
			row.add(money);
			
			JSONObject cell = new JSONObject();
			cell.put("c", row);
			
			body.add(cell); //레코드 1행 추가
		} //end for
		
		data.put("rows", body);
		return data;
	}
	

	

}
