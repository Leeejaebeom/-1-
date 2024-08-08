package com.jmt.demo.controller;

import com.jmt.demo.dao.MessageDAO;
import com.jmt.demo.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/messages")
public class MessageController {

    @Autowired
    private MessageDAO messageDAO;

    @GetMapping("/plan/{planId}")
    public List<Message> getMessagesByPlanId(@PathVariable Long planId) {
        return messageDAO.findByPlanId(planId);
    }
}