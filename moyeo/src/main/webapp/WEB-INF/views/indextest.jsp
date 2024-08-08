<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>사이드메뉴바</title>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a548dc6d5b22802d185f641807cca585&libraries=services"></script>
  <script type="text/javascript" nonce="66acc900cb1c4fd2a18bdd5ffaa" src="//local.adguard.org?ts=1720928620135&amp;type=content-script&amp;dmn=cdn.discordapp.com&amp;url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F1258306481095446549%2F1261241015386378310%2Findex.html%3Fex%3D669437fa%26is%3D6692e67a%26hm%3D13edde3ef5a03ce233ae050926299435a7df05f3ebe86964da07ca0b11ff1a65%26&amp;app=com.google.Chrome&amp;css=3&amp;js=1&amp;rel=1&amp;rji=1&amp;sbe=1"></script>
  <script type="text/javascript" nonce="66acc900cb1c4fd2a18bdd5ffaa" src="//local.adguard.org?ts=1720928620135&amp;name=AdGuard%20Extra&amp;type=user-script"></script>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css'>
  <!-- 예찬 css -->
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css'>
  <style>
    :root {
      --background: #9c88ff;
      --navbar-width: 256px;
      --navbar-width-min: 80px;
      --navbar-dark-primary: #18283b;
      --navbar-dark-secondary: #2c3e50;
      --navbar-light-primary: #f5f6fa;
      --navbar-light-secondary: #8392a5;
      --hover-border-color: gold;
    }

    html, body {
      margin: 0;
      background: var(--background);
      display: flex;
      height: 100vh;
    }

    #nav-toggle:checked ~ #nav-header {
      width: calc(var(--navbar-width-min) - 16px);
    }

    #nav-toggle:checked ~ #nav-content, #nav-toggle:checked ~ #nav-footer {
      width: var(--navbar-width-min);
    }

    #nav-toggle:checked ~ #main-content {
      margin-left: var(--navbar-width-min);
    }

    #nav-toggle:checked ~ #nav-header #nav-title {
      opacity: 0;
      pointer-events: none;
      transition: opacity .1s;
    }

    #nav-toggle:checked ~ #nav-header label[for="nav-toggle"] {
      left: calc(50% - 8px);
      transform: translate(-50%);
    }

    #nav-toggle:checked ~ #nav-header #nav-toggle-burger {
      background: var(--navbar-light-primary);
    }

    #nav-toggle:checked ~ #nav-header #nav-toggle-burger:before,
    #nav-toggle:checked ~ #nav-header #nav-toggle-burger:after {
      width: 16px;
      background: var(--navbar-light-secondary);
      transform: translate(0, 0) rotate(0deg);
    }

    #nav-toggle:checked ~ #nav-content .nav-button span {
      opacity: 0;
      transition: opacity .1s;
    }

    #nav-toggle:checked ~ #nav-content .nav-button .fas {
      min-width: calc(100% - 16px);
    }

    #nav-toggle:checked ~ #nav-footer #nav-footer-avatar {
      margin-left: 0;
      left: 50%;
      transform: translate(-50%);
    }

    #nav-toggle:checked ~ #nav-footer #nav-footer-titlebox,
    #nav-toggle:checked ~ #nav-footer label[for="nav-footer-toggle"] {
      opacity: 0;
      transition: opacity .1s;
      pointer-events: none;
    }

    #nav-bar {
      position: absolute;
      top: 1vw;
      height: calc(100% - 2vw);
      background: var(--navbar-dark-primary);
      border-radius: 16px;
      display: flex;
      flex-direction: column;
      color: var(--navbar-light-primary);
      font-family: Verdana, Geneva, Tahoma, sans-serif;
      overflow: hidden;
      user-select: none;
    }

    #nav-bar hr {
      margin: 0;
      position: relative;
      left: 16px;
      width: calc(100% - 32px);
      border: none;
      border-top: solid 1px var(--navbar-dark-secondary);
    }

    #nav-bar a {
      color: inherit;
      text-decoration: inherit;
    }

    #nav-bar input[type="checkbox"] {
      display: none;
    }

    #nav-header {
      position: relative;
      width: var(--navbar-width);
      left: 16px;
      width: calc(var(--navbar-width) - 16px);
      min-height: 80px;
      background: var(--navbar-dark-primary);
      border-radius: 16px;
      z-index: 2;
      display: flex;
      align-items: center;
      transition: width .2s;
      text-align: center;
    }

    #nav-header hr {
      position: absolute;
      bottom: 0;
    }

    #nav-title {
      font-size: 1.5rem;
      transition: opacity 1s;
    }

    label[for="nav-toggle"] {
      position: absolute;
      right: 0;
      width: 3rem;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
    }

    #nav-toggle-burger {
      position: relative;
      width: 16px;
      height: 2px;
      background: var(--navbar-dark-primary);
      border-radius: 99px;
      transition: background 0.2s;
    }

    #nav-toggle-burger:before, #nav-toggle-burger:after {
      content: '';
      position: absolute;
      top: -6px;
      width: 10px;
      height: 2px;
      background: var(--navbar-light-primary);
      border-radius: 99px;
      transform: translate(2px, 8px) rotate(30deg);
      transition: .2s;
    }

    #nav-toggle-burger:after {
      top: 6px;
      transform: translate(2px, -8px) rotate(-30deg);
    }

    #nav-content {
      margin: -16px 0;
      padding: 16px 0;
      position: relative;
      flex: 1;
      width: var(--navbar-width);
      background: var(--navbar-dark-primary);
      box-shadow: 0 0 0 16px var(--navbar-dark-primary);
      direction: rtl;
      overflow-x: hidden;
      transition: width .2s;
    }

    #nav-content::-webkit-scrollbar {
      width: 8px;
      height: 8px;
    }

    #nav-content::-webkit-scrollbar-thumb {
      border-radius: 99px;
      background-color: #D62929;
    }

    #nav-content::-webkit-scrollbar-button {
      height: 16px;
    }

    #nav-content-highlight {
      position: absolute;
      left: 16px;
      top: -54 - 16px;
      width: calc(100% - 16px);
      height: 54px;
      background: var(--background);
      background-attachment: fixed;
      border-radius: 16px 0 0 16px;
      transition: top .2s;
    }

    #nav-content-highlight:before, #nav-content-highlight:after {
      content: '';
      position: absolute;
      right: 0;
      bottom: 100%;
      width: 32px;
      height: 32px;
      border-radius: 50%;
      box-shadow: 16px 16px var(--background);
    }

    #nav-content-highlight:after {
      top: 100%;
      box-shadow: 16px -16px var(--background);
    }

    .nav-button {
      position: relative;
      margin-left: 16px;
      height: 54px;
      display: flex;
      align-items: center;
      color: var(--navbar-light-secondary);
      direction: ltr;
      cursor: pointer;
      z-index: 1;
      transition: color .2s, background-color .2s, border-radius .2s;
    }

    .nav-button span {
      transition: opacity 1s;
    }

    .nav-button .fas {
      transition: min-width .2s;
    }

    .nav-button:hover {
      background-color: var(--navbar-dark-secondary);
      border-radius: 5px;
      color: var(--navbar-light-primary);
      transition: color 0.2s;
      opacity: 0.7; /* 투명해지는 효과 */
    }

    .nav-button:hover ~ #nav-content-highlight {
      top: calc((var(--i) - 1) * 54 + 16px);
    }

    #nav-bar .fas {
      min-width: 3rem;
      text-align: center;
    }

    #nav-footer {
      position: relative;
      width: var(--navbar-width);
      height: 54px;
      background: var(--navbar-dark-secondary);
      border-radius: 16px;
      display: flex;
      flex-direction: column;
      z-index: 2;
      transition: width .2s, height .2s;
    }

    #nav-footer-heading {
      position: relative;
      width: 100%;
      height: 54px;
      display: flex;
      align-items: center;
    }

    #nav-footer-avatar {
      position: relative;
      margin: 11px 0 11px 16px;
      left: 0;
      width: 32px;
      height: 32px;
      border-radius: 50%;
      overflow: hidden;
      transform: translate(0);
      transition: .2s;
    }

    #nav-footer-avatar img {
      height: 100%;
    }

    #nav-footer-titlebox {
      position: relative;
      margin-left: 16px;
      width: 10px;
      display: flex;
      flex-direction: column;
      transition: opacity 1s;
    }

    #nav-footer-subtitle {
      color: var(--navbar-light-secondary);
      font-size: .6rem;
    }

    #nav-toggle:not(:checked) ~ #nav-footer-toggle:checked + #nav-footer {
      height: 30%;
      min-height: 54px;
    }

    #nav-footer label[for="nav-footer-toggle"] {
      position: absolute;
      right: 0;
      width: 3rem;
      height: 100%;
      display: flex;
      align-items: center;
      cursor: pointer;
      transition: transform .2s, opacity .2s;
    }

    #nav-footer-content {
      margin: 0 16px 16px 16px;
      border-top: solid 1px var(--navbar-light-secondary);
      padding: 16px 0;
      color: var (--navbar-light-secondary);
      font-size: .8rem;
      overflow: auto;
    }

    #nav-footer-content::-webkit-scrollbar {
      width: 8px;
      height: 8px;
    }

    #nav-footer-content::-webkit-scrollbar-thumb {
      border-radius: 99px;
      background-color: #D62929;
    }

    /* #nav-bar 관련 기존 스타일 */
    #main-content {
      margin-left: var(--navbar-width);
      padding: 20px;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      transition: margin-left .2s;
    }

    .overlay {
      display: none;
      position: fixed;
      top: 20px;
      background-color: #f4f4f4;
      border: 1px solid #ccc;
      padding: 10px;
      box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
      z-index: 1000;
      overflow-y: auto;
      height: calc(100vh - 40px);
      opacity: 0; /* initially hidden */
      transition: opacity 0.5s ease; /* fade-in effect */
      
    }

    .overlay.show {
    left: 260px;
      display: block;
      opacity: 1; /* fade-in effect */
    }

    .overlay.right {
      left: 720px;
    }

    .overlay.right-half {
      left: 1070px;
    }

    .overlay.large {
      width: 500px;
  
    }

    .overlay.right-large {
      width: 400px;
      left: 770px;
    }

    .overlay.right-extra-large {
      width: 400px;
      left: 1170px;
    }

    .overlay.half-large {
      width: 200px;
      left: 370px;
    }

    .overlay.half-right-large {
      width: 200px;
      left: 720px;
    }

    .overlay.full-right-large {
      width: 400px;
      left: 720px;
    }

    .overlay h2 {
      margin-top: 0;
      font-size: 18px;
    }

    .overlay input, .overlay textarea {
      width: calc(100% - 20px);
      padding: 5px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 14px;
    }

    .overlay ul {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }

    .overlay ul li {
      background-color: #fff;
      padding: 5px;
      margin-bottom: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      position: relative;
      transition: transform 0.2s ease, border-color 0.2s ease;
    }

    .overlay ul li:hover {
      transform: scale(1.05);
      border-color: var(--hover-border-color);
    }

    .overlay ul li .title-overlay {
      position: absolute;
      bottom: 0;
      width: 100%;
      background: rgba(0, 0, 0, 0.5);
      color: white;
      padding: 5px;
      box-sizing: border-box;
      text-align: center;
      left:-0.1px;
    }

    .overlay button {
      background-color: #333;
      color: #fff;
      border: none;
      padding: 5px;
      cursor: pointer;
      font-size: 12px;
      margin-top: 10px;
    }

    .overlay button:hover {
      background-color: #444;
    }

    .image-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 10px;
      padding: 0;
      margin: 0;
      list-style-type: none;
    }

    .image-grid li {
      width: 110px;
      height: 130px;
      background-size: cover;
      background-position: center;
      list-style-type: none;
      margin: 10px;
      display: flex;
      align-items: flex-end;
      padding: 5px;
      color: white;
      text-shadow: 1px 1px 2px black;
      position: relative;
      transition: transform 0.2s ease, border-color 0.2s ease;
    }

    .image-grid li:hover {
      transform: scale(1.05);
      border-color: var(--hover-border-color);
    }

    .detail-content {
      font-size: 14px;
      margin-bottom: 10px;
    }

    .map {
      width: 100%;
      height: 150px;
      background-color: #ccc;
      margin-bottom: 10px;
    }

    .faq-content {
      font-size: 14px;
      margin-bottom: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    table, th, td {
      border: 1px solid #ccc;
    }

    th, td {
      padding: 10px;
      text-align: left;
    }

    th {
      background-color: #f4f4f4;
    }

    .pagination {
      margin-top: 10px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .pagination button {
      margin: 0 5px;
    }

    .pagination span {
      margin: 0 5px;
    }

    .pagination .page-number {
      cursor: pointer;
    }

    .detail-image {
      max-width: 100%;
      height: auto;
      border-radius: 5px;
      margin-bottom: 10px;
    }

    .detail-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 10px;
    }

    .detail-overview, .detail-addr1 {
      font-size: 14px;
      margin-bottom: 10px;
    }

    .detail-link a {
      color: #3498db;
      text-decoration: none;
    }

    .detail-link a:hover {
      text-decoration: underline;
    }

    /* 지도 스타일 추가 */
       #map {
      width: 100%;
      height: 400px;
    }
     #map1 {
            width: 100%; height: 100vh;
            position: absolute;
            top: 0; left: 0;
            z-index: 0;
        }
          #search-results {
      list-style: none;
      padding: 0;
      margin: 0;
      border: 1px solid #ddd;
      max-height: 200px;
      overflow-y: auto;
      background-color: white;
    }

    #search-results li {
      cursor: pointer;
      padding: 5px;
      border-bottom: 1px solid #ddd;
    }

    #search-results li:hover {
      background-color: #f0f0f0;
    }
    
    #selected-places {
      list-style: none;
      padding: 0;
      margin: 10px 0;
    }

    #selected-places li {
      padding: 5px;
      background-color: #f9f9f9;
      border: 1px solid #ddd;
      margin-bottom: 5px;
    }
    
  </style>
  
  <!-- 정엽 css -->
  <style type="text/css">
  .page-button {
    	display: none;
    }
    
    .page-button-active {
    	display: block;
    }
  </style>
