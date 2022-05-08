package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: ProductCommonVO.java
 * @author			: 정예성 
 * @description		: 상품 상세 정보를 담는 VO클래스 
 */
@Data
public class ProductCommonVO {
	
	private int pId; // 상품 고유 ID
	private String pName; // 상품 이름 
	private String pNote; // 상품 설명 
	private int bNo; // 브랜드 고유 ID
	private int pStatus; // 상품 상태
	
	// 상품 테이블 JOIN을 위한 VO객체 선언 
	private BrandVO brandVO;
	private CategoryVO categoryVO;
	private ProductStockVO productStockVO;
	private ProductCategoryVO productCategoryVO;
	private ProductColorVO productColorVO;

}
