package com.hyundai.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.hyundai.domain.MemberVO;
import lombok.extern.log4j.Log4j;


/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: MemberLoginMapperTest.java
 * @author			: 황명하
 * @description		: 로그인, 회원 정보 획득을 위한 매퍼 테스트
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberLoginMapperTest {

	@Autowired
	private MemberLoginMapper memberLoginMapper; 
	
	// 사용자 로그인  (황명하)
	@Test
	public void testLogin() {
		int cnt = memberLoginMapper.login("ksj", "ksj");
		if(cnt == 1) log.info("로그인 성공");
		else log.info("로그인 실패");
	}

	// 회원정보 가져오기 (황명하)
	@Test
	public void testGetinfo() {
		try {
			MemberVO memberVO = memberLoginMapper.getinfo("admin");
			log.info(memberVO.getMname()+"의 회원정보 가져옴.");
		}catch(Exception e) {
			log.info("회원정보 가져오기 실패");
		}
	}

}
