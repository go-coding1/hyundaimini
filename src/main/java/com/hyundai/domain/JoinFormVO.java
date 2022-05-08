package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: JoinFormVO.java
 * @author			: 황명하
 * @description		: 회원가입에 필요한 정보를 저장하는 VO객체
 */
@Data
public class JoinFormVO {
	private String id;
	private String passwd;
	
	private String phonenum1;
	private String phonenum2;
	private String phonenum3;
	
	private String zipcode;
	private String address1;
	private String address2;
	
	private String email1;
	private String email2;
	private String email3;
	private String emailReceiveYn;
	
	private String name;
	//성별 0:미선택 1:남성 2:여성 3:중성
	private String gender;
	
	private String birth1;
	private String birth2;
	private String birth3;
	
	
}
