package com.hyundai.domain;

import java.util.Date;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: ProductColorVO.java
 * @author			: 정예성 
 * @description		: 상품의 상세 정보를 담는 VO클래스 
 */
@Data
public class ProductColorVO {
	
	private int pcId; // 상품 컬러 고유 ID 
	private String pcImg1; // 상품 이미지 1
	private String pcImg2; // 상품 이미지 2
	private String pcImg3; // 상품 이미지 3
	private String pcChipImg; // 상품 대표 이미지  
	private String pcColorCode; // 상품 색상 코드 
	private int pcPrice; // 상품 가격  
	private int pId; // 상품 고유 ID
	private Date pReleaseDate; // 상품 출시 일자 
}
