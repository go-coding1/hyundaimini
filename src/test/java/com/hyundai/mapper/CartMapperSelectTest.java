package com.hyundai.mapper;

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
 * @description		: Cart Select 테스트 클래스
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartMapperSelectTest {
	@Autowired
	private CartMapper mapper;
	
	@Test
	public void getListTest() {
		List<CartVO> cartList = mapper.getList("ksj");
		if(!cartList.isEmpty()) {
			log.info("조회된 카트의 수량은 : "+cartList.size());
			for(int i=0; i<cartList.size(); i++) {
				CartVO cartVO = cartList.get(i);
				log.info(cartVO.getBname());
			}
		}else {
			log.info("Cart is empty");
		}
	}
	
	
}
