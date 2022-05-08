package com.hyundai.mapper;

import com.hyundai.domain.OrderMemberVO;

/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: OrderMemberMapper
 * @author			: 고석준
 * @description		: 주문자의 정보를 가져오는 Mybatis 인터페이스
 */
public interface OrderMemberMapper {
	//주문 요청한 사용자의 정보를 가져오는 요청
	public OrderMemberVO getOrderMember(String mid);
}
