package com.jmt.demo.dto;

public class MessageDto {
    private String content;
    private Long userId;
    private String username;
    private Long planId;

    public MessageDto(String content, Long userId, String username, Long planId) {
        this.content = content;
        this.userId = userId;
        this.username = username;
        this.planId = planId;
    }

    // Getters and Setters
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getPlanId() {
        return planId;
    }

    public void setPlanId(Long planId) {
        this.planId = planId;
    }
}