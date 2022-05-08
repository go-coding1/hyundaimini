package com.hyundai.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.Criteria;
import com.hyundai.domain.ProductCommonVO;
import com.hyundai.mapper.ProductMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: ProductServiceImpl
 * @author			: 정예성 
 * @description		: 상품과 관련된 로직을 처리하기 위한 서비스 구현체 
 */
@Log4j
@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper mapper;

	@Override
	public List<ProductCommonVO> getProductList(int cateNo, int pageNum, int amount, int level) {
		
		log.info("getProductList......");
		
		int cateRefCode = 0;
		
		if(level == 1) {
			
			cateRefCode = cateNo;
			
			return mapper.getProductList_1(cateRefCode, pageNum, amount);
			
		} else if(level == 2) {
			
			cateRefCode = cateNo;
			
			return mapper.getProductList_2(cateRefCode, pageNum, amount);
			
		} else {
		
			return mapper.getProductList_3(cateNo, pageNum, 12);
		}
	}

	@Override
	public int getTotalCount(int cateNo, int pageNum, int amount, int level) {
		
		log.info("get total count");
		
		int cateRefCode = 0;
		
		if(level == 1) {
			
			cateRefCode = cateNo;
			
			return mapper.getTotalCount_1(cateNo, pageNum, 12);
			
		} else if(level == 2) {
			
			cateRefCode = cateNo;
			
			return mapper.getTotalCount_2(cateRefCode, pageNum, amount);
			
		} else {
			
			return mapper.getTotalCount_3(cateNo, pageNum, amount);
		}
	}

	@Override
	public List<ProductCommonVO> getProductDetail(int pId) {
		
		log.info("getProductDetail......");
		
		return mapper.getProductDetail(pId);
	}

	@Override
	public List<ProductCommonVO> getProductSize(int pId) {
		
		return mapper.getProductSize(pId);
	}

	@Override
	public List<ProductCommonVO> getProductColor(int pId) {
		
		return mapper.getProductColor(pId);
	}

}
