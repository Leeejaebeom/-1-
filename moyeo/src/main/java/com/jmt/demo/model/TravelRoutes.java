package com.jmt.demo.model;

import lombok.Data;
@Data
public class TravelRoutes {

	private Long route_id;
	private Long plan_id;
	private  String	location;
	private int day;
	private int order;
	  private Double lat; // 위도 추가
	    private Double lng; // 경도 추가
	
}
