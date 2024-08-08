package com.jmt.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * WebController :
 *  웹 어플리케이션의 URL 요청 처리
 *  회원가입 페이지, 로그인 페이지로 이동 담당
 */
@Controller
public class WebController {
	/**
	 * /registerPage URL로 GET 요청 처리
	 * 사용자가 회원 가입 페이지로 이동하게 함
	 * @return registerPage.jsp 뷰 반환
	 */
	@GetMapping("/registerPage")
	public String registerPage() {
		return "registerPage";
	}

	/**
	 * / {루트} URL로 GET 요청 처리
	 * 사용자가 로그인 페이지로 이동하게 함
	 * @return login.jsp 뷰를 반환
	 */
	@GetMapping("/")
	public String login() {
		return "login";
	}
}