</head>
<body>
 <div id="map1"></div>
<button id="menu-button"><i class="fas fa-bars"></i></button>

<div id="nav-bar">
  <input id="nav-toggle" type="checkbox"/>
  <div id="nav-header">
    <a id="nav-title" href="" target="_blank"><i class="fab fa-codepen"></i>MoYeo</a>
    <label for="nav-toggle"><span id="nav-toggle-burger"></span></label>
    <hr/>
  </div>
  <div id="nav-content">
    <div class="nav-button" id="nav-button1"><i class="fas fa-palette"></i><span>같이 갈래?</span></div>
    <div class="nav-button" id="nav-button2"><i class="fas fa-images"></i><span>이건 어때?</span></div>
    <div class="nav-button" id="nav-button3"><i class="fas fa-thumbtack"></i><span>괜찮았어?</span></div>
    <hr/>
    <div class="nav-button" id="nav-button4"><i class="fas fa-heart"></i><span>고객센터</span></div>
  </div>
  <input id="nav-footer-toggle" type="checkbox"/>
</div>

<div id="main-content" class="main-content">
  
  
  

  <!-- 첫 번째 게시판과 세부 사항 -->
  <div id="message-box1" class="overlay large">
    <h1>같이 갈래? 게시판</h1>
    <form action="<c:url value='/home/joinSearch'/>">
    	<input type="text" id="search-input1" name="keyword" placeholder="검색" />
    	<button id="search-button1">검색</button>
    	<input type="hidden" name="pageNum">
    </form>
    <button id="write-button1">글쓰기</button>
    <ul id="message-list1">
    	<c:forEach var="i" items="${travelPlanList}" begin="${page.firstPost}" end="${page.lastPost}">
    		<li onclick="JoinDetail('${i.plan_id}', '${i.title}', '${i.description}', '${i.user_id}', '${i.start_date}', '${i.end_date}', '${i.created_at}')">
    			<img src="">
    			${i.title}
    			<c:forEach var="j" items="${userList}">
      				<c:if test="${i.user_id == j.user_id}">
      					${j.username}
      				</c:if>
      			</c:forEach>
    			${i.start_date}~${i.end_date}
    		</li>
    	</c:forEach>
    </ul>
    <div class="pagination">
	    <form action="" method="get">
	    	<c:if test="${keyword != null}">
	    		<input type="hidden" name="keyword" value="${keyword}">
	    	</c:if>
	    	<c:if test="${page.currentPage != page.firstPage}">
	    		<button name="pageNum" value="${page.firstPage}">처음으로</button>
	      	</c:if>
	      	<button class="page-button${page.prev?'-active':''}" name="pageNum" value="${page.currentPage-1}">이전</button>
	      	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<button name="pageNum" value="${i}">${i}</button>
	      	</c:forEach>
	      	<button class="page-button${page.next?'-active':''}" name="pageNum" value="${page.currentPage+1}">다음</button>
	      	<c:if test="${page.currentPage != page.lastPage}">
	      		<button name="pageNum" value="${page.lastPage}">마지막으로</button>
	      	</c:if>
      	</form>
    </div>
    <button id="close-button1">닫기</button>
  </div>
  <div id="write-box1" class="overlay right-large">
    <h2>글쓰기</h2>
    <form action="home/registerTravelRoute" method="post">
      <input type="text" id="write-title1" name="title" placeholder="제목" required/>
      <textarea id="write-content1" name="description" placeholder="내용" required></textarea>
      <input type="date" name="start_date" required>
      ~
      <input type="date" name="end_date" required>
      <div>
       <input type="text" id="kakao-search" placeholder="장소 검색">
