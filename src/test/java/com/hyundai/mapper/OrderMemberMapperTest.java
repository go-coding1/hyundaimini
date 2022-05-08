package com.hyundai.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyundai.domain.OrderMemberVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.mapper
 * @fileName		: OrderMemberMapperTest
 * @author			: 고석준
 * @description		: Order테이블 Meber정보와 관련된 요청을 처리하는 Mybatis 인터페이스 테스트 클래스 
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderMemberMapperTest {
	@Autowired
	OrderMemberMapper orderMemberMapper;
	
	@Test
	public void getOrderMemberTest() {
		String mid = "customer01";
		OrderMemberVO orderMemberVO = orderMemberMapper.getOrderMember(mid);
		
		log.info(orderMemberVO.toString());
	}
}
