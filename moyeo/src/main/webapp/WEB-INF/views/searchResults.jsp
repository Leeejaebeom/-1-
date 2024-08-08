<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="i" items="${travelPlanList}" begin="${page.firstPost}" end="${page.lastPost}">
  <div class="p-4 bg-white shadow rounded flex items-center justify-between" onclick="JoinDetail('${i.plan_id}', '${i.title}', '${i.description}', '${i.user_id}', '${i.start_date}', '${i.end_date}', '${i.created_at}')">
    <div>
      <h3 class="font-bold">${i.title}</h3>
      <p>
        <c:forEach var="j" items="${userList}">
          <c:if test="${i.user_id == j.user_id}">
            ${j.username}
          </c:if>
        </c:forEach>
      </p>
      <p>${i.start_date} ~ ${i.end_date}</p>
    </div>
    <div class="w-16 h-16 bg-gray-300"></div>
  </div>
</c:forEach>