<button id="kakao-search-button">검색</button>
<ul id="search-results"></ul>
</div>
<ul id="selected-places-list"></ul> <!-- 선택된 장소 목록을 보여줄 곳 -->
<input type="hidden" id="selected-places" name="selected_places"> <!-- 선택된 장소 데이터를 저장할 히든 필드 -->
        
      <button type="submit" id="write-submit1">작성</button>
    </form>
    <button id="write-close-button1">닫기</button>
      <!-- Travel Routes 정보를 JSON으로 담는 hidden input -->
<input type="hidden" id="travel-routes-json" value='${travelRoutesJson}'>
  </div>
  <div id="detail-box1" class="overlay right-large">
    <h2>세부 사항</h2>
    	<button id="planEdit1" onclick="joinEditShow()">수정</button>
    	<form id="planDelete" action="home/planDelete" method="get">
    		<button>삭제</button>
    	</form>
    <div id="join-detail-content"></div>
    <div id="join-detail-mod"></div>
    <div id="travel-route-details"></div>
    <!-- TravelRoute 정보를 표시할 영역 -->
    <c:forEach var="route" items="${travelRoutes}">
    <p>Location: ${route.location}</p>
    <p>Day: ${route.day}</p>
    <p>Order: ${route.order}</p>
    <hr>
</c:forEach> 
	 <div id="map2" style="width:100%;height:400px;"></div> <!-- 지도를 표시할 div -->
     <button id="detail-close-button4">닫기</button>
  
     
     <input type="hidden" id="travel-routes-json" value='${travelRoutesJson}'>
     
</div>
 
  
  <div id="detail-box1-2" class="overlay right-large" style="display:none;">
    <h2>수정하기</h2>
        <form id="planEdit" action="<c:url value='/home/planEdit'/>" method="get">
            <button>수정</button>
            <div id="planEdit2"></div>
         </form>
    <button id="detail-close-button1">닫기</button>
    
  </div>

  <!-- 두 번째 게시판과 세부 사항 -->
  <div id="message-box2" class="overlay large">
    <h1>이건 어때? 게시판</h1>
    <div>
      <label for="area-select">지역 선택:</label>
      <select id="area-select">
        <option value="1">서울</option>
        <option value="2">인천</option>
        <option value="3">대전</option>
        <option value="4">대구</option>
        <option value="5">광주</option>
        <option value="6">부산</option>
        <option value="7">울산</option>
        <option value="8">세종</option>
        <option value="31">경기도</option>
        <option value="32">강원도</option>
        <option value="33">충청북도</option>
        <option value="34">충청남도</option>
        <option value="35">경상북도</option>
        <option value="36">경상남도</option>
        <option value="37">전라북도</option>
        <option value="38">전라남도</option>
        <option value="39">제주도</option>
      </select>
      <label for="sigungu-select">시군구 선택:</label>
      <select id="sigungu-select">
        <option value="">선택</option>
      </select>
      <label for="theme-select">테마 선택:</label>
      <select id="theme-select">
        <option value="12">관광지</option>
        <option value="14">문화시설</option>
        <option value="15">축제공연행사</option>
        <option value="25">여행코스</option>
        <option value="28">레포츠</option>
        <option value="32">숙박</option>
        <option value="38">쇼핑</option>
        <option value="39">음식점</option>
      </select>
      <input type="text" id="search-input2" placeholder="검색어 입력">
      <button id="search-button2">검색</button>
    </div>
    <ul id="resultTestApi" class="image-grid"></ul> <!-- 결과를 표시할 리스트 -->
    <div class="pagination">
      <button id="prev-page2">이전</button>
      <div id="page-numbers2" class="page-numbers"></div>
      <button id="next-page2">다음</button>
    </div>
    <button id="close-button2">닫기</button>
  </div>
  <div id="detail-box2" class="overlay right-large">
      <h2>세부 사항</h2>
      <div id="detail-content2"></div>
      <div id="map"></div> <!-- 카카오 지도 -->
      <button id="detail-close-button2">닫기</button>
    </div>

  <!-- 세 번째 게시판과 세부 사항 -->
  <div id="message-box3" class="overlay large">
    <h1>괜찮았어? 게시판</h1>
    <div class="image-grid">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 1" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 2" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 3" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 4" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 5" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 6" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 7" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 8" class="clickable-image">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 9" class="clickable-image">
    </div>
    <button id="close-button3">닫기</button>
  </div>
  <div id="detail-box3" class="overlay right-large">
    <h2>세부 사항</h2>
    <p id="detail-content3" class="detail-content">여기에 세부 사항 텍스트가 표시됩니다.</p>
    <div class="map">지도 화면</div>
    <button id="view-photos-button">사진 보기</button>
    <button id="view-comments-button">댓글 보기</button>
    <button id="detail-close-button3">닫기</button>
  </div>

  <!-- 사진 보기 창 -->
  <div id="photo-box3" class="overlay right-half">
    <h2>사진 보기</h2>
    <div class="image-grid">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 1">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 2">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 3">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 4">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 5">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 6">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 7">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 8">
      <img src="https://via.placeholder.com/100" alt="Placeholder Image 9">
    </div>
    <button id="photo-close-button3">닫기</button>
  </div>

  <!-- 댓글 보기 창 -->
  <div id="comments-box3" class="overlay right-half">
    <h2>댓글 보기</h2>
    <ul id="comments-list3">
      <li>댓글 1</li>
      <li>댓글 2</li>
      <li>댓글 3</li>
    </ul>
    <button id="comments-close-button3">닫기</button>
  </div>

  <!-- Q/A 버튼과 FAQ 버튼 -->
  <div id="qa-faq-buttons" class="overlay half-large"  style="left: 260px">
    <h2>고객센터</h2>
    <button id="qa-button">Q/A</button>
    <button id="faq-button">FAQ</button>
    <button id="qa-faq-close-button">닫기</button>
  </div>

  <!-- Q/A 창 -->
  <div id="qa-box" class="overlay large" style="left: 260px; ">
    <h2>Q/A 게시판</h2>
    <button id="qa-write-button">글쓰기</button>
    <form action="QaSearch" method="get">
    	<input type="text" name="keyword" placeholder="검색" />
    	<input type="hidden" name="pageNum">
    	<button id="qa-search-button">검색</button>
    </form>
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>답변여부</th>
        </tr>
      </thead>
      <tbody id="qa-list">
      	<c:forEach var="i" items="${qaList}" begin="${page.firstPost}" end="${page.lastPost}">
      		<tr>
      			<td>${i.qa_id}</td>
      			<c:choose>
            		<c:when test="${i.title.length() >= 5}">
                		<td><a href="javascript:void(0);" onclick="QaDetail('${i.title}','${i.question}','${j.username}','${i.created_at}','${i.answer}')">${i.title.substring(0, 5)}...</a></td>
            		</c:when>
            		<c:otherwise>
                		<td><a href="javascript:void(0);" onclick="QaDetail('${i.title}','${i.question}','${j.username}','${i.created_at}','${i.answer}')">${i.title}</a></td>
            		</c:otherwise>
        		</c:choose>
      			<td>
      			<c:forEach var="j" items="${userList}">
      				<c:if test="${i.user_id==j.user_id}">
      					${j.username}
      				</c:if>
      			</c:forEach>
      			</td>
      			<td>${i.created_at}</td>
      			<td>
      				<c:if test="${i.answer != null}">
      					답변완료
      				</c:if>
      			</td>
      		</tr>
      	</c:forEach>
      </tbody>
    </table>
    <div class="pagination">
	    <form action="" method="get">
	    	<c:if test="${keyword != null}">
	    		<input type="hidden" name="keyword" value="${keyword}">
	    	</c:if>
	    	<c:if test="${page.currentPage != page.firstPage}">
	    		<button name="pageNum" value="${page.firstPage}">처음으로</button>
	      	</c:if>
	      	<button class="page-button${page.prev?'-active':''}" name="pageNum" value="${page.currentPage-1}">이전</button>
	      	<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<button name="pageNum" value="${i}">${i}</button>
	      	</c:forEach>
	      	<button class="page-button${page.next?'-active':''}" name="pageNum" value="${page.currentPage+1}">다음</button>
	      	<c:if test="${page.currentPage != page.lastPage}">
	      		<button name="pageNum" value="${page.lastPage}">마지막으로</button>
	      	</c:if>
      	</form>
    </div>
    <button id="qa-close-button">닫기</button>
  </div>
  <div id="qa-write-box" class="overlay right-large">
    <h2>Q/A 글쓰기</h2>
    <form action="<c:url value='/home/QaRegister'/>" method="get">
    	<input type="hidden" name="user_id" value="1">
    	<input name="title" type="text" id="qa-write-title" placeholder="제목">
    	<textarea name="question" id="qa-write-content" placeholder="내용"></textarea>
    	<button id="qa-write-submit">작성</button>
    </form>
    <button id="qa-write-close-button">닫기</button>
  </div>
  <div id="qa-detail-box" class="overlay right-large">
    <h2>Q/A 세부 사항</h2>
    <div id="qa-detail-box-list"></div>
    <button id="qa-detail-close-button">닫기</button>
  </div>

  <!-- FAQ 창 -->
   <div id="faq-box" class="overlay half-right-large" style=" left: 260px ;">
    <h2>FAQ</h2>
    <div class="faq-content" id="faq-content"></div>
    <button id="faq-close-button">닫기</button>
  </div>
