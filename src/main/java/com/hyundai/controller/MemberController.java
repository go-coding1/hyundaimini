package com.hyundai.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hyundai.domain.CartVO;
import com.hyundai.domain.JoinFormVO;
import com.hyundai.domain.MemberVO;
import com.hyundai.domain.OrderItemVO;
import com.hyundai.service.LoginService;
import com.hyundai.service.MemberJoinService;
import com.hyundai.service.OrderService;

/**
 * @packageName : com.hyundai.controller
 * @fileName : MemberController.java
 * @author : 황명하
 * @description : 사용자의 로그인, 로그아웃 기능과 회원가입 관련 기능들(아이디, 전화번호, 이메일 중복학인)구현 및 관련 페이지
 *              이동 구현
 */
@Controller
@RequestMapping("/member/*")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	LoginService loginService;
	@Autowired
	MemberJoinService memberJoinService;

	@Autowired
	OrderService orderService;

	// 로그인 페이지 이동 (황명하)
	@GetMapping(value = "/login")
	public String login(HttpServletRequest request, Locale locale, Model model) {
		logger.info("The client locale is {}.", locale);

		return "member/login";
	}

	// 로그인 로직 수행 (황명하)
	@RequestMapping(value = "/loginaction", method = RequestMethod.POST)
	public @ResponseBody Object Loginaction(@RequestParam("mid") String mid,
			@RequestParam("mpassword") String mpassword, HttpSession httpSession) throws Exception {

		// mybatis를 이용해 DB에 해당 아이디와 비밀번호의 유저가 존재하는지 확인 (황명하)
		int count = loginService.LoginCheck(mid, mpassword);

		if (count == 1) { // 해당하는 유저가 있는 경우 (황명하)
			MemberVO memberVO = new MemberVO();
			memberVO = loginService.getInfoStart(mid);
			// 유저에 대한 memberVO를 세션에 저장 (황명하)
			httpSession.setAttribute("user", memberVO);
			return memberVO;

		} else { // 해당하는 유저가 없는 경우 (황명하)
			return "fail";
		}
	}

	// 마이페이지 이동(황명하)
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String Mypage(HttpSession httpSession, Model model) throws Exception {
		MemberVO loginMember = (MemberVO) httpSession.getAttribute("user");
		if (loginMember == null)
			return "redirect:/member/login";
		String mid = loginMember.getMid();

		List<OrderItemVO> orderList = orderService.getOrderList(mid);
		model.addAttribute("orderList", orderList);

		return "member/mypage";
	}

	// 쿠폰페이지 이동 (황명하)
	@RequestMapping(value = "/voucher", method = RequestMethod.GET)
	public String Voucher(HttpSession httpSession) throws Exception {

		return "member/voucher";
	}

	// 로그아웃 수행 (황명하)
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String Logout(HttpSession httpSession) throws Exception {
		// 해당 유저에 대한 세션 삭제
		httpSession.removeAttribute("user");

		return "redirect:/";
	}

	// 회원가입 - 약관 동의 페이지 이동 (황명하)
	@GetMapping(value = "/joinprovision")
	public String joinprovision(HttpServletRequest request) {

		return "member/joinprovision";
	}

	// 회원가입 - 회원정보 입력 페이지 이동 (황명하)
	@PostMapping(value = "/joininfoform")
	public String joininfoform(HttpServletRequest request) {

		return "member/joininfoform";
	}

	// 회원가입폼 - 아이디 중복확인 (황명하)
	@RequestMapping(value = "/isduplid", method = RequestMethod.GET)
	public @ResponseBody Object isduplid(HttpServletRequest request, @RequestParam("id") String id) {

		// mybatis를 이용해 DB에 해당 아이디가 이미 존재하는지 확인 (황명하)
		int count = memberJoinService.duplidCheck(id);

		if (count == 1)
			return "true"; // 해당 아이디가 이미 존재하는 경우(황명하)
		else
			return "false";
	}

	// 회원가입폼 - 전화번호 중복확인 (황명하)
	@RequestMapping(value = "/isduplpn", method = RequestMethod.GET)
	public @ResponseBody Object isduplpn(HttpServletRequest request, @RequestParam("pn") String pn) {

		// mybatis를 이용해 DB에 해당 전화번호가 이미 존재하는지 확인 (황명하)
		int count = memberJoinService.duplpnCheck(pn);

		if (count == 1)
			return "true"; // 해당 전화번호가 이미 존재하는 경우(황명하)
		else
			return "false";
	}

	// 회원가입폼 - 이메일 중복확인 (황명하)
	@RequestMapping(value = "/isduplemail", method = RequestMethod.GET)
	public @ResponseBody Object isduplemail(HttpServletRequest request, @RequestParam("email") String email) {

		// mybatis를 이용해 DB에 해당 이메일이 이미 존재하는지 확인 (황명하)
		int count = memberJoinService.duplemailCheck(email);

		if (count == 1)
			return "true"; // 해당 이메일이 이미 존재하는 경우(황명하)
		else
			return "false";
	}

	// 회원가입 로직 수행(황명하)
	@RequestMapping(value = "/joincomplete", method = RequestMethod.POST)
	public void joincomplete(JoinFormVO joinformVO, HttpSession httpSession, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 회원가입에 필요한 VO 생성 및 세팅
		String id = joinformVO.getId();
		String passwd = joinformVO.getPasswd();
		String j_phonenum = joinformVO.getPhonenum1() + joinformVO.getPhonenum2() + joinformVO.getPhonenum3();
		String j_email = "";
		if (joinformVO.getEmail1() != "") {
			if (joinformVO.getEmail2() == "") {
				j_email = joinformVO.getEmail1() + "@" + joinformVO.getEmail3();
			} else
				j_email = joinformVO.getEmail1() + "@" + joinformVO.getEmail2();
		}
		String marketing = joinformVO.getEmailReceiveYn();
		int j_tosno = 0;
		if (joinformVO.getEmailReceiveYn() != null) {
			j_tosno = 1;
		}
		String name = joinformVO.getName();
		int j_gender = Integer.parseInt(joinformVO.getGender());
		String birth = joinformVO.getBirth1() + "-" + joinformVO.getBirth2() + "-" + joinformVO.getBirth3();
		java.sql.Date j_birth = java.sql.Date.valueOf(birth);
		String zipcode = joinformVO.getZipcode();
		String address1 = joinformVO.getAddress1();
		String address2 = joinformVO.getAddress2();

		// mybatis를 이용해 DB에 새로운 회원정보 삽입 실행 (황명하)
		memberJoinService.registerStart(joinformVO, j_phonenum, j_email, j_tosno, j_gender, j_birth);

		// 회원가입 완료창 띄우기 (황명하)
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('회원가입이 정상적으로 처리되었습니다!');</script>");
		out.println("<script>location.href='/';</script>");
		return;
	}

}
