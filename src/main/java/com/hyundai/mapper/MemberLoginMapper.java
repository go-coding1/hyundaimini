package com.hyundai.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hyundai.domain.MemberVO;

/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: MemberLoginMapper.java
 * @author			: 황명하
 * @description		: 로그인, 회원정보 획득을 위한 SQL문 메소드를 모아둔 인터페이스
 */
@Mapper
public interface MemberLoginMapper {
	// 사용자 로그인  (황명하)
	public int login(@Param("mid") String mid,
			@Param("mpassword") String mpassword);

	// 회원정보 가져오기 (황명하)
	public MemberVO getinfo(String mid);

}