</div>


<!-- 정엽 script -->
<script>

	// QA 버튼 클릭 시 QA 창 표시
	document.getElementById('qa-button').addEventListener('click', function() {
  		hideCategoryOverlays('half-large');
  		var qaBox = document.getElementById('qa-box');
  		qaBox.style.display = 'block';
  		qaBox.classList.add("show");
	});

	// QA 상세보기 창 표시
	function QaDetail(title, question, username, created_at, answer) {
		$("#qa-detail-box-list").empty();
		var qaDetailBox = document.getElementById('qa-detail-box');
		var qaDetailBoxList = document.getElementById('qa-detail-box-list');
		qaDetailBox.style.display = 'block';	
		
		const title_p = document.createElement('p');
		const title_message = document.createTextNode("제목: "+title);
		title_p.appendChild(title_message);
		qaDetailBoxList.append(title_p);
		
		const question_p = document.createElement('p');
		const question_message = document.createTextNode("질문: "+question);
		question_p.appendChild(question_message);
		qaDetailBoxList.append(question_p);
		
		const username_p = document.createElement('p');
		const username_message = document.createTextNode("작성자: "+username);
		username_p.appendChild(username_message);
		qaDetailBoxList.append(username_p);
		
		const created_at_p = document.createElement('p');
		const created_at_message = document.createTextNode("작성일: "+created_at);
		created_at_p.appendChild(created_at_message);
		qaDetailBoxList.append(created_at_p);
		
		const answer_p = document.createElement('p');
		const answer_message = document.createTextNode("답변: "+answer);
		answer_p.appendChild(answer_message);
		qaDetailBoxList.append(answer_p);
		
	};
	
	
</script>

<!-- 정엽 같이갈래 script -->
<script>

	// 같이갈래? 클릭시 같이갈래? 게시판 표시
	document.getElementById('nav-button1').addEventListener('click', function() {
	  hideAllOverlays();
	  var joinBoard = document.getElementById('message-box1');
	  joinBoard.style.display = 'block';
	  joinBoard.classList.add("show");
	});
	
	// 같이갈래? 상세보기
	 function JoinDetail(plan_id, title, description, username, start_date, end_date, created_at) {
    $("#join-detail-content").empty();
    $("#travel-route-details").empty();
    $("#map2").empty(); // 지도를 초기화

    var joinDetail = document.getElementById('detail-box1');
    var joinDetailContent = document.getElementById('join-detail-content');
    joinDetail.style.display = 'block';
    joinDetail.classList.add("show");

    JoinDeleteInput(plan_id);
    planEdit(plan_id, title, description, username, start_date, end_date, created_at);

    const title_p = document.createElement('p');
    const title_message = document.createTextNode("제목: " + title);
    title_p.appendChild(title_message);
    joinDetailContent.append(title_p);

    const description_p = document.createElement('p');
    const description_message = document.createTextNode("설명: " + description);
    description_p.appendChild(description_message);
    joinDetailContent.append(description_p);

    const username_p = document.createElement('p');
    const username_message = document.createTextNode("작성자: " + username);
    username_p.appendChild(username_message);
    joinDetailContent.append(username_p);

    const start_date_p = document.createElement('p');
    const start_date_message = document.createTextNode("시작일: " + start_date);
    start_date_p.appendChild(start_date_message);
    joinDetailContent.append(start_date_p);

    const end_date_p = document.createElement('p');
    const end_date_message = document.createTextNode("종료일: " + end_date);
    end_date_p.appendChild(end_date_message);
    joinDetailContent.append(end_date_p);

    const created_at_p = document.createElement('p');
    const created_at_message = document.createTextNode("작성일: " + created_at);
    created_at_p.appendChild(created_at_message);
    joinDetailContent.append(created_at_p);
    var map2; // 전역 변수로 map2 선언
    
 // AJAX 요청으로 travelRoutes 정보를 가져와서 표시
    $.ajax({
        url: '/home/getTravelRoutes',
        method: 'GET',
        data: { plan_id: plan_id },
        success: function(response) {
            console.log("Received travelRoutes: ", response);
            var travelRoutes = response;
            if (travelRoutes.length > 0) {
                // 기존 지도 제거
                if (map2) {
                    map2 = null;
                    document.getElementById('map2').innerHTML = "";
                }

                var mapContainer = document.getElementById('map2'); // 지도를 표시할 div
                var mapOption = {
                    center: new kakao.maps.LatLng(37.5665, 126.9780), // 기본 지도 중심 좌표 설정 (서울 시청 좌표)
                    level: 5 // 지도 확대 레벨
                };
                map2 = new kakao.maps.Map(mapContainer, mapOption);
                var linePath = []; // Polyline 경로를 저장할 배열

                travelRoutes.forEach(function(route, index) {
                    const routeItem = document.createElement('p');
                    const routeMessage = document.createTextNode("장소: " + route.location + ", Day: " + route.day + ", Order: " + route.order);
                    routeItem.appendChild(routeMessage);
                    $("#travel-route-details").append(routeItem);

                    // 로케이션에서 위도와 경도 파싱
                    var regex = /\(([^)]+)\)/;
                    var matches = regex.exec(route.location);
                    if (matches && matches[1]) {
                        var coords = matches[1].split(',').map(parseFloat);
                        var lat = coords[0];
                        var lng = coords[1];

                        // 마커를 지도에 표시
                        var markerPosition = new kakao.maps.LatLng(lat, lng);
                        var marker = new kakao.maps.Marker({
                            position: markerPosition,
                            map: map2
                        });

                        // 마커에 order 번호를 표시
                        var overlay = new kakao.maps.CustomOverlay({
                            content: '<div style="padding:5px;background:white;border:1px solid black;border-radius:50%;width:30px;height:30px;text-align:center;line-height:30px;">' + route.order + '</div>',
                            position: markerPosition,
                            yAnchor: 1
                        });
                        overlay.setMap(map2);

                        // 경로를 Polyline에 추가
                        linePath.push(markerPosition);
                    }
                });

                // Polyline을 지도에 표시
                var polyline = new kakao.maps.Polyline({
                    path: linePath,
                    strokeWeight: 5,
                    strokeColor: '#FFAE00',
                    strokeOpacity: 0.7,
                    strokeStyle: 'solid'
                });
                polyline.setMap(map2);
            } else {
                $("#travel-route-details").append('<p>저장된 여행 경로가 없습니다.</p>');
            }
        },
        error: function(error) {
            console.error("Error fetching travel routes: ", error);
            $("#travel-route-details").append('<p>여행 경로를 가져오는 데 오류가 발생했습니다.</p>');
            // 지도를 숨깁니다.
            $("#map2").hide();
        }
    });
}
		
		
	
	
	
	// 같이갈래? 수정 폼
	 function planEdit(plan_id, title, description, username, start_date, end_date, created_at){
        $("#planEdit2").empty();
        var planEdit = document.getElementById('planEdit2');
		
		
		const plan_id_edit = document.createElement('input');
		plan_id_edit.setAttribute('name','plan_id');
		plan_id_edit.setAttribute('type','hidden');
		plan_id_edit.setAttribute('value',plan_id);
		planEdit.append(plan_id_edit);
		
		const title_edit = document.createElement('input');
		title_edit.setAttribute('name','title');
		title_edit.setAttribute('type','text');
		title_edit.setAttribute('value',title);
		planEdit.append(title_edit);
		
		const description_edit = document.createElement('input');
		description_edit.setAttribute('name','description');
		description_edit.setAttribute('type','text');
		description_edit.setAttribute('value',description);
		planEdit.append(description_edit);
		
		var start_date_edit = document.createElement('input');
		start_date_edit.setAttribute('name','start_date');
		start_date_edit.setAttribute('type','Date');
		planEdit.append(start_date_edit);
		
		var end_date_edit = document.createElement('input');
		end_date_edit.setAttribute('name','end_date');
		end_date_edit.setAttribute('type','Date');
		planEdit.append(end_date_edit);
	}
	
	// 같이갈래? 수정 창 보이기
	function joinEditShow() {
		var detailBox2 = document.getElementById('detail-box1-2');
		detailBox2.style.display = 'block';
		detailBox2.classList.add("show");
	}
	
	// 같이갈래? 삭제버튼 생성
	function JoinDeleteInput(plan_id){
		var planDelete = document.getElementById('planDelete');
		const plan_id_btn = document.createElement('input');
		plan_id_btn.setAttribute('name','plan_id');
		plan_id_btn.setAttribute('type','hidden');
		plan_id_btn.setAttribute('value',plan_id);
		planDelete.append(plan_id_btn);
	}
	

