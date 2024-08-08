package com.jmt.demo.controller;

import com.jmt.demo.dao.MessageDAO;
import com.jmt.demo.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private MessageDAO messageDAO;

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public Message handleMessage(Message message) {
        // 메시지를 데이터베이스에 저장
        messageDAO.save(message);

        // 저장된 메시지를 반환하여 구독자에게 전송
        return message;
    }

    // 새로운 API 추가
    @GetMapping("/messages")
    @ResponseBody
    public List<Message> getMessages(@RequestParam("planId") Long planId) {
        // 특정 planId에 해당하는 메시지를 데이터베이스에서 조회
        return messageDAO.findByPlanId(planId);
    }
}