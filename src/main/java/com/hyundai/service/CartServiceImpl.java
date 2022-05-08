package com.hyundai.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hyundai.domain.CartVO;
import com.hyundai.mapper.CartMapper;


/**
 * @packageName		: com.hyundai.service
 * @fileName		: CartService
 * @author			: 고석준
 * @description		: 장바구니와 관련된 로직을 처리하기 위한 서비스 구현체 클래스
 */
@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartMapper cartMapper;
	
	//전체 장바구니 목록 조회 함수
	@Override
	public List<CartVO> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	//사용자의 장바구니 목록 조회 함수
	@Override
	public List<CartVO> getList(String mid) {
		// TODO Auto-generated method stub
		List<CartVO> cartList = cartMapper.getList(mid);
		
		return cartList;
	}

	//장바구니의 수량을 수정하는 함수
	@Override
	public int updateCart(CartVO cartVO) {
		// TODO Auto-generated method stub
		return cartMapper.updateCart(cartVO);
		
	}

	//장바구니의 상품을 삭제하는 함수
	@Override
	public int deleteCart(List<CartVO> cartList) {
		// TODO Auto-generated method stub
		return cartMapper.deleteCart(cartList);
	}

	//상품을 장바구니에 담는 요청 함수
	@Override
	public int insertCart(CartVO cartVO) {
		// TODO Auto-generated method stub
		return cartMapper.insertCart(cartVO);
	}

}
