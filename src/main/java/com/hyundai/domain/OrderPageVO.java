package com.hyundai.domain;

import lombok.Data;


/**
 * @packageName		: com.hyundai.domain
 * @fileName		: OrderPageVO
 * @author			: 고석준
 * @description		: 주문페이지에서 사용되는 상품의 정보를 담는 클래스
 */
@Data
public class OrderPageVO {
	private int psid;
	private String pname;
	private String bname;
	private String pccolorcode;
	private String pcchipimg;
	private int pcprice;
	private String psize;
	private int pquantity;
}

