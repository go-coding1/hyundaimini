package com.hyundai.service;

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
 * @packageName		: (test) com.hyundai.service
 * @fileName		: OrderServiceTest
 * @author			: 고석준
 * @description		: 주문ORDERS테이블과 관련된 요청을 처리하는 서비스 구현체 테스트 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OrderServiceTest {
	@Autowired
	private OrderService orderService;
	
	@Test
	public void insertOrdersTest() {
		OrdersVO vo = new OrdersVO();
		vo.setOaddress1("테스트 주소1");
		vo.setOreceiver("주문자");
		vo.setOphone("01011112222");
		vo.setOtel("01011112222");
		vo.setOmemo("테스트 메모 ");	
		vo.setOemail("test@email.com");
		vo.setObeforeprice(1000);
		vo.setOafterprice(10000);
		vo.setOstatus("주문완료 ");
		vo.setMid("ksj");
		vo.setOaddress2("테스트 주소2 ");
		vo.setPmcode("TOSS");
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@ " + vo.getOid());;
		
		OrderItemVO orderItemVO1 = new OrderItemVO();
		//orderItemVO1.setOid(vo.getOid());
		orderItemVO1.setPsid(5);
		orderItemVO1.setOicount(1);
		orderItemVO1.setOitotalprice(100);
		
		OrderItemVO orderItemVO2 = new OrderItemVO();
		//orderItemVO2.setOid(vo.getOid());
		orderItemVO2.setPsid(10);
		orderItemVO2.setOicount(1);
		orderItemVO2.setOitotalprice(100);
		
		List<OrderItemVO> orderItemList = new ArrayList<>();
		orderItemList.add(orderItemVO1);
		orderItemList.add(orderItemVO2);
		
		int rows = orderService.insertOrders(vo, orderItemList);
		
		log.info(rows);
	}
	
	//사용자의 주문 정보를 가져오는 테스트 함수 
	@Test
	public void getOrderListTest() {
		List<OrderItemVO> orderItemList = orderService.getOrderList("customer01");
		for(OrderItemVO vo : orderItemList) {
			log.info(vo.toString());
		}
	}
	
	//관리자가 현재 있는 주문을 가져오는 테스트 함수
	@Test
	public void getOrderListForAdminTest() {
		// TODO Auto-generated method stub
		List<OrderItemVO> orderItemList = orderService.getOrderListForAdmin();
		for(OrderItemVO vo : orderItemList) {
			log.info(vo.toString());
		}
	}
	
	//관리자가 주문을 주문완료->배송완료로 바꾸는 테스트 함수 
	@Test
	public void updateOrderTest() {
		OrderItemVO orderItemVO = new OrderItemVO();
		orderItemVO.setPsid(7);
		orderItemVO.setOid(54);
		
		int rows = orderService.updateOrder(orderItemVO);
		if(rows == 1) {
			log.info("update done");
		}
	}
}
