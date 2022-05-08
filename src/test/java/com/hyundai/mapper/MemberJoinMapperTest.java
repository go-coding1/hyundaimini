package com.hyundai.mapper;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import lombok.extern.log4j.Log4j;


/**
 * @packageName		: (test) com.hyundai.mapper
 * @fileName		: MemberJoinMapperTest.java
 * @author			: 황명하
 * @description		: 회원가입에 필요한 기능들(아아디, 이메일, 전화번호 중복확인, 회원등록)을 위한 매퍼 테스트
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberJoinMapperTest {

	@Autowired
	private MemberJoinMapper memberJoinMapper;
	
	//아이디 중복 확인 (황명하)
	@Test
	public void testDuplid() {		
		int cnt = memberJoinMapper.duplid("ghkd2676");
		if(cnt == 1) log.info("이미 있는 아이디");
		else log.info("기존에 없는 아이디");
	}

	//이메일 중복 확인 (황명하)
	@Test
	public void testDuplemail() {
		int cnt = memberJoinMapper.duplemail("ghkd2676@naver.com");
		if(cnt == 1) log.info("이미 있는 이메일");
		else log.info("기존에 없는 이메일");
	}

	//전화번호 중복 확인 (황명하)
	@Test
	public void testDuplpn() {
		int cnt = memberJoinMapper.duplpn("01084342676");
		if(cnt == 1) log.info("이미 있는 전화번호");
		else log.info("기존에 없는 전화번호");
	}

}
