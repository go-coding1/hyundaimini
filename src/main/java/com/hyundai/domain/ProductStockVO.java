package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: ProductStockVO.java
 * @author			: 정예성 
 * @description		: 상품 재고 관련 정보를 담는 VO클래스 
 */
@Data
public class ProductStockVO {

	private int psId; // 상품 재고 고유 Id
	private int psStock; // 상품 재고 
	private int pSize; // 상품 사이즈 
	private int pcId; // 상품 컬러 고 Id 
}
