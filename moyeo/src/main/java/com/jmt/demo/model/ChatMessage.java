package com.jmt.demo.model;

import lombok.Data;

@Data
public class ChatMessage {
    private String content;
    private String userId;
    private String planId;
}