package com.hyundai.domain;

import java.util.Date;

import lombok.Data;

/**
 * @packageName 	: com.hyundai.domain
 * @fileName 		: MemberVO.java
 * @author 			: 황명하
 * @description 	: 사용자에 대한 정보를 담는 VO객체
 */
@Data
public class MemberVO {

	private String mid;
	private String mpassword;
	private Date mbirth;
	private String mname;
	private String memail;
	private String mphone;
	private String mtel;
	private String mzipcode;
	private String maddress1;
	private String maddress2;
	private int mgender;
	private String mrefid;
	private String mlogintype;
	private int mtosno;
	private int menable;
	private String mrole;
	private int mgrade;
	private int mmileage;
}
