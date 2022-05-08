package com.hyundai.service;

import java.util.List;

import com.hyundai.domain.CartVO;

/**
 * @packageName		: com.hyundai.service
 * @fileName		: CartService
 * @author			: 고석준
 * @description		: 장바구니와 관련된 로직을 처리하기 위한 서비스 인터페이스
 */
public interface CartService {
	//전체 장바구니 목록 조회 함수
	public List<CartVO> getList();
	//사용자의 장바구니 목록 조회 함수
	public List<CartVO> getList(String mid);
	//장바구니의 수량을 수정하는 함수
	public int updateCart(CartVO cartVO);
	//장바구니의 상품을 삭제하는 함수
	public int deleteCart(List<CartVO> cartList);
	//상품을 장바구니에 담는 요청 함수
	public int insertCart(CartVO cartVO);
	
}
