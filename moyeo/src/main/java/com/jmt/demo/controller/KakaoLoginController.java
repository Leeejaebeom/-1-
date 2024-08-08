package com.jmt.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.jmt.demo.model.KakaoAuthResponse;
import com.jmt.demo.model.KakaoTokenResponse;
import com.jmt.demo.service.KakaoService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoLoginController {

private boolean isLogin = false; // 로그인 상태 나타내는 변수

	@Autowired
	KakaoService kakaoService;

	@GetMapping("/kakaologin")
	public String login() {
		return "redirect:https://kauth.kakao.com/oauth/authorize?client_id=6baf27b23a6cbebe6ed59e076043de39&redirect_uri=http://localhost:8080/oauth&response_type=code";
	}


	@GetMapping("/oauth")
	public String oauthResult(KakaoAuthResponse response, HttpSession session, KakaoService kakaoservice) {
		log.info("{oauthResult code: }"+response.getCode());
		KakaoTokenResponse token = kakaoservice.getToken(response);
		System.out.println(token);
		if(token != null && token.getAccess_token()!=null) {
			// 토큰 정상 발급
			isLogin = true;
			// 모델에 로그인 상태를 저장하여 결과적으로 login.jsp에 전달
			session.setAttribute("isLogin",isLogin);
		}
		return "redirect:/registerPageforKakao";
	}


	@GetMapping("/logout")
	public String logout(KakaoAuthResponse response, HttpSession session) {

			isLogin = false;

			session.setAttribute("isLogin",isLogin);

			session.invalidate();

			return "redirect:/";
	}
}
