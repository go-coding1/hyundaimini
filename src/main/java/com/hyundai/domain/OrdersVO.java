package com.hyundai.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: OrdersVO
 * @author			: 고석준
 * @description		: 주문페이지에서 사용되는 주문의 정보를 담는 클래스. ORDERS 테이블과 매핑됨
 */
@Data
public class OrdersVO {
	private int oid;
	private String oaddress1;
	private String oreceiver;
	private String ophone;
	private String otel;
	private String omemo;
	private String oemail;
	private int obeforeprice;
	private int oafterprice;
	private String ostatus;
	private String mid;
	private String pmcode;
	private Date odate;
	private String oaddress2;
	
	private List<OrderItemVO> orderItemList;
}