</script>

<!-- 기본 script -->
<script>


  function hideCategoryOverlays(category) {
    var overlays = document.querySelectorAll('.overlay.' + category);
    overlays.forEach(function(overlay) {
      overlay.style.display = 'none';
    });
  }

  function hideAllOverlays() {
    var overlays = document.querySelectorAll('.overlay');
    overlays.forEach(function(overlay) {
      overlay.style.display = 'none';
    });
  }

  function hideOverlaysById(ids) {
    ids.forEach(function(id) {
      var element = document.getElementById(id);
      if (element) {
        element.style.display = 'none';
      }
    });
  }


  // "괜찮았어?" 버튼 클릭 시 세 번째 게시판 표시
  document.getElementById('nav-button3').addEventListener('click', function() {
    hideAllOverlays();
    var messageBox3 = document.getElementById('message-box3');
    messageBox3.style.display = 'block';
    var detailBox3 = document.getElementById('detail-box3');
    detailBox3.style.display = 'none'; 
    var photoBox3 = document.getElementById('photo-box3');
    photoBox3.style.display = 'none'; 
    var commentsBox3 = document.getElementById('comments-box3');
    commentsBox3.style.display = 'none'; 
  });

  // "고객센터" 버튼 클릭 시 Q/A 및 FAQ 버튼 표시
  document.getElementById('nav-button4').addEventListener('click', function() {
    hideAllOverlays();
    var qaFaqButtons = document.getElementById('qa-faq-buttons');
    qaFaqButtons.style.display = 'block';
  });

  // "FAQ" 버튼 클릭 시 FAQ 창 표시
  document.getElementById('faq-button').addEventListener('click', function() {
    hideCategoryOverlays('half-large');
    var faqBox = document.getElementById('faq-box');
    faqBox.style.display = 'block';
  });

  // 닫기 버튼 클릭 시 창 숨김
  document.getElementById('qa-close-button').addEventListener('click', function() {
    var qaBox = document.getElementById('qa-box');
    qaBox.style.display = 'none';
    hideOverlaysById(['qa-write-box', 'qa-detail-box']);
  });

  document.getElementById('faq-close-button').addEventListener('click', function() {
    var faqBox = document.getElementById('faq-box');
    faqBox.style.display = 'none';
  });

  document.getElementById('qa-faq-close-button').addEventListener('click', function() {
    var qaFaqButtons = document.getElementById('qa-faq-buttons');
    qaFaqButtons.style.display = 'none';
  });

  document.getElementById('close-button1').addEventListener('click', function() {
    var messageBox1 = document.getElementById('message-box1');
    messageBox1.style.display = 'none';
    hideOverlaysById(['detail-box1', 'write-box1']);
  });

  document.getElementById('close-button2').addEventListener('click', function() {
    var messageBox2 = document.getElementById('message-box2');
    messageBox2.style.display = 'none';
    hideOverlaysById(['detail-box2']);
  });

  document.getElementById('close-button3').addEventListener('click', function() {
    var messageBox3 = document.getElementById('message-box3');
    messageBox3.style.display = 'none';
    hideOverlaysById(['detail-box3', 'photo-box3', 'comments-box3']);
  });

  document.getElementById('write-close-button1').addEventListener('click', function() {
    var writeBox1 = document.getElementById('write-box1');
    writeBox1.style.display = 'none';
  });

  document.addEventListener('DOMContentLoaded', function() {
	    // 수정하기 닫기 버튼 이벤트 리스너
	    document.getElementById('detail-close-button1').addEventListener('click', function() {
	        console.log('Close button clicked'); // 콘솔 로그 추가
	        var detailBox1 = document.getElementById('detail-box1-2');
	        detailBox1.style.display = 'none';
	       
	    });
	});

  // 첫 번째 게시판 검색 및 글쓰기 처리
  document.getElementById('write-button1').addEventListener('click', function() {
    var writeBox1 = document.getElementById('write-box1');
    hideOverlaysById(['detail-box1']); // Hide the detail box when writing
    writeBox1.style.display = 'block';
  });


  // Q/A 게시판 글쓰기 처리
  document.getElementById('qa-write-button').addEventListener('click', function() {
    var qaWriteBox = document.getElementById('qa-write-box');
    qaWriteBox.style.display = 'block';
  });


  // 세부 정보 닫기 버튼 클릭 시 세부 정보 숨김
  document.getElementById('qa-detail-close-button').addEventListener('click', function() {
    var qaDetailBox = document.getElementById('qa-detail-box');
    qaDetailBox.style.display = 'none';
  });

  document.getElementById('qa-write-close-button').addEventListener('click', function() {
    var qaWriteBox = document.getElementById('qa-write-box');
    qaWriteBox.style.display = 'none';
  });


  // 세 번째 게시판의 이미지 클릭 시 세부 정보 표시
  document.querySelectorAll('.clickable-image').forEach(function(image) {
    image.addEventListener('click', function() {
      var detailBox3 = document.getElementById('detail-box3');
      var detailContent3 = document.getElementById('detail-content3');
      detailContent3.textContent = '여기에 세부 사항 텍스트가 표시됩니다.';
      detailBox3.style.display = 'block';
    });
  });

  // 세부 정보 닫기 버튼 클릭 시 세부 정보 숨김
  document.getElementById('detail-close-button2').addEventListener('click', function() {
    var detailBox2 = document.getElementById('detail-box2');
    detailBox2.style.display = 'none';
  });

  document.getElementById('detail-close-button3').addEventListener('click', function() {
    var detailBox3 = document.getElementById('detail-box3');
    detailBox3.style.display = 'none';
  });

  // 사진 보기 버튼 클릭 시 사진 보기 창 표시
  document.getElementById('view-photos-button').addEventListener('click', function() {
    var commentsBox3 = document.getElementById('comments-box3');
    commentsBox3.style.display = 'none'; // 댓글 창 숨기기
    var photoBox3 = document.getElementById('photo-box3');
    photoBox3.style.display = 'block';
  });

  // 댓글 보기 버튼 클릭 시 댓글 보기 창 표시
  document.getElementById('view-comments-button').addEventListener('click', function() {
    var photoBox3 = document.getElementById('photo-box3');
    photoBox3.style.display = 'none'; // 사진 창 숨기기
    var commentsBox3 = document.getElementById('comments-box3');
    commentsBox3.style.display = 'block';
  });

  // 사진 보기 닫기 버튼 클릭 시 사진 보기 창 숨김
  document.getElementById('photo-close-button3').addEventListener('click', function() {
    var photoBox3 = document.getElementById('photo-box3');
    photoBox3.style.display = 'none';
  });

  // 댓글 보기 닫기 버튼 클릭 시 댓글 보기 창 숨김
  document.getElementById('comments-close-button3').addEventListener('click', function() {
    var commentsBox3 = document.getElementById('comments-box3');
    commentsBox3.style.display = 'none';
  });

  // 메뉴 버튼 클릭 시 메뉴 표시
  document.getElementById('menu-button').addEventListener('click', function() {
    var navBar = document.getElementById('nav-bar');
    if (navBar.style.display === 'none' || navBar.style.display === '') {
      navBar.style.display = 'block';
    } else {
      navBar.style.display = 'none';
    }
  });
  document.getElementById('detail-close-button4').addEventListener('click', function() {
	    var detailBox1 = document.getElementById('detail-box1');
	    detailBox1.style.display = 'none';
	});

