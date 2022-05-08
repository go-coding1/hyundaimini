package com.hyundai.mapper;

import java.util.List;

import com.hyundai.domain.CartVO;

/**
 * @packageName		: com.hyundai.mapper
 * @fileName		: CartMapper
 * @author			: 고석준
 * @description		: Cart테이블과 관련된 SQL요청을 처리하는 Mybatis 인터페이스
 */
public interface CartMapper {
	//로그인한 사용자의 장바구니 정보를 가져오는 함수
	public List<CartVO> getList(String mid);
	//장바구니에 새로운 상품을 넣는 함수
	public int insertCart(CartVO cartVO);
	//장바구니에 담긴 상품의 수량을 변경하는 함수
	public int updateCart(CartVO cartVO);
	//장바구니 상품 삭제 함수
	public int deleteCart(List<CartVO> cartList);
}
