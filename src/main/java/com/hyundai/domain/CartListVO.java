package com.hyundai.domain;

import java.util.List;

import lombok.Data;

/**
 * @packageName		: com.hyundai.domain
 * @fileName		: CartListVO
 * @author			: 고석준
 * @description		: 장바구니에 담기는 상품들의 정보를 ajax로 받기위한 VO객체
					  ajax에서 [] 배열 형태로 CartVO가 넘어와 이런식으로 객체를 만듦
 */
@Data
public class CartListVO {
	private List<CartVO> list;
}
