package com.hyundai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hyundai.domain.PageDTO;
import com.hyundai.service.ProductService;
import com.hyundai.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.controller
 * @fileName		: ProductController.java
 * @author			: 정예성 
 * @description		: DB에 저장된 상품 목록들을 출력하고 상세 조회를 제공하는 컨트롤러
 */
@Controller
@RequestMapping("/product/*")
@AllArgsConstructor
public class ProductController {

	private ProductService service;
	private ReviewService reviewService;
	
	// 상품 목록 조회 
	@GetMapping("/productList")
	public void getProductList1(@RequestParam("cateNo") int cateNo, @RequestParam("pageNum") int pageNum, 
			@RequestParam("level") int level, Model model) {
		
		int total = service.getTotalCount(cateNo, pageNum, 12, level);
		
		model.addAttribute("productList", service.getProductList(cateNo, pageNum, 12, level));
		model.addAttribute("pageMaker", new PageDTO(pageNum, 12, total));
	}
	
	// 상품 상세 조회
	@GetMapping("/productDetail")
	public void getProductDetail(@RequestParam("pId") int pId, Model model) {
		
		model.addAttribute("review", reviewService.getReviewCount(pId, 1, 10));
		model.addAttribute("productDetail", service.getProductDetail(pId));
		model.addAttribute("productSize", service.getProductSize(pId));
		model.addAttribute("productColor", service.getProductColor(pId));
	}
}
