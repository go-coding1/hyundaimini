package com.hyundai.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyundai.domain.ReviewVO;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: ReviewService
 * @author			: 정예성 
 * @description		: 리뷰와 관련된 로직을 처리하기 위한 서비스 
 */
public interface ReviewService {
	
	// 리뷰 목록 조회 
	public List<ReviewVO> getReviewList(@Param("pId") int pId, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	// 리뷰 조회 
	public ReviewVO readReview(int rNo);
	
	// 리뷰 작성 
	public int insertReview(ReviewVO vo);
		
	// 리뷰 삭제  
	public boolean deleteReview(int rNo);
		
	// 리뷰 수정
	public int updateReview(ReviewVO vo);
	
	// 리뷰 갯수 출력 
	public int getReviewCount(@Param("pId") int pId, @Param("pageNum") int pageNum, @Param("amount") int amount);
}
