package com.hyundai.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyundai.domain.CartVO;
import com.hyundai.domain.OrderMemberVO;
import com.hyundai.domain.OrderPageVO;
import com.hyundai.domain.PaymentMethodVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.service
 * @fileName		: OrderPageServiceTest
 * @author			: 고석준 
 * @description		: 주문페이지에서 필요한 정보를 가져오는 서비스 구현체 테스트 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderPageServiceTest {
	@Autowired
	private OrderPageService orderPageService;
	@Autowired
	private OrderMemberService orderMemberService;
	
	@Test
	public void getProductsInfoTest() {
		CartVO cartVO1 = new CartVO();
		cartVO1.setPsid(5);
		CartVO cartVO2 = new CartVO();
		cartVO2.setPsid(7);
		CartVO cartVO3 = new CartVO();
		cartVO3.setPsid(8);
		CartVO cartVO4 = new CartVO();
		cartVO4.setPsid(9);
		
		List<CartVO> psidList = new ArrayList<>();
		psidList.add(cartVO1);
		psidList.add(cartVO2);
		psidList.add(cartVO3);
		psidList.add(cartVO4);
		
		List<OrderPageVO> list = orderPageService.getProductsInfo(psidList);
		
		for(OrderPageVO dto : list) {
			log.info(dto);
		}
	}
	@Test
	public void getOrderMemberTest() {
		OrderMemberVO member = orderMemberService.getOrderMember("ksj");
		
		System.out.println(member.toString());
	}
	
	@Test
	public void getPaymentMethodTest() {
		List<PaymentMethodVO> list = orderPageService.getPaymentMethod();
		for(PaymentMethodVO vo : list) {
			log.info(vo.toString());
		}
	}
}
