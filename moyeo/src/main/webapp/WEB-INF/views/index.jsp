<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prototype</title>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@5.0.0/bundles/stomp.umd.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
            rel="stylesheet">
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a548dc6d5b22802d185f641807cca585&libraries=services"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    <link rel='stylesheet'
          href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css'>

    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        .hidden {
            display: none;
        }

        .image-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr); /* 한 줄에 4개씩 배치 */
            gap: 1rem;
        }

        .image-grid li {
            background-size: cover;
            background-position: center;
            padding-top: 75%; /* 4:3 aspect ratio (세로 길이를 늘림) */
            position: relative;
        }

        .title-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.5);
            color: #fff;
            padding: 0.5rem;
            text-align: center;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            margin-top: 1rem;
        }

        button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 0.375rem;
            background-color: #e0e0e0;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        button:hover {
            background-color: #b0b0b0;
            transform: scale(1.05);
        }
    </style>
    <style>

        h1 {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2d3748; /* text-gray-800 */
            margin-bottom: 1.5rem;
        }

        nav ul {
            list-style: none;
            padding: 0;
        }

        nav ul li {
            margin-bottom: 1rem;
        }

        .menu-button {
            width: 100%;
            text-align: left;
            padding: 0.75rem;
            background-color: #edf2f7; /* bg-gray-200 */
            border-radius: 0.5rem;
            transition: background-color 0.3s, color 0.3s, transform 0.3s;
            font-size: 1rem;
            display: flex;
            align-items: center;
            color: #2d3748; /* text-gray-800 */
        }

        .menu-button:hover {
            background-color: #4299e1; /* bg-blue-500 */
            color: white;
            transform: translateY(-2px);
        }

        .menu-button i {
            margin-right: 0.75rem;
            font-size: 1.25rem;
        }

        .menu-button.active {
            background-color: #4299e1; /* bg-blue-500 */
            color: white;
        }
        
        #ad {
        	bottom: 10px;
    		position: absolute;
    		width: 20%;
    		height: 20%;
        }
        
    </style>

