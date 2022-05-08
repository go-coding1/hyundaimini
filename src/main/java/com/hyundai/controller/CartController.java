package com.hyundai.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hyundai.domain.CartVO;
import com.hyundai.domain.MemberVO;
import com.hyundai.service.CartService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.controller
 * @fileName		: CartController
 * @author			: 고석준
 * @description		: 쇼핑백(장바구니)와 관련된 요청을 받는 컨트롤러
 */
@Log4j
@Controller
@RequestMapping("/cart/*")
@AllArgsConstructor
public class CartController {

	@Autowired
	private CartService cartService;
	
	/*
	로그인한 사용자의 장바구니 정보를 담아서 jsp화면을 보여주는 요청
	 */
	@GetMapping("/getList")
	public String getList(Model model, HttpSession httpSession){
		
		MemberVO loginMember = (MemberVO) httpSession.getAttribute("user");
		if(loginMember == null) return "redirect:/member/login";//로그인안된 유저면 로그인 화면으로 리다이렉션한다.
		String mid = loginMember.getMid();
		
		log.info("Called /cart/getList");
		List<CartVO> cartList = cartService.getList(mid);
		
		model.addAttribute("cartList", cartList);
		return "order/shoppingbag";
	}
	
	/*
	장바구니의 담기 수량을 변경 하는 요청 ajax요청을 받는다.*/
	@RequestMapping(value = "/updateQuantity", method= RequestMethod.POST, headers = {"Accept=application/json"},
			consumes=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CartVO> updateQuantity(@RequestBody CartVO cartVO){
		log.info("Called updateQuantity ");
		log.info(cartVO.toString());
		int rows = cartService.updateCart(cartVO);
		
		if(rows != 1) {
			return new ResponseEntity<CartVO>(HttpStatus.NOT_FOUND);
		}
		
		
		return new ResponseEntity<CartVO>(cartVO, HttpStatus.OK);
	}
	
	/*
	장바구니에 담긴 상품을 삭제하는 요청*/
	@RequestMapping(value="/deleteCart", method=RequestMethod.POST, headers = {"Accept=application/json"})
	public String deleteCart(@RequestBody List<CartVO> cartList, Model model, HttpSession httpSession) {
		log.info("Called deleteCart");
		
		MemberVO loginMember = (MemberVO) httpSession.getAttribute("user");
		if(loginMember == null) return "redirect:/member/login";
		String mid = loginMember.getMid();
		
		for(CartVO vo : cartList) {
			log.info(vo.toString());
			vo.setMid(mid);
		}
		int rows = cartService.deleteCart(cartList);
		
		cartList = cartService.getList(mid);
		
		model.addAttribute("cartList", cartList);
		return "redirect:/cart/getList";
	}
	
	/*
	장바구니에 제품을 담는 요청, 로그인한 사용자만 담을 수 있다. ajax 요청을 받는다. */
	@RequestMapping(value="/insertCart", method=RequestMethod.POST, headers = {"Accept=application/json"})
	public ResponseEntity<String> insertCart(@RequestBody CartVO cartVO, HttpSession httpSession){
		
		MemberVO loginMember = (MemberVO) httpSession.getAttribute("user");
		if(loginMember == null) return new ResponseEntity<>("로그인이 되어있지 않습니다.", HttpStatus.UNAUTHORIZED);
		String mid = loginMember.getMid();
		
		int row = cartService.insertCart(cartVO);
		if(row != 1) {
			return new ResponseEntity<>("쇼핑백에 담지 못하였습니다. ", HttpStatus.FORBIDDEN);
		}
		
		return new ResponseEntity<>("쇼핑백에 담겼습니다.", HttpStatus.OK);
	}
}
