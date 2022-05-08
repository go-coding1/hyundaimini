package com.hyundai.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyundai.domain.OrderItemVO;
import com.hyundai.domain.OrdersVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.mapper
 * @fileName		: OrderMapperTest
 * @author			: 고석준
 * @description		: Order테이블과 관련된 요청을 처리하는 Mybatis 인터페이스 테스트 클래스 
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderMapperTest {
	@Autowired
	private OrderMapper orderMapper;
	
	//주문하기 테스트 
	@Test
	public void insertOrdersTest() {
		OrdersVO vo = new OrdersVO();
		vo.setOaddress1("테스트 주소1");
		vo.setOreceiver("주문자");
		vo.setOphone("01011112222");
		//vo.setOtel("01011112222");
		vo.setOmemo("테스트 메모 ");	
		vo.setOemail("test@email.com");
		vo.setObeforeprice(1000);
		vo.setOafterprice(10000);
		vo.setOstatus("주문완료 ");
		vo.setMid("ksj");
		vo.setOaddress2("테스트 주소2 ");
		vo.setPmcode("TOSS");
		
		int rows = orderMapper.insertOrders(vo);
		log.info("insert rows count :" + rows);
		log.info("sequence num : " + vo.getOid());
		
		OrderItemVO orderItemVO1 = new OrderItemVO();
		orderItemVO1.setOid(vo.getOid());
		orderItemVO1.setPsid(5);
		orderItemVO1.setOicount(1);
		orderItemVO1.setOitotalprice(100);
		
		OrderItemVO orderItemVO2 = new OrderItemVO();
		orderItemVO2.setOid(vo.getOid());
		orderItemVO2.setPsid(10);
		orderItemVO2.setOicount(1);
		orderItemVO2.setOitotalprice(100);
		
		List<OrderItemVO> orderItemList = new ArrayList<>();
		orderItemList.add(orderItemVO1);
		orderItemList.add(orderItemVO2);
		
		int itemrows = orderMapper.insertOrderItem(orderItemList);
		log.info("insert itemrows count : " + itemrows);
		
	}
	
	//회원의 주문 정보를 얻어오는 테스트 
	@Test
	public void getOrderListTest() {
		String mid = "customer01";
		
		List<OrderItemVO> orderList =  orderMapper.getOrderList(mid);
		for(OrderItemVO vo : orderList) {
			log.info(vo.toString());
		}
	}
	
	//관리자페이지에서 주문 정보들을 얻어오는 테스트 
	@Test
	public void getOrderListForAdminTest() {
		List<OrderItemVO> orderList =  orderMapper.getOrderListForAdmin();
		for(OrderItemVO vo : orderList) {
			log.info(vo.toString());
		}
	}
	
	//관리자가 주문을 주문완료->배송완료로 바꾸는 함수 
	@Test
	public void updateOrderTest() {
		OrderItemVO orderItemVO = new OrderItemVO();
		orderItemVO.setPsid(7);
		orderItemVO.setOid(54);
		
		int rows = orderMapper.updateOrder(orderItemVO);
		if(rows == 1) {
			log.info("update done");
		}
	}
	
}
