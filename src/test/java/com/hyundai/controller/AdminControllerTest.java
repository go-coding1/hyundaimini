package com.hyundai.controller;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.hyundai.domain.MemberVO;

import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.controller
 * @fileName		: AdminControllerTest.java
 * @author			: 황명하
 * @description		: 관리자 계정으로 로그인 시 관리자 페이지에 접근 가능하게 하는 기능 테스트
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class AdminControllerTest {

	@Autowired
	CartController cartController;
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();		
	}//end setup
	
	//관리자 마이페이지 이동 테스트(황명하) 
	@Test
	public void testAdminpage() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.get("/admin/adminpage")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("admin/adminpage",pageName);
	}

}
