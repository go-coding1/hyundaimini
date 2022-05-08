package com.hyundai.mapper;

import java.sql.Date;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hyundai.domain.JoinFormVO;

/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: MemberJoinMapper.java
 * @author			: 황명하
 * @description		: 회원가입에 필요한 기능들(아아디, 이메일, 전화번호 중복확인, 회원등록)을 위한 SQL문 메소드를 모아둔 인터페이스
 */
@Mapper
public interface MemberJoinMapper {
	//아이디 중복 확인 (황명하)
	public int duplid(String id);
	
	//이메일 중복 확인 (황명하)
	public int duplemail(String email);
	
	//회원등록 진행 (황명하)
	public void register(@Param("joinform")JoinFormVO joinform,@Param("j_phonenum")String j_phonenum, @Param("j_email")String j_email, 
			@Param("j_tosno")int j_tosno, @Param("j_gender")int j_gender, @Param("j_birth")Date j_birth);
	
	//전화번호 중복 확인 (황명하)
	public int duplpn(String pn);
	
}
