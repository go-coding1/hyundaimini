package com.hyundai.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.hyundai.domain.Criteria;
import com.hyundai.domain.ProductCommonVO;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: ProductService
 * @author			: 정예성 
 * @description		: 상품과 관련된 로직을 처리하기 위한 서비스 인터페이스 
 */
public interface ProductService {
	
	// 카테고리 분류에 따른 상품 리스트 출력 
	public List<ProductCommonVO> getProductList(@Param("cateNo") int cateNo, @Param("pageNum") int pageNum, @Param("amount") int amount, @Param("level") int level); 
	
	// 카테고리 분류애 따른 상품 전체 갯수 출력
	public int getTotalCount(@Param("cateNo") int cateNo, @Param("pageNum") int pageNum, @Param("amount") int amount, @Param("level") int level);
	
	// 상품 상세 조회 
	public List<ProductCommonVO> getProductDetail(@Param("pId") int pId);
	
	// 상품 사이즈 조회 
	public List<ProductCommonVO> getProductSize(@Param("pId") int pId);
		
	// 상품 색상 조회
	public List<ProductCommonVO> getProductColor(@Param("pId") int pId);
}
