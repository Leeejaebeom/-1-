package com.jmt.demo.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.jmt.demo.model.KakaoAuthResponse;
import com.jmt.demo.model.KakaoTokenResponse;
import com.jmt.demo.util.RestApiUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class KakaoService {
	
	private static final String APPKEY = "6baf27b23a6cbebe6ed59e076043de39";
	
	// 토큰 발급 기능
	public KakaoTokenResponse getToken(KakaoAuthResponse response) {
		String url = "https://kauth.kakao.com/oauth/token";
		
		HashMap<String, String > headerData = new HashMap<String, String>();
		headerData.put("Content-type", "application/x-www-form-urlencoded;charset=UTF-8");
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("grant_type", "authorization_code");
		data.put("client_id", APPKEY);
		data.put("redirect_uri", "http://localhost:8090/oauth");
		data.put("code", response.getCode());
		
		KakaoTokenResponse result = RestApiUtil.ConnHttpGetType(url, data, headerData, KakaoTokenResponse.class);
		
		log.info("token 발급: "+result);
		
		return result;
	}
	
}
