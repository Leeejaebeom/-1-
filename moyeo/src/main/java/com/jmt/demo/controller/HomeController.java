package com.jmt.demo.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import com.jmt.demo.dao.*;
import com.jmt.demo.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


/**
 * HomeController :
 *  홈 페이지와 관련된 요청을 처리하는 컨트롤러
 *  같이 갈래? 메뉴 관련 기능은 TravelController로 이동
 */
@Controller
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	private QaDAO QaDao;

	@Autowired
	private UserDAO userDao;

	@Autowired
	private CompanionDAO companionDao;
	
	@Autowired
    private TravelPlanDao travelPlanDao;

	@Autowired
	private pageController pageController;
	
	@Autowired 
	private FaqDAO faqDAO;

	@GetMapping
	public String showView(Model model, Integer pageNum, HttpSession session) {
		
		List<User> userList = userDao.allUsers();
		model.addAttribute("userList", userList);
		List<TravelPlan> travelPlanList = travelPlanDao.findAll();
        model.addAttribute("travelPlanList", travelPlanList);
        List<Qa> qaList = QaDao.findQa();
		model.addAttribute("qaList", qaList);
		List<Faq> FaqList = faqDAO.findFaq();
		model.addAttribute("FaqList", FaqList);
		
		pageController.paging(model, pageNum, travelPlanList);

		// 세션에서 로그인한 사용자 정보 가져오기
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null) {
			model.addAttribute("error", "로그인이 필요합니다.");
			return "login";
		}

		int userId = loggedUser.getUser_id();

		// 사용자에게 허용된 계획 가져오기
		List<TravelPlan> participatingPlans = companionDao.findAllowedPlansByUserId(userId);
		model.addAttribute("participatingPlans", participatingPlans);

		// 참여 요청 확인
		boolean hasNewParticipationRequests = travelPlanDao.hasNewParticipationRequests(userId);

		model.addAttribute("hasNewParticipationRequests", hasNewParticipationRequests);


		
		return "index";
	}

	// QA 등록
	@GetMapping("/QaRegister")
	public String QaRegister(Qa qa, Model model, HttpSession session) {
		// 세션에서 현재 로그인한 사용자 정보 가져오기
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            System.out.println("세션 존재하지 않음");
            return "login";
        }
        qa.setUser_id(loggedUser.getUser_id());
		QaDao.QaRegister(qa);
		return "redirect:/home";
	}


	@GetMapping("/QaSearch")
	public String QaSearch(Model model, String keyword, Integer pageNum) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return "redirect:/";
		} else {
			List<Qa> qaList = QaDao.QaSearch(keyword);
			model.addAttribute("qaList", qaList);
			List<User> userList = userDao.allUsers();
			model.addAttribute("userList", userList);

			int size = 10;
			int totalCount = QaDao.getSearchCount(keyword);
			int totalPages = (int) Math.ceil((double) totalCount / size);
			model.addAttribute("currentPage", pageNum);
			model.addAttribute("totalPages", totalPages);

			model.addAttribute("keyword", keyword);
			return "index";
		}
	}

	// 새로운 QaSearchAjax 메소드
	@GetMapping("/QaSearchAjax")
	@ResponseBody
	public Map<String, Object> QaSearchAjax(String keyword, Integer pageNum) {
		System.out.println("Keyword: " + keyword);
		System.out.println("Page Number: " + pageNum);

		Map<String, Object> result = new HashMap<>();
		List<Qa> qaList;
		if (keyword == null || keyword.trim().isEmpty()) {
			qaList = QaDao.findQa(); // 전체 Q/A 목록을 반환
		} else {
			qaList = QaDao.QaSearch(keyword); // 키워드로 검색된 Q/A 목록을 반환
		}

		int pageSize = 10;
		int totalPages = (int) Math.ceil((double) qaList.size() / pageSize);
		int currentPage = pageNum != null ? pageNum : 1;
		int startItem = (currentPage - 1) * pageSize;
		List<Qa> paginatedList;
		if (qaList.size() < startItem) {
			paginatedList = Collections.emptyList();
		} else {
			int toIndex = Math.min(startItem + pageSize, qaList.size());
			paginatedList = qaList.subList(startItem, toIndex);
		}
		System.out.println("Paginated List Size: " + paginatedList.size());

		List<Map<String, Object>> qaMapList = paginatedList.stream().map(qa -> {
			Map<String, Object> map = new HashMap<>();
			map.put("qa_id", qa.getQa_id());
			map.put("title", qa.getTitle());
			map.put("question", qa.getQuestion());
			map.put("user_id", qa.getUser_id());
			map.put("created_at", qa.getCreated_at());
			map.put("answer", qa.getAnswer());
			map.put("username", userDao.findUsernameByUserId(qa.getUser_id()));
			return map;
		}).collect(Collectors.toList());
		result.put("qaList", qaMapList);
		result.put("totalPages", totalPages);
		result.put("currentPage", currentPage);

		System.out.println("Result: " + result);
		return result;
	}
	
	@GetMapping("/get-faq-answer")
    @ResponseBody
    public Faq getFaqAnswer(@RequestParam("id") Long id) {
        return faqDAO.findFaqById(id);
    }

}
