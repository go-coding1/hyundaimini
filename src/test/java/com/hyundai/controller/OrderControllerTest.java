package com.hyundai.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.hyundai.domain.CartListVO;
import com.hyundai.domain.MemberVO;
import com.hyundai.domain.OrderItemVO;
import com.hyundai.domain.OrdersVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.service
 * @fileName		: OrderControllerTest
 * @author			: 고석준 
 * @description		: 주문과 관련된 요청을 받는 컨트롤러 테스트 클래스 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class OrderControllerTest {
	@Autowired
	OrderController orderController;
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	protected MockHttpSession mockHttpSession;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();		
		
	}//end setup
	
	@Test
	public void orderSheetTest() throws Exception {
		this.mockHttpSession = new MockHttpSession();
		MemberVO memberVO = new MemberVO();
		memberVO.setMid("customer01");
		this.mockHttpSession.setAttribute("user", new MemberVO());
		
		CartListVO cartListVO = new CartListVO();
		
		String viewName = mockMvc.perform(
				MockMvcRequestBuilders.post("/order/orderSheet")
				.requestAttr("list", cartListVO)
				).andReturn().getModelAndView().getViewName();
		
		log.info(viewName);
	}
	
	@Test
	public void sendOrderTest() throws Exception {
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
		
		vo.setOrderItemList(orderItemList);
		
		Gson gson = new Gson();
		
		String jsonString = gson.toJson(vo);
		
		ResultActions resultPage = mockMvc.perform(
				MockMvcRequestBuilders.post("/order/sendOrder")
				.content(jsonString).contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isOk())
				;
		log.info("This is testUpdateQuantity : " + resultPage);
	}
	
	@Test
	public void updateOrderTest() throws Exception {
		
		OrderItemVO orderItemVO = new OrderItemVO();
		orderItemVO.setPsid(7);
		orderItemVO.setOid(54);
		
		String content = new Gson().toJson(orderItemVO);
		
		String result = mockMvc.perform(
				MockMvcRequestBuilders.post("/order/updateOrder")
				.content(content).contentType(MediaType.APPLICATION_JSON))
				.andReturn().getResponse().getContentAsString();
				;
		log.info("Response Stirng is : " + result);
	}
}
