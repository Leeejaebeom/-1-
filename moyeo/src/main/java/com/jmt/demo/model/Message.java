package com.jmt.demo.model;

import lombok.Data;

@Data
public class Message {
    private int messageId;
    private int userId;
    private String content;
    private int planId;
}