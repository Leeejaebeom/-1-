package com.jmt.demo.controller;

import com.jmt.demo.dao.CompanionDAO;
import com.jmt.demo.model.Companion;
import com.jmt.demo.model.TravelPlan;
import com.jmt.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/home")
public class CompanionController {

    @Autowired
    private CompanionDAO companionDAO;

    /**
     * 동행 신청 메서드
     * @param planId  - 신청할 여행 계획 ID
     * @param session - 현재 세션
     * @return        - 성공/실패 메시지를 포함한 응답 엔터티
     */
    @PostMapping("/requestCompanion")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> requestCompanion(@RequestParam("planId") Long planId, HttpSession session) {
        // 세션에서 로그인한 사용자 정보 가져오기
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("success", false, "message", "로그인이 필요합니다."));
        }

        // planId와 userId로 동행 신청 로직 수행
        if (planId == null) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "planId가 누락되었습니다."));
        }

        // 동행 요청 처리 로직
        // 사용자 ID와 계획 ID로 기존 신청을 확인
        boolean alreadyRequested = companionDAO.existsByUserIdAndPlanId(loggedUser.getUser_id(), planId);
        if (alreadyRequested) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "이미 동행 신청을 하셨습니다.");
            return ResponseEntity.ok(Map.of("success", false, "message", "이미 동행 신청을 하셨습니다."));
        }

        // 새로운 동행 신청 생성 및 저장
        Companion newCompanionRequest = new Companion();
        newCompanionRequest.setUserId(loggedUser.getUser_id());
        newCompanionRequest.setPlanId(planId);
        newCompanionRequest.setAllow(false); // 기본값을 false로 설정

        companionDAO.save(newCompanionRequest);

        Map<String, String> response = new HashMap<>();
        response.put("message", "동행 신청이 완료되었습니다.");
        return ResponseEntity.ok(Map.of("success", true, "message", "동행 신청이 완료되었습니다."));
    }

    @GetMapping("/participatingPlans")
    public String getParticipatingPlans(HttpSession session, Model model) {
        // 세션에서 로그인한 사용자 정보 가져오기
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "login";
        }

        int userId = loggedUser.getUser_id();

        // 사용자에게 허용된 계획 가져오기
        List<TravelPlan> participatingPlans = companionDAO.findAllowedPlansByUserId(userId);
        model.addAttribute("participatingPlans", participatingPlans);

        return "myPlans"; // 적절한 뷰 이름으로 변경 필요
    }
}