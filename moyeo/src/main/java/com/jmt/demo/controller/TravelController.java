package com.jmt.demo.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.jmt.demo.dao.CompanionDAO;
import com.jmt.demo.dao.UserDAO;
import com.jmt.demo.model.Companion;
import com.jmt.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jmt.demo.dao.TravelPlanDao;
import com.jmt.demo.dao.TravelRoutesDAO;
import com.jmt.demo.model.TravelPlan;
import com.jmt.demo.model.TravelRoutes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/home")
public class TravelController {

    @Autowired
    private TravelPlanDao travelPlanDao;

    @Autowired
    private TravelRoutesDAO travelRoutesDAO;

    @Autowired
    private UserDAO userDao;

    @Autowired
    private pageController pageController;

    @Autowired
    private CompanionDAO companionDAO;

    /**
     * 해당 부분 조금 아쉽습니다. RequestParam도 괜찮지만, 전에 했던 방식처럼 model을 가져오면 훨씬 가독성이 좋은
     * 코드가 될 것 같습니다. 이 부분만 한 번 수정해볼까요?
     * Register 말고 수정, 삭제는 model을 이용해 코드를 작성했으니 참고하면 좋을거같습니다 :)
     */
    @Transactional
    @PostMapping("/registerTravelRoute")
    public String planRegister(@RequestParam("title") String title,
                               @RequestParam("description") String description,
                               @RequestParam("start_date") String startDate,
                               @RequestParam("end_date") String endDate,
                               @RequestParam(value = "selected_places", required = false) String selectedPlacesJson,
                               Model model, HttpSession session) throws java.text.ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        // 세션에서 현재 로그인한 사용자 정보 가져오기
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            System.out.println("세션 존재하지 않음");
            return "login";
        }

        // 이 이후론 세션에 사용자 정보가 있으니, 새로운 TravelPlan 생성
        TravelPlan travelPlan = new TravelPlan();
        travelPlan.setTitle(title);
        travelPlan.setDescription(description);
        travelPlan.setStart_date(formatter.parse(startDate));
        travelPlan.setEnd_date(formatter.parse(endDate));
        // 세션에서 가져온 사용자 ID를 설정
        travelPlan.setUser_id(loggedUser.getUser_id());

        List<TravelRoutes> travelRoutesList = new ArrayList<>();

        // selected_places JSON 파싱
        if (selectedPlacesJson != null && !selectedPlacesJson.isEmpty()) {
            System.out.println("Received selectedPlacesJson: " + selectedPlacesJson); // 디버그 로그 추가
            Gson gson = new Gson();
            List<Map<String, String>> selectedPlaces = gson.fromJson(selectedPlacesJson, new TypeToken<List<Map<String, String>>>(){}.getType());

            // TravelRoutes 리스트 생성
            for (int i = 0; i < selectedPlaces.size(); i++) {
                Map<String, String> place = selectedPlaces.get(i);
                TravelRoutes travelRoute = new TravelRoutes();
                travelRoute.setLocation(place.get("place_name") + " (" + place.get("place_lat") + ", " + place.get("place_lng") + ")");
                travelRoute.setDay(1);  // 필요한 값으로 설정
                travelRoute.setOrder(i + 1);  // 순서 설정
                travelRoutesList.add(travelRoute);
                System.out.println("Added route: " + travelRoute.getLocation());  // 디버그 로그 추가
            }
        }


        // TravelPlan과 TravelRoutes 저장
        Long planId = travelPlanDao.save(travelPlan, travelRoutesList);

        // 작성자를 동행자로 자동 등록 및 승인
        Companion companion = new Companion();
        companion.setUserId(loggedUser.getUser_id());
        companion.setPlanId(planId);
        companion.setMessage("작성자");
        companion.setAllow(true); // 자동 승인
        companionDAO.save(companion);

        return "redirect:/home";
    }

    /**
     * 특정 여행 계획 경로 조회 메서드
     * @param planId  - 조회할 여행 계획 ID
     * @return        - 해당 여행 계획의 경로 리스트
     */
    @GetMapping("/getTravelRoutes")
    @ResponseBody
    public List<TravelRoutes> getTravelRoutes(@RequestParam("plan_id") Long planId) {
        System.out.println("Received planId: " + planId); // 디버그 로그 추가
        List<TravelRoutes> travelRoutes = travelRoutesDAO.findByPlanId(planId);
        System.out.println("Retrieved travelRoutes: " + travelRoutes); // 디버그 로그 추가
        return travelRoutes;
    }

    /**
     * 여행 계획 검색 메서드
     * @param model    - 뷰에 데이터를 전달
     * @param keyword  - 검색 키워드
     * @param pageNum  - 현재 페이지 번호
     * @return         - 검색 결과 페이지
     */
    @GetMapping("/joinSearch")
    public String JoinSearch(Model model, @RequestParam(required = false) String keyword, @RequestParam(required = false) Integer pageNum) {
        List<TravelPlan> travelPlanList;
        if (keyword == null || keyword.trim().isEmpty()) {
            // 빈칸 또는 null일 경우 모든 게시물을 검색
            travelPlanList = travelPlanDao.findAll();
        } else {
            // 키워드가 있을 경우 키워드로 검색
            travelPlanList = travelPlanDao.PlanSearch(keyword);
        }
        model.addAttribute("travelPlanList", travelPlanList);

        List<User> userList = userDao.allUsers();
        model.addAttribute("userList", userList);

        pageController.paging(model, pageNum, travelPlanList);
        model.addAttribute("keyword", keyword);
        return "searchResults";
    }

    /**
     * 여행 계획 수정 메서드
     * @param travelPlan - 수정할 여행 계획 객체
     * @param session    - 현재 세션
     * @param model      - 뷰에 데이터를 전달하는 모델
     * @return           - 홈 페이지로 리다이렉트
     * @throws java.text.ParseException 날짜 파싱 예외
     */
    @GetMapping("/planEdit")
    public String JoinEdit(@ModelAttribute TravelPlan travelPlan, HttpSession session, Model model) throws java.text.ParseException {
        // 세션에서 로그인한 사용자 정보 가져오기
        User loggedUser = (User) session.getAttribute("loggedUser");
        if(loggedUser == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "login";
        }
        // 수정하려는 계획 조회
        TravelPlan existingTravelPlan = travelPlanDao.findById(travelPlan.getPlan_id());
        // 조회 결과가 없다면 home으로 리다이렉트
        if(existingTravelPlan == null) {
            model.addAttribute("error", "유효하지 않는 여행 계획입니다");
            return "redirect:/home";
        }

        // 현재 사용자가 작성자인지 확인 후 일치하지 않다면 home으로 리다이렉트
        if (!existingTravelPlan.getUser_id().equals(loggedUser.getUser_id())) {
            model.addAttribute("error", "수정 권한이 없습니다.");
            return "redirect:/home";
        }

        // 여행 계획 업데이트
        travelPlanDao.update(travelPlan);
        return "redirect:/home";
    }

    /**
     * 여행 계획 삭제 메서드
     * @param planId   - 삭제할 여행 계획 ID
     * @param session  - 현재 세션 객체
     * @param model    - 뷰에 데이터를 전달하는 모델
     * @return         - 홈 페이지로 리다이렉트
     * @throws java.text.ParseException 날짜 파싱 예외
     */
    @GetMapping("/planDelete")
    public String JoinDelete(@RequestParam("plan_id") Long planId, HttpSession session, Model model) throws java.text.ParseException {
        // 세션에서 로그인한 사용자 정보 가져오기
        User loggedUser = (User) session.getAttribute("loggedUser");
        if(loggedUser == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "login";
        }

        // 계획 조회
        TravelPlan travelPlan = travelPlanDao.findById(planId);
        if(travelPlan == null) {
            model.addAttribute("error", "유효하지 않는 여행 계획입니다");
            return "redirect:/home";
        }

        // 현재 사용자가 작성자인지 확인 후 일치하지 않다면 home으로 리다이렉트
        if (!travelPlan.getUser_id().equals(loggedUser.getUser_id())) {
            model.addAttribute("error", "삭제 권한이 없습니다.");
            return "redirect:/home";
        }
        travelPlanDao.delete(planId);
        return "redirect:/home";
    }

    @GetMapping("/loadMoreTravelPlans")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> loadMoreTravelPlans(@RequestParam(value = "page", defaultValue = "1") int page,
                                                                   @RequestParam(value = "size", defaultValue = "10") int size) {
        int offset = (page - 1) * size;
        List<TravelPlan> travelPlans = travelPlanDao.getTravelPlans(offset, size);
        int totalCount = travelPlanDao.getTravelPlansCount();
        int totalPages = (int) Math.ceil((double) totalCount / size);

        // 필터링하여 plan_id가 null이 아닌 항목만 포함
        List<TravelPlan> filteredTravelPlans = travelPlans.stream()
                .filter(plan -> plan.getPlan_id() != null)
                .collect(Collectors.toList());

        Map<String, Object> response = new HashMap<>();
        response.put("travelPlanList", filteredTravelPlans);
        response.put("totalPages", totalPages);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/travelPlans")
    public String getTravelPlans(@RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "size", defaultValue = "10") int size,
                                 Model model) {
        int offset = (page - 1) * size;
        List<TravelPlan> travelPlans = travelPlanDao.getTravelPlans(offset, size);
        int totalCount = travelPlanDao.getTravelPlansCount();
        int totalPages = (int) Math.ceil((double) totalCount / size);

        model.addAttribute("travelPlans", travelPlans);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "travelPlans";
    }
}
