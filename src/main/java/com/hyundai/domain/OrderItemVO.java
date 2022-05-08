package com.hyundai.domain;

import lombok.Data;


/**
 * @packageName		: com.hyundai.domain
 * @fileName		: OrderItemVO
 * @author			: 고석준
 * @description		: 주문한 상품의 정보를 담는 클래스. ORDER_ITEM 클래스와 매핑됨.
 */
@Data
public class OrderItemVO {
	private int psid;
	private int oid;
	private int oicount;
	private int oitotalprice;
	
	private String pname;
	private String ostatus;
	private String mid;
	
}
