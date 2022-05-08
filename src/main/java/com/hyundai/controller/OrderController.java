package com.hyundai.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hyundai.domain.CartListVO;
import com.hyundai.domain.CartVO;
import com.hyundai.domain.MemberVO;
import com.hyundai.domain.OrderItemVO;
import com.hyundai.domain.OrderMemberVO;
import com.hyundai.domain.OrderPageVO;
import com.hyundai.domain.OrdersVO;
import com.hyundai.domain.PaymentMethodVO;
import com.hyundai.service.OrderMemberService;
import com.hyundai.service.OrderPageService;
import com.hyundai.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.controller
 * @fileName		: OrderController
 * @author			: 고석준
 * @description		: 주문과 관련된 요청을 받는 컨트롤러
 */
@Log4j
@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	
	
	@Autowired
	private OrderPageService orderPageService;
	
	@Autowired
	private OrderMemberService orderMemberService;
	
	@Autowired
	private OrderService orderService;
	
	/*
	주문하는 페이지로 이동하는 요청을 받는 함수
	주문 페이지로 들어오는 경우는 2가지
	1. 상품페이지 ->  주문하기 버튼 ->  주문페이지
	2. 장바구니 -> 선택상품 주문하기 버튼 -> 주문 페이지
	
	둘다 상품의 정보를 가지고 이동해야 하므로 POST요청으로 작성함*/
	@PostMapping("/orderSheet")
	public String orderSheet(CartListVO list, Model model, HttpSession httpSession) {
		//로그인 되어있지 않으면 로그인 페이지로 이동.
		MemberVO loginMember = (MemberVO) httpSession.getAttribute("user");
		if(loginMember == null) return "redirect:/member/login";
		String mid = loginMember.getMid();
		
		// 주문할 상품의 정보들을 조회하는 부분
		List<OrderPageVO> productList = orderPageService.getProductsInfo(list.getList());
		for(OrderPageVO dto : productList) {
			for(CartVO cart : list.getList()) {
				if(cart.getPsid() == dto.getPsid()) dto.setPquantity(cart.getPquantity());
			}
			System.out.println(dto);
		}
		
		model.addAttribute("productList", productList);	
		
		//주문하는 사용자의 정보를 조회해서 model에 담음
		OrderMemberVO member = orderMemberService.getOrderMember(mid);
		model.addAttribute("member", member);
		
		//결제 방법 조회해서 model에 담음
		List<PaymentMethodVO> paylist = orderPageService.getPaymentMethod();
		model.addAttribute("payList", paylist);
		
		//페이지 이동
		return "order/order";
	}
	
	//주문 요청을 처리하는 함수. ajax 요청임
	@RequestMapping(value = "/sendOrder", method=RequestMethod.POST, headers = {"Accept=application/json"},
			consumes=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> sendOrder(@RequestBody OrdersVO ordersVO){
		List<OrderItemVO> orderItemList = ordersVO.getOrderItemList();
		int rows = orderService.insertOrders(ordersVO, orderItemList);
		if(rows == 0) {
			new ResponseEntity<>("Order is fail.", HttpStatus.FORBIDDEN);
		}
		
		return new ResponseEntity<>("Order is done", HttpStatus.OK);
	}
	
	//관리자 페이지에서 들어온 주문에 대해서 주문상태를 배송완료로 바꾸는 ajax 요청을 처리하는 함수.
	@RequestMapping(value="/updateOrder", method=RequestMethod.POST)
	public ResponseEntity<String> updateOrder(@RequestBody OrderItemVO orderItemVO){
		
		int rows = orderService.updateOrder(orderItemVO);
		if(rows == 0) {
			new ResponseEntity<>("Order dont update.", HttpStatus.FORBIDDEN);
		}
		return new ResponseEntity<>("Order update." , HttpStatus.OK);
	}
	
	
}