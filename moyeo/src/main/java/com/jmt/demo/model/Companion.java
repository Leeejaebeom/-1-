package com.jmt.demo.model;

import lombok.Data;

import java.util.Date;

@Data
public class Companion {
    private Long companionId;  // 동행 신청 ID
    private int userId;    // 사용자 ID
    private Long planId;    // 여행 계획 ID
    private String message;    // 동행 메시지
    private boolean isAllow;   // 승인 여부
    private Date createdAt;    // 생성 일자

    private User user;         // 동행 신청한 사용자 정보
    private TravelPlan travelPlan; // 동행 신청이 포함된 여행 계획
}