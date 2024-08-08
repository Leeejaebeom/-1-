package com.jmt.demo.controller;

import com.jmt.demo.model.Page;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import java.util.List;

@Component
public class pageController {
    /**
     * 페이징 처리 메서드
     * @param model      - 뷰에 데이터를 전달하는 모델 객체
     * @param pageNum    - 현재 페이지 번호, 초기값 1
     * @param list       - 페이징을 처리할 전체 데이터 리스트
     * @param <T>        - 리스트 타입
     */
    public <T> void paging(Model model, Integer pageNum, List<T> list) {
        // 전체 데이터의 개수 계산
        int total = list.size();
        // 현재 페이지 번호 설정, null인 경우 1페이지로 설정
        int currentPage;
        if (pageNum == null) currentPage = 1;
        else currentPage = pageNum;

        // 페이지 객체 생성 후 현재 페이지와 전체 페이지 설정
        Page page = new Page(currentPage, total);

        // 모델에 페이지 객체 추가 후 뷰에 전달
        model.addAttribute("page", page);
    }
}
