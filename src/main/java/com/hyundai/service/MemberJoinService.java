package com.hyundai.service;

import java.sql.Date;

import com.hyundai.domain.JoinFormVO;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: MemberJoinService.java
 * @author			: 황명하
 * @description		:회원가입에 필요한 기능들(아이디, 이메일, 전화번호 중복확인, 회원등록)을 호출하는 서비스 인터페이스
 */
public interface MemberJoinService {
	
	//아이디 중복 확인 (황명하)
	public int duplidCheck(String id);

	//회원등록 진행 (황명하)
	public void registerStart(JoinFormVO joinform,String j_phonenum, String j_email, int j_tosno, int j_gender, Date j_birth);

	//이메일 중복 확인 (황명하)
	public int duplemailCheck(String email);

	//전화번호 중복 확인 (황명하)
	public int duplpnCheck(String pn);
}
