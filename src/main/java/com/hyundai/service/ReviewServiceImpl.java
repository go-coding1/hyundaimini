package com.hyundai.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.ReviewVO;
import com.hyundai.mapper.ProductMapper;
import com.hyundai.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: ReviewServiceImpl
 * @author			: 정예성 
 * @description		: 리뷰와 관련된 로직을 처리하기 위한 서비스 구현체
 */
@Service
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper mapper;
	
	@Override
	public List<ReviewVO> getReviewList(int pId, int pageNum, int amount) {
		
		return mapper.getReviewList(pId, pageNum, 10);
	}
	
	@Override
	public ReviewVO readReview(int rNo) {

		return mapper.readReview(rNo);
	}

	@Override
	public int insertReview(ReviewVO vo) {
		
		return mapper.insertReview(vo);
	}

	@Override
	public boolean deleteReview(int rNo) {
		
		return mapper.deleteReview(rNo) == 1;
	}

	@Override
	public int getReviewCount(int pId, int pageNum, int amount) {

		return mapper.getReviewCount(pId, pageNum, 10);
	}

	@Override
	public int updateReview(ReviewVO vo) {
		
		return mapper.updateReview(vo);
	}

}
