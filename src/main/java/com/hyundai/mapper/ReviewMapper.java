package com.hyundai.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hyundai.domain.ReviewVO;

/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: ReviewMapper 
 * @author			: 정예성 
 * @description		: 리뷰 테이블 관련 SQL을 처리하는 Mapper 인터페이스
 */
public interface ReviewMapper {
	
	// 리뷰 목록 조회 
	public List<ReviewVO> getReviewList(@Param("pId") int pId, @Param("pageNum") int pageNum, @Param("amount") int amount);
	
	// 리뷰 조회 
	public ReviewVO readReview(int rNo);
	
	// 리뷰 작성 
	public int insertReview(ReviewVO vo);
	
	// 리뷰 삭제  
	public int deleteReview(int rNo);
	
	// 리뷰 수정
	public int updateReview(ReviewVO vo);
	
	// 리뷰 개수 출력 
	public int getReviewCount(@Param("pId") int pId, @Param("pageNum") int pageNum, @Param("amount") int amount);
}
