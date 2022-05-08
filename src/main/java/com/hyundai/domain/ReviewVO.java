package com.hyundai.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: ReviewVO.java
 * @author			: 정예성 
 * @description		: 리뷰 관련 정보를 담는 VO클래스 
 */
@Data
public class ReviewVO {
	
	private int rNo; // 게시물 고유 번호
	
	@JsonProperty("mid")
	private String mId; // 멤버 아이디
	
	@JsonProperty("mname")
	private String mName; // 멤버 이름
	
	@JsonProperty("pid")
	private int pId; // 상품 고유 번호
	
	@JsonProperty("pname")
	private String pName; // 상품 이름 
	
	@JsonProperty("rcontent")
	private String rContent; // 리뷰 내용 
	private String rDate; // 리뷰 등록 날짜 
	
	private String rImage; // 리뷰 이미지 
	  
	private String rThumImage; // 리뷰 섬네일 이미지 
}
