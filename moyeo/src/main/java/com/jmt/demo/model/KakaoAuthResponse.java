package com.jmt.demo.model;

import lombok.Data;

@Data
public class KakaoAuthResponse {
	private String code;
	private String error;
	private String error_description;
	private String State;
}
