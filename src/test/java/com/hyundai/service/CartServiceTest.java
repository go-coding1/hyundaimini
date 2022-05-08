package com.hyundai.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hyundai.domain.CartVO;

import lombok.extern.log4j.Log4j;


/**
 * @packageName		: (test) com.hyundai.service
 * @fileName		: CartServiceTest
 * @author			: 고석준
 * @description		: 장바구니와 관련된 로직을 처리하기 위한 서비스 테스트 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartServiceTest {
	@Autowired
	private CartService cartService;
	
	@Test
	public void updateCart() {
		CartVO cartVO = new CartVO();
		cartVO.setMid("ksj");
		cartVO.setPsid(3);
		cartVO.setPquantity(10);
		
		int rows = cartService.updateCart(cartVO);
		
		log.info("업데이트된 row의 수 " +rows); 
	}
	
	@Test
	public void getListTest() {
		List<CartVO> cartList = cartService.getList("ksj");
		
		for(CartVO cartVO : cartList) {
			log.info(cartVO.toString());
		}
	}
	
	@Test
	public void deleteCart() {
		List<CartVO> cartList = new ArrayList<>();
		
		CartVO vo1 = new CartVO();
		vo1.setMid("ksj");
		vo1.setPsid(1);
		
		CartVO vo2 = new CartVO();
		vo2.setMid("ksj");
		vo2.setPsid(3);
		
		cartList.add(vo1);
		cartList.add(vo2);
		
		int rows = cartService.deleteCart(cartList);
		assertEquals(rows,2);
	}
	
	//장바구니에 insert하는 서비스 테스트 함수 
	@Test
	public void insertCart() {
		CartVO cartVO = new CartVO();
		cartVO.setMid("customer01");
		cartVO.setPsid(5);
		cartVO.setPquantity(2);
		
		int rows = cartService.insertCart(cartVO);
		
		if(rows == 1) {
			log.info("insert done");
		}else {
			log.info("insert fail");
		}
	}
}
