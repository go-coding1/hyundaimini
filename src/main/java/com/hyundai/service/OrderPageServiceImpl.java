package com.hyundai.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.CartVO;
import com.hyundai.domain.OrderPageVO;
import com.hyundai.domain.PaymentMethodVO;
import com.hyundai.mapper.OrderPageMapper;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: OrderPageServiceImpl
 * @author			: 고석준
 * @description		: 주문페이지에서 필요한 정보를 가져오는 서비스 구현체
 */
@Service
@Log4j
public class OrderPageServiceImpl implements OrderPageService {

	@Autowired
	private OrderPageMapper orderPageMapper;
	
	//주문할 상품의 정보를 가져오는 함수
	@Override
	public List<OrderPageVO> getProductsInfo(List<CartVO> psidList) {
		// TODO Auto-generated method stub
		return orderPageMapper.getProductsInfo(psidList);
		
	}
	//주문시 사용할 수 있는 주문 방법 조회하는 함수
	@Override
	public List<PaymentMethodVO> getPaymentMethod() {
		// TODO Auto-generated method stub
		return orderPageMapper.getPaymentMethod();
	}

}
