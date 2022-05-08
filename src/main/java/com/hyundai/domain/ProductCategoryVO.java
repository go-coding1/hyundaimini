package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: ProductCategoryVO.java
 * @author			: 정예성 
 * @description		: 상품의 카테고리 정보를 담는 VO클래스 
 */
@Data
public class ProductCategoryVO {

	private int cateNo; // 카테고리 고유 ID
	private int pId; // 상품 고유 ID
}
