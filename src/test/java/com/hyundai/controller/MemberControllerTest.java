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


import lombok.extern.log4j.Log4j;

/**
 * @packageName		: (test) com.hyundai.controller
 * @fileName		: MemberControllerTest.java
 * @author			: 황명하
 * @description		: 사용자의 로그인, 로그아웃 기능과 회원가입 관련 기능들(아이디, 전화번호, 이메일 중복학인)테스트 및 관련 페이지 이동 구현 테스트
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class MemberControllerTest {

	@Autowired
	MemberController memberController;
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();		
	}//end setup
	
	//로그인 페이지 이동 테스트 (황명하)
	@Test
	public void testLogin() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.get("/member/login")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("member/login",pageName);
	}

	//로그인 로직 테스트 (황명하) 
	@Test
	public void testLoginaction() throws Exception {
		String pageName =  mockMvc.perform(
				MockMvcRequestBuilders.post("/member/loginaction")
				.param("mid", "ksj").param("mpassword", "ksj")				
				).andReturn().getResponse().getContentAsString();
		//유저세션이 없는 경우는 "fail" 반환, 유저세션이 있는 경우는 MemberVO객체 반환
		assertNotEquals("fail", pageName);
	}

	//마이페이지 이동 테스트(황명하) 
	@Test
	public void testMypage() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.get("/member/mypage")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("member/mypage",pageName);
	}

	//쿠폰페이지 이동 테스트(황명하) 
	@Test
	public void testVoucher() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.get("/member/voucher")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("member/voucher",pageName);
	}

	
	//로그아웃 수행 테스트 (황명하) 
	@Test
	public void testLogout() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.get("/member/logout")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("redirect:/",pageName);
	}

	// 회원가입 - 약관 동의 페이지 이동 테스트 (황명하)
	@Test
	public void testJoinprovision() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.get("/member/joinprovision")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("member/joinprovision",pageName);
	}

	// 회원가입 - 회원정보 입력 페이지 이동 테스트(황명하)
	@Test
	public void testJoininfoform() throws Exception {
		String pageName = mockMvc.perform(
				MockMvcRequestBuilders.post("/member/joininfoform")				
				).andReturn().getModelAndView().getViewName();
		assertEquals("member/joininfoform",pageName);
	}

	// 회원가입폼 - 아이디 중복확인 테스트(황명하)
	@Test
	public void testIsduplid() throws Exception {
		
		String duplIdChek =  mockMvc.perform(
				MockMvcRequestBuilders.get("/member/isduplid")
				.param("id", "gogack11")				
				).andReturn().getResponse().getContentAsString();
		//아이디가 중복되지 않는 경우 "false" 반환, 아이디가 중복되는 경우 "true" 반환
		assertEquals("false", duplIdChek);
		
	}

	// 회원가입폼 - 전화번호 중복확인 테스트 (황명하)
	@Test
	public void testIsduplpn() throws Exception {

		String duplPNChek =  mockMvc.perform(
				MockMvcRequestBuilders.get("/member/isduplpn")
				.param("pn", "01099998888")				
				).andReturn().getResponse().getContentAsString();
		//전화번호가 중복되지 않는 경우 "false" 반환, 전화번호가 중복되는 경우 "true" 반환
		assertEquals("false", duplPNChek);
	}

	// 회원가입폼 - 이메일 중복확인 테스트 (황명하)
	@Test
	public void testIsduplemail() throws Exception {

		String duplEmailCheck =  mockMvc.perform(
				MockMvcRequestBuilders.get("/member/isduplemail")
				.param("email", "ghkd2676@naver.com")				
				).andReturn().getResponse().getContentAsString();
		//이메일이 중복되지 않는 경우 "false" 반환, 이메일이 중복되는 경우 "true" 반환
		assertEquals("false", duplEmailCheck);
	}

}
