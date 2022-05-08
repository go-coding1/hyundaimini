package com.hyundai.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: Criteria.java
 * @author			: 정예성 
 * @description		: 페이징 처리 관련 VO클래스 
 * @Reference       : 코드로 배우는 스프링 웹 프로젝트(개정판) 
 */
@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum; // 현재 페이지 
	private int amount;  // 한 페이지에 담을 데이터의 개수
	
	public Criteria() {
		this(1, 12);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
