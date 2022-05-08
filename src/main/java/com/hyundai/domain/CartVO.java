package com.hyundai.domain;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: CartVO
 * @author			: 고석준
 * @description		: 장바구니에 담길 상품의 정보를 담는 클래스
 */
@Data
public class CartVO {
	private String mid;
	private int psid;
	private int pquantity;
	
	// 브랜드명, 상품이름, 상품컬러, 상품사이즈,수량, 판매가, 상품사진
	private String bname;
	private String pname;
	private String pccolorcode;
	private String psize;
	private int pcprice;
	private String pcchipimg;
	
	@Override
	public String toString() {
		System.out.println("call toString of CartVO");
		return "CartVO( mid : " +mid + ", psid : " + psid + ", pquantity : "+ pquantity +
				"bname : " + bname +", pname : " + pname + ", pcolorcode : "+pccolorcode + ", psize : "+psize + ", pcprice : " + pcprice + ", pcchipimg : " + pcchipimg +    
				")";
	}
}
