package com.hyundai.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.hyundai.domain.Criteria;
import com.hyundai.domain.ProductCommonVO;

/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: ProductMapper 
 * @author			: 정예성 
 * @description		: 상품 테이블 관련 SQL을 처리하는 Mapper 인터페이스
 */
public interface ProductMapper {
	
	// 카테고리 대분류에 따른 상품 리스트 출력
	public List<ProductCommonVO> getProductList_1(@Param("cateRefCode1") int cateRefCode1, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	// 카테고리 중분류에 따른 상품 리스트 출력
	public List<ProductCommonVO> getProductList_2(@Param("cateRefCode2") int cateRefCode2, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	// 카테고리 소분류에 따른 상품 리스트 출력
	public List<ProductCommonVO> getProductList_3(@Param("cateNo") int cateNo, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	// 카테고리 분류애 따른 상품 전체 갯수 출력 
	public int getTotalCount_1(@Param("cateRefCode1") int cateRefCode1, @Param("pageNum") int pageNum, @Param("amount") int amount);
	public int getTotalCount_2(@Param("cateRefCode2") int cateRefCode2, @Param("pageNum") int pageNum, @Param("amount") int amount);
	public int getTotalCount_3(@Param("cateNo") int cateNo, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	// 상품 상세 조회  
	public List<ProductCommonVO> getProductDetail(@Param("pId") int pId);
	
	// 상품 사이즈 조회 
	public List<ProductCommonVO> getProductSize(@Param("pId") int pId);
	
	// 상품 색상 조회
	public List<ProductCommonVO> getProductColor(@Param("pId") int pId);
}
