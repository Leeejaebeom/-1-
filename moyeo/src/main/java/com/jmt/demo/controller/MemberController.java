package com.jmt.demo.controller;

import com.jmt.demo.dao.TravelPlanDao;
import com.jmt.demo.dao.UserDAO;
import com.jmt.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * MemberController :
 *  사용자 회원가입 및 로그인 처리
 *  사용자 정보를 데이터베이스에 저장, 로그인 시 인증 수행
 */
@Controller
public class MemberController {
    // UserDAO를 통해 데이터베이스와 상호작용
    @Autowired
    private UserDAO userDAO;

    @Autowired
    private TravelPlanDao travelPlanDao;

    // 비밀번호 암호화를 위해 인스턴스 생성
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    /**
     * /register URL에 대해 POST 요청
     * 새로운 사용자를 데이터베이스에 등록, 로그인 페이지로 리디렉션
     * @param user 사용자 정보를 담고 있는 User 객체
     * @return 홈 페이지로 리디렉션
     */
    @PostMapping("/register")
    public String register(@ModelAttribute User user) {
        // 사용자 정보를 데이터베이스에 저장
        userDAO.save(user);
        // 홈으로 리디렉션
        return "redirect:/";
    }

    /**
     * /login URL에 대해 POST 요청
     * 사용자의 이메일과 비밀번호를 통해 로그인 처리
     *
     * @param email 사용자의 이메일
     * @param password 사용자의 비밀번호
     * @param model 뷰에 데이터를 전달하기 위한 객체
     * @return 로그인 성공 시 홈 페이지로 리디렉션, 실패 시 로그인 페이지로 이동
     */
    @PostMapping("/login")
    public String login(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
        // 이메일로 사용자를 우선 조회
        User user = userDAO.findByEmail(email);
        // 이메일이 존재하고 비밀번호가 일치하는지 확인
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            // 로그인 성공 시 세션에 사용자 정보를 저장한 뒤, 홈 페이지로 리디렉션
            session.setAttribute("loggedUser", user);
            return "redirect:/home";
        } else {
            // 로그인 실패 시 에러 메시지를 모델에 추가한 뒤 로그인 페이지로 이동
            model.addAttribute("error", "잘못된 이메일 혹은 패스워드입니다");
            return "login";
        }
    }
}
