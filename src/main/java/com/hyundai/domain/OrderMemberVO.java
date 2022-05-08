package com.hyundai.domain;

import java.sql.Date;

import lombok.Data;


/**
 * @packageName		: com.hyundai.domain
 * @fileName		: OrderMemberVO
 * @author			: 고석준
 * @description		: 주문페이지에서 사용되는 주문자의 정보를 담는 클래스
 */
@Data
public class OrderMemberVO {
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
