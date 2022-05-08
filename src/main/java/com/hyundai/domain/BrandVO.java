package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: BrandVO.java
 * @author			: 정예성 
 * @description		: 브랜드 관련 정보를 담는 VO클래스 
 */
@Data
public class BrandVO {
	
	private int bNo; // 브랜드 고유 ID
	private String bName; // 브랜드 이름
}
