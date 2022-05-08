package com.hyundai.service;

import com.hyundai.domain.MemberVO;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: LoginService.java
 * @author			: 황명하
 * @description		:로그인, 회원정보 획득 기능을 호출하는 서비스 인터페이스
 */
public interface LoginService {
	// 사용자 로그인  (황명하)
	public int LoginCheck(String mid, String mpassword);

	// 회원정보 가져오기 (황명하)
	public MemberVO getInfoStart(String mid);
	
}
