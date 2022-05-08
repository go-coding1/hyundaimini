package com.hyundai.mapper;

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
 * @packageName		: (test) com.hyundai.mapper
 * @fileName		: CartMapperDeleteTest
 * @author			: 고석준
 * @description		: Cart Delete 테스트 클래스
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartMapperDeleteTest {

	@Autowired
	CartMapper mapper;
	
	@Test
	public void cartDeleteTest() {
		List<CartVO> cartList = new ArrayList<>();
		
		CartVO vo1 = new CartVO();
		vo1.setMid("ksj");
		vo1.setPsid(1);
		
		CartVO vo2 = new CartVO();
		vo2.setMid("ksj");
		vo2.setPsid(3);
		
		cartList.add(vo1);
		cartList.add(vo2);
		
		int rows = mapper.deleteCart(cartList);
		log.info("삭제된 행의 수 : " + rows );
	}
}
