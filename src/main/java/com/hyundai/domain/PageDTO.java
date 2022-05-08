package com.hyundai.domain;

import lombok.Getter;
import lombok.ToString;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: PageDTO.java
 * @author			: 정예성 
 * @description		: 페이징 처리 로직을 수행하는 DTO 클래스
 * @Reference       : 코드로 배우는 스프링 웹 프로젝트(개정판) 
 */
@Getter
@ToString
public class PageDTO {
	
	private int startPage; // 시작 페이지 
	private int endPage;  // 끝 페이지 
	private boolean prev, next; // 이전, 다음 
	
	private int total; // 데이터 총 개수 
	private int pageNum; // 현재 페이지 
	private int amount; // 한 페이지에 담을 데이터의 개수
	
	public PageDTO(int pageNum, int amount, int total) {
		
		this.pageNum = pageNum;
		this.amount = amount;
		this.total = total;
		
		// 끝 페이지 계산 로직 
		this.endPage = (int) (Math.ceil(pageNum / 10.0)) * 10;
		
		// 시작 페이지 계산로직 
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / amount));
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
}