</script>


<!-- 예찬 script -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  
  <script type="text/javascript">
  let contentId; // 전역 변수로 contentId 선언

  function ajaxTest(areaCode, themeCode, sigunguCode, searchValue = "", pageNo = 1) {
      console.log("Selected Area Code:", areaCode);
      console.log("Selected Theme Code:", themeCode);
      console.log("Selected Sigungu Code:", sigunguCode);
      console.log("Search Value:", searchValue);

      if (searchValue) {
          filterResults(searchValue);
          return;
      }

      let url = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=21&pageNo=" + pageNo + "&MobileOS=ETC&MobileApp=HAHA&_type=json&listYN=Y&arrange=A&areaCode=" + areaCode + "&sigunguCode=" + sigunguCode + "&contentTypeId=" + themeCode + "&serviceKey=FhVdLivdQhcnz0qp01tF9t87mWZunIvLMJI0tIfzg0CaMu296y0tKhHIw1Bim%2BDvQxtmkibO6WN4XMfZOlAMeQ%3D%3D";
      console.log(url);
      $.ajax({
          url: url,
          type: "get",
          dataType: "json",
          success: function(data) {
              console.log("성공");
              console.log(data);
              $("#resultTestApi").empty();
              var items = data.response.body.items.item;
              var totalCount = data.response.body.totalCount;
              items.forEach(function(item, index) {
                  var imageUrl = item.firstimage ? item.firstimage : '/resources/imgs/Noimg.png';
                  var listItem = $("<li>").css({
                      backgroundImage: 'url(' + imageUrl + ')'
                  }).html('<div class="title-overlay">' + item.title + '</div>');
                  listItem.data("details", item);
                  listItem.on("click", function() {
                      contentId = item.contentid; // 클릭 시 contentId 설정
                      getDetailInfo(); // 상세 정보 가져오기
                  });
                  $("#resultTestApi").append(listItem);
              });
              currentPage2 = pageNo; // 현재 페이지 업데이트
              setupPagination('prev-page2', 'next-page2', 'page-numbers2', currentPage2, Math.ceil(totalCount / 21), ajaxTest, areaCode, themeCode, sigunguCode);
          },
          error: function(e) {
              console.log("에러");
              console.log(e);
          }
      });
  }

  function filterResults(searchValue) {
      $('#resultTestApi li').each(function() {
          var title = $(this).find('.title-overlay').text().toLowerCase();
          if (title.includes(searchValue.toLowerCase())) {
              $(this).show();
          } else {
              $(this).hide();
          }
      });
  }

  function getSigunguCodes(areaCode) {
      let url = "https://apis.data.go.kr/B551011/KorService1/areaCode1?numOfRows=500&pageNo=1&MobileOS=ETC&MobileApp=HAHA&areaCode=" + areaCode + "&_type=json&serviceKey=FhVdLivdQhcnz0qp01tF9t87mWZunIvLMJI0tIfzg0CaMu296y0tKhHIw1Bim%2BDvQxtmkibO6WN4XMfZOlAMeQ%3D%3D";
      console.log(url);
      $.ajax({
          url: url,
          type: "get",
          dataType: "json",
          success: function(data) {
              console.log("성공");
              console.log(data);
              $("#sigungu-select").empty();
              var items = data.response.body.items.item;
              $("#sigungu-select").append('<option value="">선택</option>');
              items.forEach(function(item) {
                  $("#sigungu-select").append('<option value="' + item.code + '">' + item.name + '</option>');
              });
          },
          error: function(e) {
              console.log("에러");
              console.log(e);
          }
      });
  }

  function getDetailInfo() {
      let detailUrl = "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=haha&_type=json&contentId="+contentId+"&defaultYN=Y&firstImageYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey=FhVdLivdQhcnz0qp01tF9t87mWZunIvLMJI0tIfzg0CaMu296y0tKhHIw1Bim%2BDvQxtmkibO6WN4XMfZOlAMeQ%3D%3D";
      console.log(contentId);
      console.log(detailUrl);
      $.ajax({
          url: detailUrl,
          type: "get",
          dataType: "json",
          success: function(data) {
              var detail = data.response.body.items.item[0];
              $("#detail-content2").empty();

              // Add firstimage or default image
              var imageUrl = detail.firstimage ? detail.firstimage : '/resources/imgs/Noimg.png';
              $("#detail-content2").append('<img src="' + imageUrl + '" class="detail-image" alt="Image">');

              // Add title
              if (detail.title) {
                  $("#detail-content2").append('<h3 class="detail-title">' + detail.title + '</h3>');
              }

              // Add overview
              if (detail.overview) {
                  $("#detail-content2").append('<p class="detail-overview">' + detail.overview + '</p>');
              }

              // Add addr1
              if (detail.addr1) {
                  $("#detail-content2").append('<p class="detail-addr1">' + detail.addr1 + '</p>');
              }

              // Add homepage link
              if (detail.homepage) {
                  // Extract URL from the homepage field
                  var homepageUrl = $(detail.homepage).attr('href');
                  $("#detail-content2").append('<p class="detail-link"><a href="' + homepageUrl + '" target="_blank">홈페이지 방문</a></p>');
              }
              // 지도에 마커 추가
              var mapContainer = document.getElementById('map');
              var mapOption = {
                center: new kakao.maps.LatLng(detail.mapy, detail.mapx),
                level: 5
              };
              var map = new kakao.maps.Map(mapContainer, mapOption);

              var markerPosition  = new kakao.maps.LatLng(detail.mapy, detail.mapx); 
              var marker = new kakao.maps.Marker({
                position: markerPosition
              });
              marker.setMap(map);

              $("#detail-box2").show();
              setTimeout(() => {
                  $("#detail-box2").addClass('show'); // Add the show class
              }, 10);
          },
          error: function(e) {
              console.log("에러");
              console.log(e);
          }
      });
  }


  function setupPagination(prevButtonId, nextButtonId, pageNumbersId, currentPage, totalPages, ajaxFunction, areaCode, themeCode, sigunguCode) {
      const prevButton = document.getElementById(prevButtonId);
      const nextButton = document.getElementById(nextButtonId);
      const pageNumbers = document.getElementById(pageNumbersId);

      function updatePagination() {
          pageNumbers.innerHTML = ""; // 페이지 번호 초기화
          const startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
          const endPage = Math.min(startPage + 9, totalPages);

          // << 버튼 (이전 그룹으로 이동)
          if (startPage > 1) {
              const prevGroupButton = document.createElement('span');
              prevGroupButton.textContent = '<<';
              prevGroupButton.className = 'page-number';
              prevGroupButton.addEventListener('click', function() {
                  currentPage = startPage - 10;
                  ajaxFunction(areaCode, themeCode, sigunguCode, "", currentPage); // AJAX 요청
                  updatePagination(); // 페이지네이션 업데이트
              });
              pageNumbers.appendChild(prevGroupButton);
          }

          // 페이지 번호 생성
          for (let i = startPage; i <= endPage; i++) {
              const pageNumber = document.createElement('span');
              pageNumber.textContent = i;
              pageNumber.className = 'page-number';
              if (i === currentPage) {
                  pageNumber.style.fontWeight = 'bold';
              }
              pageNumber.addEventListener('click', function() {
                  currentPage = i;
                  ajaxFunction(areaCode, themeCode, sigunguCode, "", currentPage); // AJAX 요청
                  updatePagination(); // 페이지네이션 업데이트
              });
              pageNumbers.appendChild(pageNumber);
          }

          // >> 버튼 (다음 그룹으로 이동)
          if (endPage < totalPages) {
              const nextGroupButton = document.createElement('span');
              nextGroupButton.textContent = '>>';
              nextGroupButton.className = 'page-number';
              nextGroupButton.addEventListener('click', function() {
                  currentPage = startPage + 10;
                  ajaxFunction(areaCode, themeCode, sigunguCode, "", currentPage); // AJAX 요청
                  updatePagination(); // 페이지네이션 업데이트
              });
              pageNumbers.appendChild(nextGroupButton);
          }
      }

      // 이전 버튼 클릭 이벤트
      prevButton.addEventListener('click', function() {
          if (currentPage > 1) {
              currentPage--;
              ajaxFunction(areaCode, themeCode, sigunguCode, "", currentPage); // AJAX 요청
              updatePagination(); // 페이지네이션 업데이트
          }
      });

      // 다음 버튼 클릭 이벤트
      nextButton.addEventListener('click', function() {
          if (currentPage < totalPages) {
              currentPage++;
              ajaxFunction(areaCode, themeCode, sigunguCode, "", currentPage); // AJAX 요청
              updatePagination(); // 페이지네이션 업데이트
          }
      });

      updatePagination(); // 페이지네이션 초기화
  }
  let data1 = []; // data1 변수를 정의
  
  $(document).ready(function() {
	  var selectedPlaces  = [];
	  
	  function updateSelectedPlaces() {
		    $('#selected-places-list').empty();
		    selectedPlaces.forEach(function(place, index) {
		        $('#selected-places-list').append('<li>' + place.place_name + ' <button class="remove-place" data-index="' + index + '">제거</button></li>');
		    });
		    $('#selected-places').val(JSON.stringify(selectedPlaces));
		    console.log("Updated selectedPlaces:", JSON.stringify(selectedPlaces)); // 디버그 로그 추가
		}

	  $(document).on('click', '.remove-place', function() {
        const index = $(this).data('index');
        selectedPlaces.splice(index, 1);
        updateSelectedPlaces();
      });
	  
	  
      // 시군구 선택 변경 시
      $('#area-select').on('change', function() {
          var areaCode = $(this).val();
          getSigunguCodes(areaCode);
      });

      $('#search-button2').click(function() {
          var selectedAreaCode = $('#area-select').val();
          var selectedThemeCode = $('#theme-select').val();
          var selectedSigunguCode = $('#sigungu-select').val();
          var searchValue = $('#search-input2').val();
          ajaxTest(selectedAreaCode, selectedThemeCode, selectedSigunguCode, searchValue, 1);
      });

      $('#nav-button2').click(function() {
    	  hideAllOverlays();
          var selectedAreaCode = $('#area-select').val();
          var selectedThemeCode = $('#theme-select').val();
          var selectedSigunguCode = $('#sigungu-select').val();
          currentPage2 = 1; // 초기 페이지 설정
          ajaxTest(selectedAreaCode, selectedThemeCode, selectedSigunguCode, "", currentPage2);
          var messageBox2 = document.getElementById('message-box2');
          messageBox2.style.display = 'block';
          setTimeout(() => {
              messageBox2.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#close-button2').click(function() {
          var messageBox2 = document.getElementById('message-box2');
          messageBox2.classList.remove('show');
          setTimeout(() => {
              messageBox2.style.display = 'none';
              hideOverlaysById(['detail-box2']);
          }, 500);
      });

      $('#detail-close-button2').click(function() {
          var detailBox2 = document.getElementById('detail-box2');
          detailBox2.classList.remove('show');
          setTimeout(() => {
              detailBox2.style.display = 'none';
          }, 500);
      });


      $('#close-button1').click(function() {
          var messageBox1 = document.getElementById('message-box1');
          messageBox1.classList.remove('show');
          setTimeout(() => {
              messageBox1.style.display = 'none';
              hideOverlaysById(['write-box1', 'detail-box1']);
          }, 500);
      });
      //카카오장소검색
     function searchPlaces() {
    var query = $('#kakao-search').val();
    if (!query) {
        $('#search-results').empty();
        return;
    }

    var places = new kakao.maps.services.Places();
    places.keywordSearch(query, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            $('#search-results').empty();
            result.forEach(function(place) {
                var listItem = $('<li>').text(place.place_name);
                listItem.data('place', place);
                listItem.on('click', function() {
                    var selectedPlace = $(this).data('place');
                    selectedPlaces.push({
                        place_name: selectedPlace.place_name,
                        place_lat: selectedPlace.y,
                        place_lng: selectedPlace.x
                    });
                    updateSelectedPlaces();
                    $('#search-results').empty();
                    $('#kakao-search').val('');
                });
                $('#search-results').append(listItem);
            });
        } else {
            $('#search-results').empty();
        }
    });
}

$('#kakao-search-button').click(function() {
    searchPlaces();
});

$('#kakao-search').on('keypress', function(e) {
    if (e.which === 13) {
        searchPlaces();
    }
});
    });	

      // 글쓰기 버튼 클릭 이벤트
      $('#write-button1').click(function() {
          var writeBox1 = document.getElementById('write-box1');
          writeBox1.style.display = 'block';
          setTimeout(() => {
              writeBox1.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#write-close-button1').click(function() {
          var writeBox1 = document.getElementById('write-box1');
          writeBox1.classList.remove('show');
          setTimeout(() => {
              writeBox1.style.display = 'none';
          }, 500);
      });


      // -> 해당 부분 하다 마신거같은데, 충분히 할 수 있습니다 :) 화이팅
      // $('#register-travel-form').submit(function(event) {
      //     event.preventDefault();
      //     const title = $('#write-title1').val();
      //     const description = $('#write-content1').val();
      //     if (title && description && selectedPlaces.length > 0) {
      //         // 폼 제출 처리
      //         $.ajax({
      //             url: '/home/registerTravelRoute',
      //             method: 'POST',
      //             data: $(this).serialize(),
      //             success: function(response) {
      //                 alert("등록이 완료되었습니다.");
      //                 $('#write-box1').hide();
      //                 // 추가 작업
      //             },
      //             error: function(error) {
      //                 alert("등록에 실패했습니다.");
      //                 console.error("Error registering travel plan:", error);
      //             }
      //         });
      //     } else {
      //         alert("모든 필드를 채우고 장소를 선택하세요.");
      //     }
      // });

      /* $('#write-submit1').click(function() {
          const title = $('#write-title1').val();
          const content = $('#write-content1').val();
          if (title && content) {
              data1.push({ title, content });
              $('#write-title1').val('');
              $('#write-content1').val('');
              renderList('message-list1', data1, currentPage1);
              setupPagination('prev-page1', 'next-page1', 'page-numbers1', currentPage1, Math.ceil(data1.length / itemsPerPage), renderList, 'message-list1', data1, currentPage1);
              var writeBox1 = document.getElementById('write-box1');
              writeBox1.classList.remove('show');
              setTimeout(() => {
                  writeBox1.style.display = 'none';
              }, 500);
          }
      });  */

      // 괜찮았어? 게시판 이벤트 설정
      $('#nav-button3').click(function() {
        
          var messageBox3 = document.getElementById('message-box3');
          messageBox3.style.display = 'block';
          setTimeout(() => {
              messageBox3.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#close-button3').click(function() {
          var messageBox3 = document.getElementById('message-box3');
          messageBox3.classList.remove('show');
          setTimeout(() => {
              messageBox3.style.display = 'none';
              hideOverlaysById(['detail-box3']);
          }, 500);
      });

      $('.clickable-image').click(function() {
          var detailBox3 = document.getElementById('detail-box3');
          detailBox3.style.display = 'block';
          setTimeout(() => {
              detailBox3.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#view-photos-button').click(function() {
          var photoBox3 = document.getElementById('photo-box3');
          photoBox3.style.display = 'block';
          setTimeout(() => {
              photoBox3.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#photo-close-button3').click(function() {
          var photoBox3 = document.getElementById('photo-box3');
          photoBox3.classList.remove('show');
          setTimeout(() => {
              photoBox3.style.display = 'none';
          }, 500);
      });

      $('#view-comments-button').click(function() {
          var commentsBox3 = document.getElementById('comments-box3');
          commentsBox3.style.display = 'block';
          setTimeout(() => {
              commentsBox3.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#comments-close-button3').click(function() {
          var commentsBox3 = document.getElementById('comments-box3');
          commentsBox3.classList.remove('show');
          setTimeout(() => {
              commentsBox3.style.display = 'none';
          }, 500);
      });

      $('#detail-close-button3').click(function() {
          var detailBox3 = document.getElementById('detail-box3');
          detailBox3.classList.remove('show');
          setTimeout(() => {
              detailBox3.style.display = 'none';
          }, 500);
      });

      // 고객센터 이벤트 설정
      $('#nav-button4').click(function() {
          var qaFaqButtons = document.getElementById('qa-faq-buttons');
          qaFaqButtons.style.display = 'block';
          setTimeout(() => {
              qaFaqButtons.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#qa-faq-close-button').click(function() {
          var qaFaqButtons = document.getElementById('qa-faq-buttons');
          qaFaqButtons.classList.remove('show');
          setTimeout(() => {
              qaFaqButtons.style.display = 'none';
          }, 500);
      });

      $('#qa-close-button').click(function() {
          var qaBox = document.getElementById('qa-box');
          qaBox.classList.remove('show');
          setTimeout(() => {
              qaBox.style.display = 'none';
              hideOverlaysById(['qa-write-box', 'qa-detail-box']);
          }, 500);
      });

      $('#qa-write-button').click(function() {
          var qaWriteBox = document.getElementById('qa-write-box');
          qaWriteBox.style.display = 'block';
          setTimeout(() => {
              qaWriteBox.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#qa-write-close-button').click(function() {
          var qaWriteBox = document.getElementById('qa-write-box');
          qaWriteBox.classList.remove('show');
          setTimeout(() => {
              qaWriteBox.style.display = 'none';
          }, 500);
      });

      $('#qa-write-submit').click(function() {
          const title = $('#qa-write-title').val();
          const content = $('#qa-write-content').val();
          if (title && content) {
              const date = new Date().toISOString().split('T')[0];
              qaData.push({ title, content, author: '작성자', date });
              $('#qa-write-title').val('');
              $('#qa-write-content').val('');
              renderTable('qa-list', qaData, currentPageQA);
              setupPagination('prev-page-qa', 'next-page-qa', 'page-numbers-qa', currentPageQA, Math.ceil(qaData.length / itemsPerPage), renderTable, 'qa-list', qaData, currentPageQA);
              var qaWriteBox = document.getElementById('qa-write-box');
              qaWriteBox.classList.remove('show');
              setTimeout(() => {
                  qaWriteBox.style.display = 'none';
              }, 500);
          }
      });

      $('#qa-list').on('click', 'tr', function() {
          const content = $(this).data('content');
          $('#qa-detail-content').text(content);
          var qaDetailBox = document.getElementById('qa-detail-box');
          qaDetailBox.style.display = 'block';
          setTimeout(() => {
              qaDetailBox.classList.add('show'); // Add the show class
          }, 10);
      });

      $('#qa-detail-close-button').click(function() {
          var qaDetailBox = document.getElementById('qa-detail-box');
          qaDetailBox.classList.remove('show');
          setTimeout(() => {
              qaDetailBox.style.display = 'none';
          }, 500);
      });

      // FAQ 이벤트 설정
      $('#faq-button').click(function() {
          var faqBox = document.getElementById('faq-box');
          faqBox.style.display = 'block';
          setTimeout(() => {
              faqBox.classList.add('show'); // Add the show class
              displayFAQ();
          }, 10);
      });

      $('#faq-close-button').click(function() {
          var faqBox = document.getElementById('faq-box');
          faqBox.classList.remove('show');
          setTimeout(() => {
              faqBox.style.display = 'none';
          }, 500);
      });
   // FAQ 내용 표시 함수
      function displayFAQ() {
        const faqContent = [
        	 {
        	        question: "어떻게 여행 친구를 구할 수 있나요?",
        	        answer: "회원가입 후, 같이 갈래? 페이지에서 자신의 여행 계획을 등록하면 다른 회원들이 여행계획에 동참할 수 있습니다."
        	      },
        	      {
        	        question: "여행지 추천은 어떻게 받나요?",
        	        answer: "회원가입 후, 이건 어때? 페이지에서 지역별, 테마별로 검색할 수 있습니다."
        	      },
        	      {
        	        question: "여행 후기를 어떻게 남기나요?",
        	        answer: "여행이 끝난 후, 괜찮았어? 페이지에 글을 등록할 수 있습니다."
        	      },
        	      {
        	        question: "여행 친구와 어떻게 연락하나요?",
        	        answer: "여행 친구 찾기 페이지에서 친구 신청을 보내고, 수락된 후에 사이트 내 메시지 기능을 통해 연락할 수 있습니다."
        	      },
        	      {
        	        question: "특정 조건에 맞는 여행 친구를 어떻게 찾나요?",
        	        answer: "검색 필터를 사용하여 나이, 성별, 취향 등의 조건을 설정하고 검색하면 원하는 조건에 맞는 친구를 찾을 수 있습니다."
        	      },
        	      {
        	        question: "다른 사람들이 작성한 여행 후기를 볼 수 있나요?",
        	        answer: "네, 후기 페이지에서 다양한 여행 후기를 확인할 수 있으며, 유용한 후기를 추천할 수도 있습니다."
        	      },
        	      {
        	        question: "사이트 이용 중 문제가 발생하면 어떻게 해야 하나요?",
        	        answer: "고객센터 페이지에서 문의를 남기거나, 실시간 채팅을 통해 도움을 받을 수 있습니다."
        	      },
   ];

        const faqContainer = document.getElementById('faq-content');
        faqContainer.innerHTML = '';
        faqContent.forEach(item => {
          const question = document.createElement('h3');
          question.textContent = item.question;
          const answer = document.createElement('p');
          answer.textContent = item.answer;
          faqContainer.appendChild(question);
          faqContainer.appendChild(answer);
        });
      }

  </script>
  
  <!-- 지도 script -->
  <script type="text/javascript">

  var container = document.getElementById('map1'); //지도를 담을 영역의 DOM 레퍼런스
  var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(37.489996,126.927081), //지도의 중심좌표.
      level: 3 //지도의 레벨(확대, 축소 정도)
  };

  var map1 = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
  var markerPosition  = new kakao.maps.LatLng(37.489996, 126.927081);  // 마커가 표시될 위치입니다

  var marker = new kakao.maps.Marker({
      position: markerPosition
  });
  marker.setMap(map1);
  
 
  </script>
 
 
<script>
    document.addEventListener("DOMContentLoaded", function() {
        console.log("travel-routes-json:", document.getElementById("travel-routes-json").value);
    });
</script>


</body>
</html>
