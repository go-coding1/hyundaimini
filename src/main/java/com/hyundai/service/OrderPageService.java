package com.hyundai.service;

import java.util.List;

import com.hyundai.domain.CartVO;
import com.hyundai.domain.OrderPageVO;
import com.hyundai.domain.PaymentMethodVO;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: OrderPageService
 * @author			: 고석준
 * @description		: 주문페이지에서 필요한 정보를 가져오는 서비스 인터페이스
 */
public interface OrderPageService {
	//주문할 상품의 정보를 가져오는 함수
	public List<OrderPageVO> getProductsInfo(List<CartVO> psidList);
	//주문시 사용할 수 있는 주문 방법 조회하는 함수
	public List<PaymentMethodVO> getPaymentMethod();
}
