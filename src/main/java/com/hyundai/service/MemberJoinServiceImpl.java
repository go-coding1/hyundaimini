package com.hyundai.service;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.JoinFormVO;
import com.hyundai.mapper.MemberJoinMapper;
import lombok.AllArgsConstructor;


/**
 * @packageName		: com.hyundai.service
 * @fileName		: MemberJoinServiceImpl.java
 * @author			: 황명하
 * @description		:회원가입에 필요한 기능들(아이디, 이메일, 전화번호 중복확인, 회원등록)을 호출하는 서비스
 */
@Service
@AllArgsConstructor
public class MemberJoinServiceImpl implements MemberJoinService {

	@Autowired
	private MemberJoinMapper mapper;
	
	//아이디 중복 확인 (황명하)
	@Override
	public int duplidCheck(String id) {
		// TODO Auto-generated method stub
		int cnt = mapper.duplid(id);
		return cnt;
	}

	//회원등록 진행 (황명하)
	@Override
	public void registerStart(JoinFormVO joinform, String j_phonenum, String j_email, int j_tosno, int j_gender, Date j_birth) {
		mapper.register(joinform, j_phonenum, j_email, j_tosno, j_gender, j_birth);
	}

	//이메일 중복 확인 (황명하)
	@Override
	public int duplemailCheck(String email) {
		// TODO Auto-generated method stub\
		int cnt = mapper.duplemail(email);
		return cnt;
	}

	//전화번호 중복 확인 (황명하)
	@Override
	public int duplpnCheck(String pn) {
		// TODO Auto-generated method stub
		int cnt = mapper.duplpn(pn);
		return cnt;
	}

	
}
