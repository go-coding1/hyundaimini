package com.hyundai.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.MemberVO;
import com.hyundai.mapper.MemberLoginMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: LoginServiceImpl.java
 * @author			: 황명하
 * @description		:로그인, 회원정보 획득 기능을 호출하는 서비스
 */
@Log4j
@Service
@AllArgsConstructor
public class LoginServiceImpl implements LoginService {

	@Autowired
	private MemberLoginMapper mapper;
	
	// 사용자 로그인  (황명하)
	@Override
	public int LoginCheck(String mid, String mpassword) {
		// TODO Auto-generated method stub
		
		int cnt = 1;
		cnt = mapper.login(mid, mpassword);
		return cnt;
	}

	// 회원정보 가져오기 (황명하)
	@Override
	public MemberVO getInfoStart(String mid) {
		// TODO Auto-generated method stub
		return mapper.getinfo(mid);
	}

}
