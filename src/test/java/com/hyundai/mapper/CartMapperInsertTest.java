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
 * @fileName		: CartMapperInsertTest
 * @author			: 고석준
 * @description		: Cart Insert 테스트 클래스
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartMapperInsertTest {

	@Autowired
	private CartMapper mapper;
	
	@Test
	public void insertCartTest() {
		CartVO cartVO = new CartVO();
		cartVO.setMid("ksj");
		cartVO.setPquantity(2);
		cartVO.setPsid(3);
		
		mapper.insertCart(cartVO);
	}
}
