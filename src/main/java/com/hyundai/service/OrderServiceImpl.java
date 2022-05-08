package com.hyundai.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hyundai.domain.CartVO;
import com.hyundai.domain.OrderItemVO;
import com.hyundai.domain.OrdersVO;
import com.hyundai.mapper.CartMapper;
import com.hyundai.mapper.OrderMapper;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: OrderService
 * @author			: 고석준
 * @description		: 주문ORDERS테이블과 관련된 요청을 처리하는 서비스 구현체
 */
@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private CartMapper cartMapper;

	//새로운 주문을 넣는 함수 ORDER테이블에 insert
	// 한번에 3개의 테이블에 삽입.삭제해야해서 트랜잭션 처리함
	@Transactional
	@Override
	public int insertOrders(OrdersVO ordersVO, List<OrderItemVO> orderItemList) {
		// TODO Auto-generated method stub
		int rows = orderMapper.insertOrders(ordersVO);
		int oid = ordersVO.getOid();	//ORDERS테이블에 넣는 ORDERS의 PK값을 가져옴
		for(OrderItemVO vo : orderItemList) {
			vo.setOid(oid);
		}
		rows += orderMapper.insertOrderItem(orderItemList);
		
		List<CartVO> cartList = new ArrayList<>();
		for(OrderItemVO vo : orderItemList) {
			CartVO cartVO = new CartVO();
			cartVO.setPsid(vo.getPsid());
			cartVO.setMid(ordersVO.getMid());
			System.out.println(ordersVO.getMid()+ " @@@@@@@@");
			cartList.add(cartVO);
		}
		
		//주문완료시 장바구니에 있는 상품 삭제
		if(rows > 0) {
			cartMapper.deleteCart(cartList);
		}
		
		return rows;
	}

	//사용자의 주문 정보를 가져오는 함수
	@Override
	public List<OrderItemVO> getOrderList(String mid) {
		// TODO Auto-generated method stub
		return orderMapper.getOrderList(mid);
	}

	//관리자가 현재 있는 주문을 가져오는 함수
	@Override
	public List<OrderItemVO> getOrderListForAdmin() {
		// TODO Auto-generated method stub
		return orderMapper.getOrderListForAdmin();
	}

	//관리자가 주문을 주문완료->배송완료로 바꾸는 함수
	@Override
	public int updateOrder(OrderItemVO orderItemVO) {
		// TODO Auto-generated method stub
		return orderMapper.updateOrder(orderItemVO);
	}


}