</head>
<body class="bg-gray-100 text-gray-900">
<div class="flex h-screen">
    <div class="w-1/4 bg-white shadow-lg p-6 rounded-lg">
        <div class="flex items-center justify-between mb-6">
            <h1 class="text-2xl font-bold text-gray-800">모두의 여행, 모여!</h1>
        </div>
        <!-- 왼쪽 사이드바 메뉴 목록 -->
        <nav>
            <ul>
                <li class="mb-4">
                    <button
                            class="menu-button w-full text-left flex items-center p-3 bg-gray-200 rounded-lg hover:bg-blue-500 hover:text-white transition duration-300"
                            data-target="menu0-content">
                        <i class="fas fa-users mr-3"></i> 내 정보
                    </button>
                </li>
                <li class="mb-4">
                    <button
                            class="menu-button w-full text-left flex items-center p-3 bg-gray-200 rounded-lg hover:bg-blue-500 hover:text-white transition duration-300"
                            data-target="menu1-content">
                        <i class="fas fa-users mr-3"></i> 같이 갈래?
                    </button>
                </li>
                <li class="mb-4">
                    <button
                            class="menu-button w-full text-left flex items-center p-3 bg-gray-200 rounded-lg hover:bg-blue-500 hover:text-white transition duration-300"
                            data-target="menu2-content">
                        <i class="fas fa-thumbs-up mr-3"></i> 이건 어때?
                    </button>
                </li>
                <li class="mb-4">
                    <button
                            class="menu-button w-full text-left flex items-center p-3 bg-gray-200 rounded-lg hover:bg-blue-500 hover:text-white transition duration-300"
                            data-target="menu3-content">
                        <i class="fas fa-check mr-3"></i> 괜찮았어?
                    </button>
                </li>
                <li class="mb-4">
                    <button
                            class="menu-button w-full text-left flex items-center p-3 bg-gray-200 rounded-lg hover:bg-blue-500 hover:text-white transition duration-300"
                            data-target="menu4-content">
                        <i class="fas fa-headset mr-3"></i> 고객센터
                    </button>
                </li>
            </ul>
        </nav>
        <div id="ad"><a href="https://jejutrip.kr/"><img src="../../resources/imgs/ad.jpg"></a></div>
    </div>
    <!-- Main Content -->
    <div class="flex-1 p-6">
        <!-- 메뉴 0 - 내 정보 메뉴 -->
        <div class="h-full overflow-y-auto p-6" id="menu0-content">
            <h2 class="text-xl font-bold mb-2">
                <c:out value="${loggedUser.username}" />님 환영합니다.
            </h2>
            <hr class="my-4">
            <div class="flex justify-between mb-4">
                <button id="My-information-button" class="p-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition duration-300">
                    내 정보수정
                </button>
                <c:if test="${hasNewParticipationRequests}">
                    <button id="participation-request-button" class="p-2 bg-yellow-500 text-white rounded hover:bg-yellow-600 transition duration-300">
                        참여하고자 하는 사람이 있어요!
                    </button>
                </c:if>

                <button id="logout" class="p-2 bg-red-500 text-white rounded hover:bg-red-600 transition duration-300">
                    로그아웃
                </button>
            </div>
            <!-- 참여 요청자 명단 팝업 -->
            <div id="participation-request-popup" class="fixed inset-0 bg-black bg-opacity-50 hidden">
                <div class="bg-white p-6 rounded-lg shadow-lg max-w-md mx-auto mt-20">
                    <h2 class="text-xl font-bold mb-4">참여 요청자 명단</h2>
                    <ul id="request-list" class="mb-4">
                        <!-- 요청자 목록이 동적으로 추가될 부분 -->
                    </ul>
                    <button id="popup-close-button" class="p-2 bg-gray-500 text-white rounded hover:bg-gray-600 transition duration-300">
                        닫기
                    </button>
                </div>
            </div>
            <hr class="my-4">
            <h1 class="text-lg font-bold mb-2">내 계획</h1>
            <h3 class="text-sm mb-4">
                <c:out value="${loggedUser.username}" />님이 작성한 계획입니다.
            </h3>
            <div class="grid grid-cols-2 gap-4" id="travel-my-plan-list">
                <c:forEach var="i" items="${travelPlanList}">
                    <c:forEach var="j" items="${userList}">
                        <c:if test="${i.user_id == j.user_id}">
                            <c:if test="${loggedUser.user_id == i.user_id}">
                                <div class="p-4 bg-white shadow rounded flex items-center justify-between hover:bg-gray-100 transition duration-300 cursor-pointer"
                                     onclick="JoinDetail('${i.plan_id}', '${i.title}', '${i.description}', '${j.username}', '${i.start_date}', '${i.end_date}', '${i.created_at}')">
                                    <div>
                                        <h3 class="font-bold">${i.title}</h3>
                                        <p class="text-gray-600">${j.username}</p>
                                        <p class="text-gray-600 start-date">${i.start_date} ~ ${i.end_date}</p>
                                    </div>
                                    <div class="w-16 h-16 bg-gray-300 rounded-lg flex items-center justify-center">
                                        <!-- 여기에 썸네일 이미지를 넣을 수 있습니다 -->
                                        <i class="fas fa-map-marked-alt text-gray-500"></i>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </div>
            <h1 class="text-lg font-bold mb-2">참여중인 계획</h1>
            <h3 class="text-sm mb-4">
                현재 참여중인 계획입니다.
            </h3>
            <div class="grid grid-cols-2 gap-4" id="travel-participating-plan-list">
                <c:forEach var="plan" items="${participatingPlans}">
                    <div class="participating-plan p-4 bg-white shadow rounded flex items-center justify-between hover:bg-gray-100 transition duration-300 cursor-pointer"
                         data-plan-id="${plan.plan_id}"
                         onclick="openChat('${plan.plan_id}')">
                        <div>
                            <h3 class="font-bold">${plan.title}</h3>
                            <p class="text-gray-600">${plan.author.username}</p>
                            <p class="text-gray-600 start-date">${plan.start_date} ~ ${plan.end_date}</p>
                        </div>
                        <div class="w-16 h-16 bg-gray-300 rounded-lg flex items-center justify-center">
                            <!-- 여기에 썸네일 이미지를 넣을 수 있습니다 -->
                            <i class="fas fa-map-marked-alt text-gray-500"></i>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div id="chat-container" class="hidden flex flex-col h-full">
            <div id="message-list" class="flex-1 overflow-y-auto p-4 bg-white rounded-lg shadow-md">
                <!-- 메시지가 여기에 추가됩니다 -->
            </div>
            <div class="flex items-center mt-4">
                <input type="text" id="message-input" class="flex-1 p-2 border rounded-l-lg focus:outline-none" placeholder="메시지를 입력하세요...">
                <button id="send-button" class="p-2 bg-blue-500 text-white rounded-r-lg hover:bg-blue-600 transition duration-300">전송</button>
            </div>
        </div>
        <%-- 같이 갈래? 메뉴--%>
        <div class="hidden h-full overflow-y-auto" id="menu1-content">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-xl font-bold">같이 갈래?</h2>
                <form class="flex items-center space-x-2" id="search-form1">
                    <input type="text" id="search-input1" placeholder="검색 어때?"
                           name="keyword" class="p-2 border rounded"> <input
                        type="hidden" name="pageNum">
                </form>
            </div>
            <div class="flex items-center justify-between mb-4">
                <div class="flex items-center space-x-2">
                    <label for="sort-select" class="text-sm font-medium">정렬:</label> <select
                        id="sort-select" class="p-2 border rounded">
                    <option value="latest">최신순</option>
                    <option value="oldest">오래된 순</option>
                    <option value="closest">가까운 여행일자</option>
                </select>
                </div>
                <button class="p-2 bg-blue-500 text-white rounded"
                        id="write-post-btn">글쓰기</button>
            </div>
            <div class="grid grid-cols-2 gap-4" id="travel-plan-list">
                <c:forEach var="i" items="${travelPlanList}">
                    <c:forEach var="j" items="${userList}">
                        <c:if test="${i.user_id == j.user_id}">
                            <div
                                    class="p-4 bg-white shadow rounded flex items-center justify-between"
                                    onclick="JoinDetail('${i.plan_id}', '${i.title}', '${i.description}', '${j.username}', '${i.start_date}', '${i.end_date}', '${i.created_at}')">
                                <div>
                                    <h3 class="font-bold">${i.title}</h3>
                                    <p>${j.username}</p>
                                    <p class="start-date">${i.start_date}~${i.end_date}</p>
                                </div>
                                <div class="w-16 h-16 bg-gray-300"></div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </div>
            <input type="hidden" id="totalPages" value="${totalPages}">
            <div id="loader" class="text-center py-4 hidden">
                <i class="fas fa-spinner fa-spin"></i> Loading...
            </div>
        </div>


        <!-- 같이 갈래? -> 글 클릭 시 세부사항 -->
        <div class="hidden h-full overflow-y-auto" id="menu1-content-detail">
            <div class="bg-white shadow-lg rounded-lg p-6 mb-6 relative">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-2xl font-bold text-gray-800">세부 사항</h2>
                    <form id="planDelete"
                          action="${pageContext.request.contextPath}/home/planDelete"
                          method="get" class="absolute top-6 right-28">
                        <button
                                class="p-2 bg-red-500 text-white rounded-full hover:bg-red-700">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </form>
                    <button id="planEdit1"
                            class="p-2 bg-blue-500 text-white rounded-full hover:bg-blue-700 absolute top-6 right-16"
                            onclick="joinEditShow()">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button
                            class="p-2 bg-gray-500 text-white rounded-full hover:bg-gray-700"
                            id="detail-close-button">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div id="join-detail-content" class="space-y-4"></div>
                <div id="join-detail-mod" class="mt-4"></div>
                <div id="travel-route-details" class="mt-4 space-y-2"></div>
                <!-- 지도를 표시할 div -->
                <div id="map2" class="mt-4 rounded-lg shadow-lg" style="width: 100%; height: 400px;"></div>
                <!-- 나도 할래 버튼 추가 -->
                <div class="mt-6 flex justify-center">
                    <button id="join-request-button" class="p-3 bg-green-500 text-white rounded-lg hover:bg-green-700 transition duration-300">
                        나도 할래!
                    </button>
                </div>
            </div>
        </div>


        <%-- 같이 갈래 -> 글 -> 수정 버튼 클릭 시 수정 폼 --%>
        <div id="detail-box1-2" class="overlay right-large"
             style="display: none;">
            <h2>수정하기</h2>
            <form id="planEdit" action="<c:url value='/home/planEdit'/>"
                  method="get">
                <button>수정</button>
                <div id="planEdit2"></div>
            </form>
            <button id="detail-close-button1">닫기</button>
        </div>

        <%-- 같이 갈래? -> 글 쓰기 입력창 --%>
        <div class="hidden h-full overflow-y-auto" id="menu1-content-write">
            <h2 class="text-xl font-bold mb-4">글쓰기</h2>
            <form id="post-form" method="post"
                  action="${pageContext.request.contextPath}/home/registerTravelRoute">
                <div class="mb-4">
                    <label class="block text-sm font-medium mb-2">제목</label> <input
                        type="text" class="p-2 border rounded w-full" name="title"
                        required>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium mb-2">내용</label>
                    <textarea class="p-2 border rounded w-full" name="description"
                              rows="4" required></textarea>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium mb-2">출발일</label> <input
                        type="date" class="p-2 border rounded w-full" name="start_date"
                        required>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium mb-2">종료일</label> <input
                        type="date" class="p-2 border rounded w-full" name="end_date"
                        required>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium mb-2">장소 검색</label> <input
                        type="text" id="kakao-search" placeholder="장소 검색"
                        class="p-2 border rounded w-full">
                    <button type="button" id="kakao-search-button"
                            class="p-2 bg-blue-500 text-white rounded">검색</button>
                    <ul id="search-results" class="mt-2"></ul>
                </div>
                <ul id="selected-places-list" class="mb-4"></ul>
                <!-- 선택된 장소 목록을 보여줄 곳 -->
                <input type="hidden" id="selected-places" name="selected_places">
                <!-- 선택된 장소 데이터를 저장할 히든 필드 -->
                <button type="submit" class="p-2 bg-blue-500 text-white rounded">저장</button>
                <button type="button" class="p-2 bg-gray-500 text-white rounded"
                        id="cancel-post-btn">취소</button>
            </form>
        </div>

        <!-- Menu 2 Content (이건 어때?) -->
        <div class="hidden overlay large" id="menu2-content">
            <div class="p-6">
                <h1 class="text-xl font-bold mb-4">이건 어때? 게시판</h1>
                <div class="mb-4 flex space-x-2">
                    <!-- flexbox 사용 -->
                    <div class="flex-1">
                        <label class="block text-sm font-medium mb-2" for="area-select">지역
                            선택:</label> <select class="p-2 border rounded w-full" id="area-select">
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
                    </div>
                    <div class="flex-1">
                        <label class="block text-sm font-medium mb-2"
                               for="sigungu-select">시군구 선택:</label> <select
                            class="p-2 border rounded w-full" id="sigungu-select">
                        <option value="">선택</option>
                    </select>
                    </div>
                    <div class="flex-1">
                        <label class="block text-sm font-medium mb-2" for="theme-select">테마
                            선택:</label> <select class="p-2 border rounded w-full" id="theme-select">
                        <option value="12">관광지</option>
                        <option value="14">문화시설</option>
                        <option value="15">축제공연행사</option>
                        <option value="25">여행코스</option>
                        <option value="28">레포츠</option>
                        <option value="32">숙박</option>
                        <option value="38">쇼핑</option>
                        <option value="39">음식점</option>
                    </select>
                    </div>
                </div>
                <div class="mb-4 flex space-x-2">
                    <!-- flexbox 사용 -->
                    <input type="text" class="p-2 border rounded flex-1"
                           id="search-input2" placeholder="검색어 입력">
                    <button class="p-2 bg-blue-500 text-white rounded"
                            id="search-button2">검색</button>
                </div>
                <ul id="resultTestApi" class="image-grid"></ul>
                <!-- 결과를 표시할 리스트 -->
                <div
                        class="pagination flex items-center justify-center space-x-2 mt-4">
                    <button class="p-2 bg-gray-300 rounded" id="prev-page2">이전</button>
                    <div id="page-numbers2" class="page-numbers flex space-x-1"></div>
                    <button class="p-2 bg-gray-300 rounded" id="next-page2">다음</button>
                </div>
                <button class="p-2 bg-gray-500 text-white rounded mt-4"
                        id="close-button2">닫기</button>
            </div>
        </div>
        <div id="detail-box2" class="hidden overlay right-large">
            <h2>세부 사항</h2>
            <div id="detail-content2"></div>
            <!-- 카카오 지도 -->
            <div id="map" class="mt-4 rounded-lg shadow-lg" style="width:256px; height:256px;"></div>
            <button id="detail-close-button2">닫기</button>
        </div>

        <!-- Menu 3 Content (괜찮았어?) -->
        <div class="hidden h-full overflow-y-auto" id="menu3-content">
            <h2 class="text-xl font-bold mb-4">괜찮았어?</h2>
            <!-- Add your content for this menu here -->
        </div>

        <!-- Menu 4 Content (고객센터) -->
        <div class="hidden h-full overflow-y-auto" id="menu4-content">
            <h2 class="text-xl font-bold mb-4">고객센터</h2>
            <div class="flex justify-center space-x-4 mb-4">
                <button id="qa-button"
                        class="p-4 bg-blue-500 text-white rounded-lg hover:bg-blue-700 transition duration-300"
                        onclick="showQA()">Q/A</button>
                <button id="faq-button"
                        class="p-4 bg-green-500 text-white rounded-lg hover:bg-green-700 transition duration-300"
                        onclick="showFAQ()">FAQ</button>
            </div>
            <!-- Q/A 게시판 -->
            <div id="qa-content" class="hidden">
                <h3 class="text-lg font-bold mb-2">Q/A 게시판</h3>
                <button id="qa-write-button"
                        class="p-2 bg-blue-500 text-white rounded">글쓰기</button>
                <form action="/home/QaSearch" method="get" class="mb-4">
                    <input id="qaSearch" type="text" name="keyword" placeholder="검색"
                           class="p-2 border rounded" /> <input type="hidden"
                                                                name="pageNum">
                    <button onclick="loadQaPage()" id="qa-search-button"
                            class="p-2 bg-blue-500 text-white rounded">검색</button>
                </form>
                <table class="w-full bg-white shadow rounded mb-4">
                    <thead>
                    <tr>
                        <th class="p-2">번호</th>
                        <th class="p-2">제목</th>
                        <th class="p-2">작성자</th>
                        <th class="p-2">작성일</th>
                        <th class="p-2">답변여부</th>
                    </tr>
                    </thead>
                    <tbody id="qa-list">
                    <c:forEach var="i" items="${qaList}" begin="${page.firstPost}"
                               end="${page.lastPost}">
                        <c:forEach var="j" items="${userList}">
                            <c:if test="${i.user_id == j.user_id}">
                                <tr>
                                    <td class="p-2">${i.qa_id}</td>
                                    <td class="p-2"><a href="javascript:void(0);"
                                                       onclick="QaDetail('${i.title}','${i.question}','${j.username}','${i.created_at}','${i.answer}')">
                                        <c:choose>
                                            <c:when test="${i.title.length() >= 5}">
                                                ${i.title.substring(0, 5)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${i.title}
                                            </c:otherwise>
                                        </c:choose>
                                    </a></td>
                                    <td class="p-2">${j.username}</td>
                                    <td class="p-2">${i.created_at}</td>
                                    <td class="p-2"><c:if test="${i.answer != null}">
                                        답변완료
                                    </c:if></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                    </tbody>
                </table>
                <div
                        class="pagination flex items-center justify-center space-x-2 mt-4"
                        id="qa-pagination">
                    <!-- 페이지네이션 버튼이 여기에 동적으로 추가됩니다. -->
                </div>
            </div>
            <%-- QA -> 글 쓰기 입력창 --%>
            <div class="hidden overflow-y-auto" id="qa-content-write">
                <h2 class="text-xl font-bold mb-4">글쓰기</h2>
                <form id="qa-post-form" method="get"
                      action="${pageContext.request.contextPath}/home/QaRegister">
                    <div class="mb-4">
                        <label class="block text-sm font-medium mb-2">제목</label> <input
                            type="text" class="p-2 border rounded w-full" name="title"
                            required>
                    </div>
                    <div class="mb-4">
                        <label class="block text-sm font-medium mb-2">내용</label>
                        <textarea class="p-2 border rounded w-full" name="question"
                                  rows="4" required></textarea>							</div>
                    <button type="submit" class="p-2 bg-blue-500 text-white rounded">저장</button>
                    <button type="button" class="p-2 bg-gray-500 text-white rounded" id="qa-cancel-btn">취소</button>
                </form>
            </div>
            <!-- QA세부사항 -->
            <div class="hidden h-full overflow-y-auto" id="menu4-content-detail">
                <div class="bg-white shadow-lg rounded-lg p-6 mb-6 relative">
                    <div class="flex items-center justify-between mb-4">
                        <h2 class="text-2xl font-bold text-gray-800">세부 사항</h2>
                        <button
                                class="p-2 bg-gray-500 text-white rounded-full hover:bg-gray-700"
                                id="detail-close-button4">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div id="qa-detail-content" class="space-y-4"></div>
                    <div id="qa-detail-mod" class="mt-4"></div>
                </div>
            </div>
            <!-- FAQ 창 -->
            <div class="faq-content" id="faq-content">
                <div id="faq-box" class="overlay half-right-large"
                     style="left: 260px;">
                    <h2>FAQ</h2>
                    <table class="w-full bg-white shadow rounded mb-4">
                        <thead>
                        <tr>
                            <th>작성번호</th>
                            <th>질문</th>
                        </tr>
                        </thead>
                        <tbody id="faq-list">
                        <c:forEach var="faq" items="${FaqList}">
                            <tr class="question-row" data-faq-id="${faq.faq_id}">
                                <td>${faq.faq_id}</td>
                                <td><a href="javascript:void(0);"> <c:choose>
                                    <c:when test="${faq.question.length() > 20}">
                                        ${faq.question.substring(0, 20)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${faq.question}
                                    </c:otherwise>
                                </c:choose>
                                </a></td>
                            </tr>
                            <tr class="answer-row" id="answer-${faq.faq_id}"
                                style="display: none;">
                                <td colspan="2">${faq.answer}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <button id="faq-close-button">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let selectedPlanId = null;

    function QaDetail(title, question, username, created_at, answer) {
        $("#qa-detail-content").empty();
        var QaDetail = document.getElementById('menu4-content-detail');
        QaDetail.classList.remove('hidden');

        const title_p = document.createElement('p');
        title_p.classList.add('text-xl', 'font-bold', 'mb-2');
        const title_message = document.createTextNode("제목: " + title);
        title_p.appendChild(title_message);
        document.getElementById('qa-detail-content').appendChild(title_p);

        const question_p = document.createElement('p');
        question_p.classList.add('text-xl', 'font-bold', 'mb-2');
        const question_message = document.createTextNode("질문: "+question);
        question_p.appendChild(question_message);
        document.getElementById('qa-detail-content').appendChild(question_p);

        const username_p = document.createElement('p');
        username_p.classList.add('text-xl', 'font-bold', 'mb-2');
        const username_message = document.createTextNode("작성자: "+username);
        username_p.appendChild(username_message);
        document.getElementById('qa-detail-content').appendChild(username_p);

        const created_at_p = document.createElement('p');
        created_at_p.classList.add('text-xl', 'font-bold', 'mb-2');
        const created_at_message = document.createTextNode("작성일: "+created_at);
        created_at_p.appendChild(created_at_message);
        document.getElementById('qa-detail-content').appendChild(created_at_p);

        const answer_p = document.createElement('p');
        answer_p.classList.add('text-xl', 'font-bold', 'mb-2');
        const answer_message = document.createTextNode("답변: "+answer);
        answer_p.appendChild(answer_message);
        document.getElementById('qa-detail-content').appendChild(answer_p);

    };
    function JoinDetail(plan_id, title, description, username, start_date, end_date, created_at) {
        selectedPlanId = plan_id;
        // "같이 갈래?" 메뉴 숨기기
        document.getElementById('menu1-content').classList.add('hidden');
        document.getElementById('menu0-content').classList.add('hidden');

        // 상세 글 표시
        var joinDetail = document.getElementById('menu1-content-detail');
        joinDetail.classList.remove('hidden');

        $("#join-detail-content").empty();
        $("#travel-route-details").empty();
        $("#map2").empty(); // 지도를 초기화

        JoinDeleteInput(plan_id);
        planEdit(plan_id, title, description, username, start_date, end_date, created_at);

        // CSS 스타일링 추가
        const title_p = document.createElement('p');
        title_p.classList.add('text-xl', 'font-bold', 'mb-2');
        const title_message = document.createTextNode("제목: " + title);
        title_p.appendChild(title_message);
        document.getElementById('join-detail-content').appendChild(title_p);

        const description_p = document.createElement('p');
        description_p.classList.add('text-base', 'mb-2');
        const description_message = document.createTextNode("설명: " + description);
        description_p.appendChild(description_message);
        document.getElementById('join-detail-content').appendChild(description_p);

        const username_p = document.createElement('p');
        username_p.classList.add('text-sm', 'text-gray-600', 'mb-2');
        const username_message = document.createTextNode("작성자: " + username);
        username_p.appendChild(username_message);
        document.getElementById('join-detail-content').appendChild(username_p);

        const start_date_p = document.createElement('p');
        start_date_p.classList.add('text-sm', 'text-gray-600', 'mb-2');
        const start_date_message = document.createTextNode("시작일: " + start_date);
        start_date_p.appendChild(start_date_message);
        document.getElementById('join-detail-content').appendChild(start_date_p);

        const end_date_p = document.createElement('p');
        end_date_p.classList.add('text-sm', 'text-gray-600', 'mb-2');
        const end_date_message = document.createTextNode("종료일: " + end_date);
        end_date_p.appendChild(end_date_message);
        document.getElementById('join-detail-content').appendChild(end_date_p);

        const created_at_p = document.createElement('p');
        created_at_p.classList.add('text-sm', 'text-gray-600', 'mb-2');
        const created_at_message = document.createTextNode("작성일: " + created_at);
        created_at_p.appendChild(created_at_message);
        document.getElementById('join-detail-content').appendChild(created_at_p);

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
                        routeItem.classList.add('text-sm', 'text-gray-700', 'mb-1');
                        const routeMessage = document.createTextNode("장소: " + route.location + ", Day: " + route.day + ", Order: " + route.order);
                        console.log(route.location);
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
                                content: '<div style="padding:5px;background:white;border:1px solid black;border-radius:50%;width:40px;height:40px;text-align:center;line-height:30px;">' + route.order + '</div>',
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
                        strokeWeight: 3,
                        strokeColor: '#FFAE00',
                        strokeOpacity: 0.5,
                        strokeStyle: 'solid'
                    });
                    polyline.setMap(map2);
                } else {
                    $("#travel-route-details").append('<p class="text-gray-500">저장된 여행 경로가 없습니다.</p>');
                }
            },
            error: function(error) {
                console.error("Error fetching travel routes: ", error);
                $("#travel-route-details").append('<p class="text-red-500">여행 경로를 가져오는 데 오류가 발생했습니다.</p>');
                // 지도를 숨깁니다.
                $("#map2").hide();
            }
        });



    }
    const currentUserId = ${loggedUser.user_id};
    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('join-request-button').addEventListener('click', function() {
            if (!selectedPlanId) {
                alert('여행 계획을 먼저 선택하세요.');
                return;
            }
            console.log("userId:", currentUserId, "planId:", selectedPlanId);

            // AJAX 요청으로 동행 신청 보내기
            $.ajax({
                url: '/home/requestCompanion', // 동행 신청 처리 경로
                type: 'POST',
                data: { planId: selectedPlanId }, // planId만 전송
                success: function(response) {
                    if (response.success) {
                        alert('동행 신청이 완료되었습니다.');
                    } else {
                        alert('이미 동행 신청을 하셨습니다.');
                    }
                },
                error: function(error) {
                    console.error('Error processing request:', error);
                    alert('동행 신청 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    });


    function joinEditShow() {
        var detailBox2 = document.getElementById('detail-box1-2');
        // 모든 콘텐츠 숨기기
        document.querySelectorAll('.flex-1 > div').forEach(div => div.classList.add('hidden'));

        detailBox2.style.display = 'block';
        detailBox2.classList.add("show");
    }

    document.addEventListener('DOMContentLoaded', (event) => {
        const selectedPlaces = [];

        document.querySelectorAll('nav button').forEach(button => {
            button.addEventListener('click', () => {
                // 모든 콘텐츠 숨기기
                document.querySelectorAll('.flex-1 > div').forEach(div => div.classList.add('hidden'));
                // 선택한 콘텐츠 표시
                const targetId = button.getAttribute('data-target');
                document.getElementById(targetId).classList.remove('hidden');
                if (targetId == 'menu4-content') {
                    resetFaqBox();
                }
            });
        });

        document.getElementById('search-form1').addEventListener('submit', function(event) {
            event.preventDefault();
            const keyword = document.getElementById('search-input1').value;
            fetchSearchResults(keyword);
        });

        // 글쓰기 버튼 클릭 시 폼 보이기
        document.getElementById('write-post-btn').addEventListener('click', () => {
            document.getElementById('menu1-content').classList.add('hidden');
            document.getElementById('menu1-content-write').classList.remove('hidden');
        });

        // 취소 버튼 클릭 시 폼 숨기기
        document.getElementById('cancel-post-btn').addEventListener('click', () => {
            document.getElementById('menu1-content-write').classList.add('hidden');
            document.getElementById('menu1-content').classList.remove('hidden');
        });

        // 검색 폼 제출 이벤트
        document.getElementById('search-form1').addEventListener('submit', function(event) {
            event.preventDefault();
            const keyword = document.getElementById('search-input1').value;
            fetchSearchResults(keyword);
        });

        // 검색 결과를 가져와서 화면에 표시하는 함수
        async function fetchSearchResults(keyword) {
            try {
                const response = await fetch('${pageContext.request.contextPath}/home/joinSearch?keyword=' + encodeURIComponent(keyword));
                const resultHtml = await response.text();
                document.querySelector('.grid').innerHTML = resultHtml;
            } catch (error) {
                console.error('Error fetching search results:', error);
            }
        }

        // 이건 어때? 메뉴 닫기 버튼
        document.getElementById('close-button2').addEventListener('click', () => {
            document.getElementById('menu2-content').classList.add('hidden');
        });

        // 장소 검색 기능
        function searchPlaces() {
            var query = document.getElementById('kakao-search').value;
            if (!query) {
                document.getElementById('search-results').innerHTML = '';
                return;
            }

            var places = new kakao.maps.services.Places();
            places.keywordSearch(query, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    document.getElementById('search-results').innerHTML = '';
                    result.forEach(function(place) {
                        var listItem = document.createElement('li');
                        listItem.textContent = place.place_name;
                        listItem.dataset.place = JSON.stringify(place);
                        listItem.addEventListener('click', function() {
                            var selectedPlace = JSON.parse(this.dataset.place);
                            selectedPlaces.push({
                                place_name: selectedPlace.place_name,
                                place_lat: selectedPlace.y,
                                place_lng: selectedPlace.x
                            });
                            updateSelectedPlaces();
                            document.getElementById('search-results').innerHTML = '';
                            document.getElementById('kakao-search').value = '';
                        });
                        document.getElementById('search-results').appendChild(listItem);
                    });
                } else {
                    document.getElementById('search-results').innerHTML = '';
                }
            });
        }

        function updateSelectedPlaces() {
            var selectedPlacesList = document.getElementById('selected-places-list');
            selectedPlacesList.innerHTML = '';
            selectedPlaces.forEach(function(place) {
                var listItem = document.createElement('li');
                listItem.textContent = place.place_name;
                selectedPlacesList.appendChild(listItem);
            });
            document.getElementById('selected-places').value = JSON.stringify(selectedPlaces);
        }
        document.getElementById('kakao-search-button').addEventListener('click', function() {
            searchPlaces();
        });

        document.getElementById('kakao-search').addEventListener('keypress', function(e) {
            if (e.which === 13) {
                searchPlaces();
            }
        });

        // 세부 사항 닫기 버튼
        document.getElementById('detail-close-button').addEventListener('click', () => {
            document.getElementById('menu1-content-detail').classList.add('hidden');
            document.getElementById('menu1-content').classList.remove('hidden');
        });
        document.getElementById('detail-close-button4').addEventListener('click', () => {
            document.getElementById('menu4-content-detail').classList.add('hidden');
            document.getElementById('menu4-content').classList.remove('hidden');
        });
    });
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

<script>

    //FAQ 박스를 초기화하는 함수입니다.
    function resetFaqBox() {
        // 모든 .answer-row 요소를 선택합니다.
        var answerRows = document.querySelectorAll('.answer-row');
        // 각 답변 행을 숨깁니다.
        answerRows.forEach(function(ar) {
            ar.style.display = 'none';
        });
        console.log('FAQ box reset');
    }

    document.addEventListener('DOMContentLoaded', function() {
        let currentPage2 = 1;
        let contentId;

        // 페이지 로드 시 기본 지역(서울)의 시군구 데이터 불러오기
        getSigunguCodes(1);

        function ajaxTest(areaCode, themeCode, sigunguCode, searchValue = "", pageNo = 1) {
        	if (searchValue) {
                filterResults(searchValue);
                return;
            }
            let url = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=21&pageNo=" + pageNo + "&MobileOS=ETC&MobileApp=HAHA&_type=json&listYN=Y&arrange=A&areaCode=" + areaCode + "&sigunguCode=" + sigunguCode + "&contentTypeId=" + themeCode + "&serviceKey=FhVdLivdQhcnz0qp01tF9t87mWZunIvLMJI0tIfzg0CaMu296y0tKhHIw1Bim%2BDvQxtmkibO6WN4XMfZOlAMeQ%3D%3D";
            $.ajax({
                url: url,
                type: "get",
                dataType: "json",
                success: function(data) {
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
                            contentId = item.contentid;
                            getDetailInfo();
                        });
                        $("#resultTestApi").append(listItem);
                    });
                    currentPage2 = pageNo; // 현재 페이지 업데이트
                    setupPagination(currentPage2, Math.ceil(totalCount / 21));
                    
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
                },
                error: function(e) {
                    console.error("Error fetching data: ", e);
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
            document.getElementById('menu2-content').classList.add('hidden');
            let detailUrl = "https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=haha&_type=json&contentId="+contentId+"&defaultYN=Y&firstImageYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey=FhVdLivdQhcnz0qp01tF9t87mWZunIvLMJI0tIfzg0CaMu296y0tKhHIw1Bim%2BDvQxtmkibO6WN4XMfZOlAMeQ%3D%3D";
            $.ajax({
                url: detailUrl,
                type: "get",
                dataType: "json",
                success: function(data) {
                    var detail = data.response.body.items.item[0];
                    $("#detail-content2").empty();
                    var imageUrl = detail.firstimage ? detail.firstimage : '/resources/imgs/Noimg.png';
                    $("#detail-content2").append('<img src="' + imageUrl + '" class="detail-image" alt="Image">');
                    if (detail.title) {
                        $("#detail-content2").append('<h3 class="detail-title">' + detail.title + '</h3>');
                    }
                    if (detail.overview) {
                        $("#detail-content2").append('<p class="detail-overview">' + detail.overview + '</p>');
                    }
                    if (detail.addr1) {
                        $("#detail-content2").append('<p class="detail-addr1">' + detail.addr1 + '</p>');
                    }
                    if (detail.homepage) {
                        var homepageUrl = $(detail.homepage).attr('href');
                        $("#detail-content2").append('<p class="detail-link"><a href="' + homepageUrl + '" target="_blank">홈페이지 방문</a></p>');
                    }
                    var mapContainer = document.getElementById('map');
                    mapContainer.innerHTML = ""; // 기존 지도 초기화
                    var mapOption = {
                        center: new kakao.maps.LatLng(detail.mapy, detail.mapx),
                        level: 5
                    };
                    var map = new kakao.maps.Map(mapContainer, mapOption);
                    var markerPosition = new kakao.maps.LatLng(detail.mapy, detail.mapx);
                    var marker = new kakao.maps.Marker({
                        position: markerPosition
                    });
                    marker.setMap(map);

                    var joinDetail = document.getElementById('detail-box2');
                    joinDetail.classList.remove('hidden');
                },
                error: function(e) {
                    console.error("Error fetching detail info: ", e);
                }
            });
        }

        function setupPagination(currentPage, totalPages) {
            const prevButton = document.getElementById('prev-page2');
            const nextButton = document.getElementById('next-page2');
            const pageNumbers = document.getElementById('page-numbers2');

            function updatePagination() {
                pageNumbers.innerHTML = "";
                const startPage = Math.floor((currentPage - 1) / 10) * 10 + 1;
                const endPage = Math.min(startPage + 9, totalPages);

                if (startPage > 1) {
                    const prevGroupButton = document.createElement('span');
                    prevGroupButton.textContent = '<<';
                    prevGroupButton.className = 'page-number';
                    prevGroupButton.addEventListener('click', function() {
                        currentPage = startPage - 10;
                        ajaxTest($('#area-select').val(), $('#theme-select').val(), $('#sigungu-select').val(), "", currentPage);
                        updatePagination();
                    });
                    pageNumbers.appendChild(prevGroupButton);
                }

                for (let i = startPage; i <= endPage; i++) {
                    const pageNumber = document.createElement('span');
                    pageNumber.textContent = i;
                    pageNumber.className = 'page-number';
                    if (i === currentPage) {
                        pageNumber.style.fontWeight = 'bold';
                    }
                    pageNumber.addEventListener('click', function() {
                        currentPage = i;
                        ajaxTest($('#area-select').val(), $('#theme-select').val(), $('#sigungu-select').val(), "", currentPage);
                        updatePagination();
                    });
                    pageNumbers.appendChild(pageNumber);
                }

                if (endPage < totalPages) {
                    const nextGroupButton = document.createElement('span');
                    nextGroupButton.textContent = '>>';
                    nextGroupButton.className = 'page-number';
                    nextGroupButton.addEventListener('click', function() {
                        currentPage = startPage + 10;
                        ajaxTest($('#area-select').val(), $('#theme-select').val(), $('#sigungu-select').val(), "", currentPage);
                        updatePagination();
                    });
                    pageNumbers.appendChild(nextGroupButton);
                }
            }

            prevButton.addEventListener(' click', function() {
                if (currentPage > 1) {
                    currentPage--;
                    ajaxTest($('#area-select').val(), $('#theme-select').val(), $('#sigungu-select').val(), "", currentPage);
                    updatePagination();
                }
            });

            nextButton.addEventListener('click', function() {
                if (currentPage < totalPages) {
                    currentPage++;
                    ajaxTest($('#area-select').val(), $('#theme-select').val(), $('#sigungu-select').val(), "", currentPage);
                    updatePagination();
                }
            });

            updatePagination();
        }

        $('#nav-button2').click(function() {
            hideAllOverlays();
            var messageBox2 = document.getElementById('menu2-content');
            messageBox2.style.display = 'block';
            setTimeout(() => {
                messageBox2.classList.add('show');
            }, 10);
        });

        $('#close-button2').click(function() {
            var messageBox2 = document.getElementById('menu2-content');
            messageBox2.classList.remove('show');
            setTimeout(() => {
                messageBox2.style.display = 'none';
                hideOverlaysById(['detail-box2']);
            }, 500);
        });

        $('#detail-close-button2').click(function() {
            document.getElementById('menu2-content').classList.remove('hidden');
            document.getElementById('detail-box2').classList.add('hidden');
        });

        $('#area-select').change(function() {
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
    });
    document.querySelectorAll('.menu-button').forEach(button => {
        button.addEventListener('click', function() {
            // 모든 버튼에서 active 클래스 제거
            document.querySelectorAll('.menu-button').forEach(btn => btn.classList.remove('active'));

            // 클릭한 버튼에 active 클래스 추가
            this.classList.add('active');

            // 모든 콘텐츠 숨기기
            document.querySelectorAll('.flex-1 > div').forEach(div => div.classList.add('hidden'));

            // 선택한 콘텐츠 표시
            const targetId = this.getAttribute('data-target');
            document.getElementById(targetId).classList.remove('hidden');
        });
    });

    // FAQ 이벤트 설정
    document.addEventListener('DOMContentLoaded', function() {
        // 모든 .question-row 요소를 선택합니다.
        var questionRows = document.querySelectorAll('.question-row');

        // 각 질문 행에 클릭 이벤트 리스너를 추가합니다.
        questionRows.forEach(function(row) {
            row.addEventListener('click', function() {
                // 클릭된 행에서 data-faq-id 속성 값을 가져옵니다.
                var faqId = this.getAttribute('data-faq-id');
                // 해당 FAQ ID와 연결된 답변 행을 선택합니다.
                var answerRow = document.getElementById('answer-' + faqId);

                // 만약 답변 행이 이미 보이는 상태라면 숨깁니다.
                if (answerRow.style.display === 'table-row') {
                    console.log("숨겨");
                    answerRow.style.display = 'none';

                    console.log('Answer hidden for FAQ ID:', faqId);
                } else {
                    // AJAX 요청을 사용하여 서버에서 답변을 가져옵니다.
                    var xhr = new XMLHttpRequest();
                    console.log("성공");
                    xhr.open('GET', '/home/get-faq-answer?id=' + faqId, true);
                    console.log("성공");
                    xhr.onreadystatechange = function() {
                        // 서버 응답이 완료되고 성공적일 때
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            console.log("성공");
                            // JSON 형식으로 응답을 파싱합니다.
                            var response = JSON.parse(xhr.responseText);
                            console.log("성공");
                            // 해당 답변 행의 td 요소에 응답 내용을 설정합니다.
                            answerRow.querySelector('td').innerText = response.answer;

                            // 답변 행을 보이도록 설정합니다.
                            answerRow.style.display = 'table-row';

                            console.log('Answer shown for FAQ ID:', faqId);
                        }
                    };
                    xhr.send(); // 요청을 보냅니다.
                }
            });
        });



        // FAQ 닫기 버튼 클릭 시 FAQ 박스를 초기화합니다.
        document.getElementById('faq-close-button').addEventListener('click', function() {
            resetFaqBox();
            document.getElementById('faq-box').style.display = 'none';
            document.getElementById('faq-box').classList.remove('show');
        });

        <%--
        // 다른 게시판 버튼 클릭 시 FAQ 박스를 초기화합니다.
        var navButtons = document.querySelectorAll('.nav-button');
        navButtons.forEach(function(button) {
            if (button.id !== 'faq-button') { // FAQ 버튼을 제외하고
                button.addEventListener('click', function() {
                    resetFaqBox();
                    document.getElementById('faq-box').style.display = 'none';
                    document.getElementById('faq-box').classList.remove('show');
                });
            }
        });
        --%>
    });
</script>

<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        // 정렬 기능 구현
        document.getElementById('sort-select').addEventListener('change', function() {
            const sortValue = this.value;
            sortPosts(sortValue);
        });

        function sortPosts(sortValue) {
            const postsContainer = document.querySelector('#travel-plan-list');
            const posts = Array.from(postsContainer.children);
            const today = new Date();

            posts.forEach(post => {
                const startDate = new Date(post.querySelector('.start-date').textContent.split('~')[0].trim());
                if (sortValue === 'closest' && startDate < today) {
                    post.style.display = 'none';
                } else {
                    post.style.display = '';
                }
            });

            posts.sort((a, b) => {
                const dateA = new Date(a.querySelector('.start-date').textContent.split('~')[0].trim());
                const dateB = new Date(b.querySelector('.start-date').textContent.split('~')[0].trim());

                if (sortValue === 'latest') {
                    return dateB - dateA;
                } else if (sortValue === 'oldest') {
                    return dateA - dateB;
                } else if (sortValue === 'closest') {
                    return dateA - dateB;
                }
            });

            posts.forEach(post => {
                const startDate = new Date(post.querySelector('.start-date').textContent.split('~')[0].trim());
                if (sortValue === 'closest' && startDate >= today) {
                    postsContainer.appendChild(post);
                } else if (sortValue !== 'closest') {
                    postsContainer.appendChild(post);
                }
            });
        }

        // 초기 정렬
        sortPosts(document.getElementById('sort-select').value);
    });
</script>

<script type="text/javascript">
    function loadQaPage(pageNum) {
        document.getElementById('menu4-content-detail').classList.add('hidden');
        const keyword = document.querySelector('input[id="qaSearch"]').value.trim();
        console.log("Keyword: " + keyword);
        console.log("Page Number: " + pageNum);

        $.ajax({
            url: '/home/QaSearchAjax',
            method: 'GET',
            data: { keyword: keyword, pageNum: pageNum },
            dataType: 'json',
            success: function(response) {
                console.log("Response: ", response);

                const qaList = response.qaList;
                const userList = response.userList;
                const totalPages = response.totalPages;
                const currentPage = response.currentPage;

                let qaListHtml = '';
                qaList.forEach(qa => {
                    console.log(qa);
                    console.log(qa.qa_id)
                    if (qa.user_id == user.user_id) {
	                    const qaHtml = '<tr>' +
	                        '<td class="p-2">' + qa.qa_id + '</td>' +
	                        '<td class="p-2">' +
	                        '<a href="javascript:void(0);" onclick="QaDetail(\'' + qa.title + '\', \'' + qa.question + '\', \'' + user.username + '\', \'' + qa.created_at + '\', \'' + (qa.answer ? qa.answer : '') + '\')">' +
	                        (qa.title.length >= 5 ? qa.title.substring(0, 5) + '...' : qa.title) +
	                        '</a>' +
	                        '</td>' +
	                        '<td class="p-2">' + qa.username + '</td>' +
	                        '<td class="p-2">' + qa.created_at + '</td>' +
	                        '<td class="p-2">' + (qa.answer ? '답변완료' : '') + '</td>' +
	                        '</tr>';
	                    qaListHtml += qaHtml;
                    }
                });

                const qaListElement = $('#qa-list');
                qaListElement.html(qaListHtml);  // HTML 업데이트

                let paginationHtml = '';
                const pageGroup = Math.ceil(currentPage / 10);
                const last = pageGroup * 10;
                const first = last - 9;

                if (currentPage > 1) {
                    paginationHtml += '<button onclick="loadQaPage(' + (currentPage - 1) + ')" class="p-2 bg-gray-300 rounded">이전</button>';
                }

                for (let i = first; i <= Math.min(last, totalPages); i++) {
                    paginationHtml += '<button onclick="loadQaPage(' + i + ')" class="p-2 bg-gray-300 rounded' + (i == currentPage ? ' active' : '') + '">' + i + '</button>';
                }

                if (currentPage < totalPages) {
                    paginationHtml += '<button onclick="loadQaPage(' + (currentPage + 1) + ')" class="p-2 bg-gray-300 rounded">다음</button>';
                    paginationHtml += '<button onclick="loadQaPage(' + totalPages + ')" class="p-2 bg-gray-300 rounded">끝</button>';
                }

                $('#qa-pagination').html(paginationHtml);  // 페이지네이션 업데이트
            },
            error: function(xhr, status, error) {
                console.error("Error fetching data: ", error);
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        // 페이지가 로드될 때 첫 번째 페이지를 로드
        loadQaPage(1);

        // 검색 폼 제출 이벤트
        document.querySelector('form[action="/home/QaSearch"]').addEventListener('submit', function(event) {
            event.preventDefault();
            loadQaPage(1);
        });

        // Q/A 메뉴 버튼 클릭 시 첫 페이지 로드
        document.querySelector('.menu-button[data-target="menu4-content"]').addEventListener('click', function() {
            showQA();
        });

        // Q/A 글쓰기 버튼 클릭 시 폼 보이기
        document.getElementById('qa-write-button').addEventListener('click', () => {
            document.getElementById('qa-content').classList.add('hidden');
            document.getElementById('qa-content-write').classList.remove('hidden');
        });

        // Q/A 취소 버튼 클릭 시 폼 숨기기
        document.getElementById('qa-cancel-btn').addEventListener('click', () => {
            document.getElementById('qa-content-write').classList.add('hidden');
            document.getElementById('qa-content').classList.remove('hidden');
        });
    });


    function showQA() {
        const qaContent = document.getElementById('qa-content');
        const faqContent = document.getElementById('faq-content');

        if (qaContent) {
            qaContent.classList.remove('hidden');
            loadQaPage(1); // Q/A 게시판을 표시할 때 첫 페이지 로드
        } else {
            console.error("qa-content element not found");
        }

        if (faqContent) {
            faqContent.classList.add('hidden');
        } else {
            console.error("faq-content element not found");
        }
    }


    function showFAQ() {
        document.getElementById('menu4-content-detail').classList.add('hidden');
        const qaContent = document.getElementById('qa-content');
        const faqContent = document.getElementById('faq-content');
        if (qaContent) {
            qaContent.classList.add('hidden');
        } else {
            console.error("qa-content element not found");
        }
        if (faqContent) {
            faqContent.classList.remove('hidden');
        } else {
            console.error("faq-content element not found");
        }

        resetFaqBox();
    }


    document.getElementById('logout').addEventListener('click', function() {
        window.location.href = '/logout';
    });

</script>

<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        let stompClient = null;
        let currentPlanId = null;

        function connect(planId) {
            if (stompClient && stompClient.connected) {
                stompClient.deactivate(); // 기존 클라이언트 비활성화
            }

            stompClient = new StompJs.Client({
                brokerURL: 'ws://localhost:8080/chat',
                reconnectDelay: 5000,
                heartbeatIncoming: 4000,
                heartbeatOutgoing: 4000,
                webSocketFactory: () => new SockJS('/chat')
            });

            stompClient.onConnect = function (frame) {
                console.log('Connected: ' + frame); // 연결 확인 로그

                currentPlanId = planId;
                loadMessages(currentPlanId);
                // 공개 토픽에 구독
                stompClient.subscribe('/topic/public', function (messageOutput) {
                    console.log('Received message frame:', messageOutput); // 수신된 메시지 프레임 로그

                    try {
                        const message = JSON.parse(messageOutput.body);
                        // 메시지가 현재 플랜에 속하는지 확인
                        if (Number(message.planId) === Number(currentPlanId)) showMessage(message); // 메시지를 화면에 표시
                    } catch (e) {
                        console.error('Error parsing message:', e);
                    }
                });

                console.log('Subscribed to /topic/public'); // 구독 경로 로그
            };

            stompClient.onStompError = function (frame) {
                console.error('STOMP error: ' + frame.headers['message']);
                console.error('Details: ' + frame.body);
            };

            stompClient.activate();
        }


        function sendMessage() {
            const messageInput = document.getElementById('message-input');
            if (stompClient && currentPlanId) {
                const message = {
                    'content': messageInput.value,
                    'userId': currentUserId, // 현재 사용자의 ID를 할당
                    'planId': currentPlanId
                };

                console.log('Sending message:', message);

                stompClient.publish({
                    destination: '/app/chat.sendMessage',
                    body: JSON.stringify(message),
                });

                messageInput.value = '';
            }
        }

        function showMessage(message) {
            // 메시지를 표시할 div 요소 생성
            const messageElement = document.createElement('div');

            // message.sender가 제대로 출력되는지 확인하기 위한 로그
            console.log('Rendering message from:', message.userId);

            // 메시지 스타일링
            messageElement.classList.add('mb-2', 'p-2', 'rounded-lg', 'shadow-md', 'max-w-md');

            if (message.userId === currentUserId) {
                // 현재 사용자가 보낸 메시지 스타일
                messageElement.classList.add('ml-auto', 'bg-blue-100');
                messageElement.innerHTML = '<span class="text-sm text-gray-600">나 :</span><span class="text-gray-800">' + message.content + '</span>';
            } else {
                // 다른 사용자가 보낸 메시지 스타일
                messageElement.classList.add('mr-auto', 'bg-gray-100');
                messageElement.innerHTML = '<span class="text-sm text-gray-600">' + message.userId + ':</span><span class="text-gray-800">' + message.content + '</span>';
            }

            // 메시지를 목록에 추가
            const messageList = document.getElementById('message-list');
            if (messageList) {
                messageList.appendChild(messageElement);
            } else {
                console.error('Message list element not found');
            }

            // 새 메시지 추가 시 스크롤을 아래로 이동
            messageList.scrollTop = messageList.scrollHeight;
        }

        function loadMessages(planId) {
            fetch('/api/messages/plan/' + planId)
                .then(response => response.json())
                .then(messages => {
                    const messageList = document.getElementById('message-list');
                    messageList.innerHTML = ''; // Clear existing messages

                    messages.forEach(message => {
                        // Create a new message element
                        const messageElement = document.createElement('div');

                        // Style the message element
                        messageElement.classList.add('mb-2', 'p-2', 'rounded-lg', 'shadow-md', 'max-w-md');

                        if (message.userId === currentUserId) {
                            // Style for messages sent by the current user
                            messageElement.classList.add('ml-auto', 'bg-blue-100');
                            messageElement.innerHTML = '<span class="text-sm text-gray-600">나 :</span><span class="text-gray-800">' + message.content + '</span>';
                        } else {
                            // Style for messages received from others
                            messageElement.classList.add('mr-auto', 'bg-gray-100');
                            messageElement.innerHTML = '<span class="text-sm text-gray-600">' + message.userId + ':</span><span class="text-gray-800">' + message.content + '</span>';
                        }

                        // Add the message element to the message list
                        messageList.appendChild(messageElement);
                    });

                    // Scroll to the bottom of the message list
                    messageList.scrollTop = messageList.scrollHeight;
                })
                .catch(error => console.error('Error loading messages:', error));
        }

        document.getElementById('send-button').addEventListener('click', function () {
            sendMessage();
        });

        window.openChat = function (planId) {
            document.querySelectorAll('.flex-1 > div').forEach(div => div.classList.add('hidden'));
            document.getElementById('chat-container').classList.remove('hidden');
            connect(planId);
        };

        document.querySelectorAll('nav button').forEach(button => {
            button.addEventListener('click', () => {
                document.querySelectorAll('.flex-1 > div').forEach(div => div.classList.add('hidden'));
                const targetId = button.getAttribute('data-target');
                document.getElementById(targetId).classList.remove('hidden');
                if (targetId == 'menu4-content') {
                    resetFaqBox();
                }
            });
        });
    });
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const participationButton = document.getElementById('participation-request-button');
        if (participationButton) {
            participationButton.addEventListener('click', function() {
                console.log("Fetching participation requests...");
                fetch('/api/companions/requests?userId=' + currentUserId)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Failed to fetch requests');
                        }
                        return response.json();
                    })
                    .then(requests => {
                        console.log('Requests received:', requests);
                        const requestList = document.getElementById('request-list');
                        requestList.innerHTML = ''; // Clear the existing list

                        requests.forEach(request => {
                            console.log('Processing request:', request);
                            const listItem = document.createElement('li');
                            listItem.classList.add('flex', 'justify-between', 'items-center', 'mb-2');

                            listItem.innerHTML =
                                '<span>' + request.username + '</span>' +
                                '<button class="approve-button p-1 bg-green-500 text-white rounded hover:bg-green-600 transition duration-300" data-companion-id="' + request.companionId + '">' +
                                '승인하기' +
                                '</button>';

                            console.log('Created list item:', listItem.outerHTML);
                            requestList.appendChild(listItem);
                        });

                        // Open the popup
                        document.getElementById('participation-request-popup').classList.remove('hidden');
                    })
                    .catch(error => console.error('Error fetching requests:', error));
            });
        } else {
            console.error('Participation request button not found.');
        }

        // Close popup button
        const popupCloseButton = document.getElementById('popup-close-button');
        if (popupCloseButton) {
            popupCloseButton.addEventListener('click', function() {
                document.getElementById('participation-request-popup').classList.add('hidden');
            });
        }

        const requestList = document.getElementById('request-list');
        if (requestList) {
            requestList.addEventListener('click', function(event) {
                if (event.target.classList.contains('approve-button')) {
                    const companionId = event.target.getAttribute('data-companion-id');
                    console.log("Approving companion ID:", companionId);

                    if (!companionId) {
                        console.error('Companion ID is undefined.');
                        return;
                    }

                    fetch('/api/companions/approve', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ companionId: companionId })
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Failed to approve request');
                            }
                            return response.json();
                        })
                        .then(result => {
                            console.log('Approval result:', result);
                            if (result.success) {
                                alert('승인 완료');
                                // Remove approved request from the list
                                event.target.parentElement.remove();
                            } else {
                                alert('승인 실패');
                            }
                        })
                        .catch(error => console.error('Error approving request:', error));
                }
            });
        } else {
            console.error('Request list element not found.');
        }
    });
</script>



</body>
</html>