package kr.happyjob.study.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	
	@RequestMapping("practice.do")
	public String practice (	Model model, 
								@RequestParam Map<String, String> paramMap, 
								HttpServletRequest request,
								HttpServletResponse response, 
								HttpSession session) throws Exception {
		return "admstat/practice";
	}
}
