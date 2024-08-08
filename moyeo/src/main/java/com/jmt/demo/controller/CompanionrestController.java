package com.jmt.demo.controller;

import com.jmt.demo.dao.CompanionDAO;
import com.jmt.demo.dto.CompanionRequestDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/companions")
public class CompanionrestController {

    @Autowired
    private CompanionDAO companionDao;

    @GetMapping("/requests")
    public List<CompanionRequestDto> getCompanionRequests(@RequestParam Long userId) {
        return companionDao.findRequestsByUserId(userId);
    }

    @PostMapping("/approve")
    public Map<String, Object> approveRequest(@RequestBody Map<String, Long> data) {
        Long companionId = data.get("companionId");
        boolean success = companionDao.approveRequest(companionId);
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        return response;
    }
}
