package com.hyundai.mapper;

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
 * @packageName		: (test) com.hyundai.mapper
 * @fileName		: OrderPageMapperTest
 * @author			: 고석준
 * @description		: 주문페이지에 필요한 정보를 가져오는 Mapper 테스트 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderPageMapperTest {
	@Autowired
	OrderPageMapper orderPageMapper;
	
	@Autowired
	OrderMemberMapper orderMemberMapper;
	
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
		
		List<OrderPageVO> list = orderPageMapper.getProductsInfo(psidList);
		for(OrderPageVO dto : list) {
			System.out.println(dto);
		}
	}
	
	//사용자의 주문 목록을 가져오는 테스트 함수 
	@Test
	public void getOrderMemberTest() {
		OrderMemberVO vo = orderMemberMapper.getOrderMember("ksj");
		log.info(vo.toString());
	}
	
	//주문시 사용할 수 있는 주문 방법 조회하는 테스트 함수
	@Test
	public void getPaymentMethodTest() {
		List<PaymentMethodVO> list = orderPageMapper.getPaymentMethod();
		for(PaymentMethodVO vo : list) {
			log.info(vo.toString());
		}
	}
}
