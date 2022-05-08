package com.hyundai.mapper;

import java.util.List;

import com.hyundai.domain.OrderItemVO;
import com.hyundai.domain.OrdersVO;
/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: OrderMapper
 * @author			: 고석준
 * @description		: Order테이블과 관련된 요청을 처리하는 Mybatis 인터페이스
 */
public interface OrderMapper {
	//새로운 주문을 넣는 함수 ORDER테이블에 insert
	public int insertOrders(OrdersVO ordersVO);
	//주문 상품을 넣는 함수 ODER_ITEM에 insert
	public int insertOrderItem(List<OrderItemVO> orderItemList);
	//사용자의 주문 정보를 가져오는 함수
	public List<OrderItemVO> getOrderList(String mid);
	//관리자가 현재 있는 주문을 가져오는 함수
	public List<OrderItemVO> getOrderListForAdmin();
	//관리자가 주문을 주문완료->배송완료로 바꾸는 함수
	public int updateOrder(OrderItemVO orderItemVO);
}
