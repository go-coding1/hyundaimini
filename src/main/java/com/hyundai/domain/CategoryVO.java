package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: CategoryVO.java
 * @author			: 정예성 
 * @description		: 카테고 관련 정보를 담는 VO클래스 
 */
@Data
public class CategoryVO {
	
	private int cateNo; // 카테고리 고유 ID
	private String cateName; // 카테고리 이름 
	private int cateRefCode1; // 대분류 참조 코드 
	private int cateRefCode2; // 중분류 참조 코드 
	
}
