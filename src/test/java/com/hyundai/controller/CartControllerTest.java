package com.hyundai.controller;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.hyundai.domain.CartVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.controller
 * @fileName		: CartControllerTest
 * @author			: 고석준
 * @description		: 장바구니와 관련된 컨트롤러 요청을 테스트하는 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class CartControllerTest {
	@Autowired
	CartController cartController;
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();		
	}//end setup
	
	
	@Test
	public void testGet() throws Exception {
		log.info("Start testGet()");
		
		String pageName =  mockMvc.perform(
				MockMvcRequestBuilders.get("/cart/getList")
				.param("mid", "ksj")				
				).andReturn()
				.getModelAndView()
				.getViewName();
		
		assertEquals("order/shoppingbag",pageName);
	}//end testList
	
	@Test
	public void testUpdateQuantity() throws Exception{
		log.info("Start testUpdateQuantity");
		
		CartVO cartVO = new CartVO();
		cartVO.setMid("ksj");
		cartVO.setPsid(3);
		cartVO.setPquantity(10);
		
		String content = new Gson().toJson(cartVO);
		ResultActions resultPage = mockMvc.perform(
				MockMvcRequestBuilders.post("/cart/updateQuantity")
				.content(content).contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isOk())
				;
		log.info("This is testUpdateQuantity : " + resultPage);
	}
	
	@Test
	public void testDeleteCart() throws Exception{
		log.info("Start testDeleteCart");
		
		List<CartVO> cartList = new ArrayList<>();
		
		CartVO vo1 = new CartVO();
		vo1.setPsid(1);
		
		CartVO vo2 = new CartVO();
		vo2.setPsid(3);
		
		cartList.add(vo1);
		cartList.add(vo2);
		
		String content = new Gson().toJson(cartList);
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.post("/cart/deleteCart")
				.content(content).contentType(MediaType.APPLICATION_JSON)
				)
				.andReturn().getModelAndView().getViewName();
		
		assertEquals("order/shoppingbag",pageName);
	}
	
	@Test
	public void insertCartTest() throws Exception {
		CartVO cartVO = new CartVO();
		cartVO.setMid("customer01");
		cartVO.setPsid(5);
		cartVO.setPquantity(2);
		
		String content = new Gson().toJson(cartVO);
		String result = mockMvc.perform(
				MockMvcRequestBuilders.post("/cart/insertCart")
				.content(content).contentType(MediaType.APPLICATION_JSON)
				)
				.andReturn().getResponse().getContentAsString();
		log.info(result +"@@@@@@@@@@@");
	}
	
}
