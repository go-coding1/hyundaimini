package com.hyundai.mapper;

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
 * @description		: Cart Update 테스트 클래스
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartMapperUpdateTest {
	
	@Autowired
	private CartMapper cartMapper;
	
	@Test
	public void updateCartTest() {
		
		CartVO vo = new CartVO();
		vo.setMid("ksj");
		vo.setPsid(3);
		vo.setPquantity(10);
		
		int rows = cartMapper.updateCart(vo);
		
		log.info("update 된 행의 수 : "+rows);
	}
}
