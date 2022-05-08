package com.hyundai.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyundai.domain.OrderMemberVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.service
 * @fileName		: OrderMemberServiceTest
 * @author			: 고석준 
 * @description		: 주문자의 정보를 가져오는 서비스 테스트 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderMemberServiceTest {
	
	@Autowired
	private OrderMemberService orderMemberService;
	
	
	@Test
	public void getOrderMemberTest() {
		OrderMemberVO orderMemberVO = orderMemberService.getOrderMember("customer01");
		
		log.info(orderMemberVO);
	}
	
}
