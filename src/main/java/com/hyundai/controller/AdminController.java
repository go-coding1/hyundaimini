package com.hyundai.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hyundai.domain.MemberVO;
import com.hyundai.domain.OrderItemVO;
import com.hyundai.service.OrderService;

/**
 * @packageName		: com.hyundai.controller
 * @fileName		: AdminController.java
 * @author			: 황명하
 * @description		: 관리자 계정으로 로그인 시 관리자 페이지에 접근 가능하도록 구현
 */

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private OrderService orderService;
	
	//관리자 마이페이지 이동 (황명하) 
	@RequestMapping(value = "/adminpage", method = RequestMethod.GET)
    public String Adminpage(HttpSession httpSession, Model model) throws Exception {
		
		MemberVO loginMember = (MemberVO) httpSession.getAttribute("user");
		if(loginMember == null) return "redirect:/member/login";
		
		
		List<OrderItemVO> orderList= orderService.getOrderListForAdmin();
		model.addAttribute("orderList", orderList);
		
		return "admin/adminpage"; 
    }	
	
}
