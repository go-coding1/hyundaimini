package com.hyundai.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.OrderMemberVO;
import com.hyundai.mapper.OrderMemberMapper;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: OrderMemberServiceImpl
 * @author			: 고석준
 * @description		: 주문자의 정보를 가져오는 서비스 구현체
 */
@Service
public class OrderMemberServiceImpl implements OrderMemberService {

	@Autowired
	private OrderMemberMapper orderMemberMapper;
	
	//주문 요청한 사용자의 정보를 가져오는 요청
	@Override
	public OrderMemberVO getOrderMember(String mid) {
		// TODO Auto-generated method stub
		return orderMemberMapper.getOrderMember(mid);
		
	}


}