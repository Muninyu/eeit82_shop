<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <title>健身目標</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset4/css/styles.css">
	<style>
        input {
            border: none;
            pointer-events: none;
        }

        select {
            border: none;
            pointer-events: none;
            -webkit-appearance: none;
        }
    </style>
</head>

<body>
    <div class="navbar">
        <div class="menu">
            <div class="menu-item hamburger-menu">
                <span class="menu-icon" style="font-size: 30px;">☰</span>
                <a href="#">B&B</a>
            </div>
            <div class="menu-item">
                <img src="${pageContext.request.contextPath}/asset4/image/nav_home.png" style="height: 50px; width: 50px;">
                <a href="${pageContext.request.contextPath}/dashboard/dashboard.jsp">首頁</a>
            </div>
            <div class="menu-item">
                <img src="${pageContext.request.contextPath}/asset4/image/nav_profile.png" style="height: 50px; width: 50px;">
                <a href="${pageContext.request.contextPath}/dashboard-member/index.jsp">個人檔案</a>
            </div>
            <div class="menu-item">
                <img src="${pageContext.request.contextPath}/asset4/image/nav_mushrooms.png" style="height: 50px; width: 50px;">
                <a href="${pageContext.request.contextPath}/dashboard-elf/elves.jsp">健康精靈</a>
            </div>
            <div class="menu-item">
                <img src="${pageContext.request.contextPath}/asset4/image/nav_calendar.png" style="height: 50px; width: 50px;">
                <a href="${pageContext.request.contextPath}/dashboard-myplan/index.jsp">我的計畫</a>
            </div>
            <div class="menu-item">
                <img src="${pageContext.request.contextPath}/asset4/image/nav_buy.png" style="height: 50px; width: 50px;">
                <a href="${pageContext.request.contextPath}/shop-buyer/shop-index.jsp">健身好物</a>
            </div>
        </div>
    </div>
    <div class="main-content">
        <div class="content goal-content">
            <div>
                <img src="${pageContext.request.contextPath}/asset4/image/831b1157b1e47e7f03b52c5c8a3cd2d5_t.jpeg" class="goal-img">
            </div>
            <div style="margin-top: 50px;">
                <form action="">
                    <!-- 1.目標 -->
                    <div class="form-group">
                        <label class="contact-label" for="goal">健身目標</label>
                        <select name="goal" id="goal">
                           
                            <option value="muscle">增加肌肉</option>
                            <option value="weight_loss">瘦身減重</option>
                            <option value="health">保持健康</option>
                        </select>
                    </div>
                    <br>
                    <br>
                    <!-- 2.習慣 -->
                    <div class="form-group">
                        <label class="contact-label" for="habit">每周訓練量</label>
                        <select name="habit" id="habit">
                            <option selected="true" disabled>==下列請選擇==</option>
                            <option value="1">久坐</option>
                            <option value="2">輕度活動</option>
                            <option value="3">中度活動</option>
                            <option value="4">高度活動</option>
                            <option value="5">超高度活動</option>
                        </select>
                    </div>
                    <br>
                    <br>
                    <!-- 3.體重 -->
                    <div class="form-group">
                        <label class="contact-label" for="weight">目標體重</label>
                        <input type="text" name="weight" id="weight" placeholder="請輸入體重" required>
                    </div>
                    <br>
                    <br>
                    <!-- 4.達成時間 -->
                    <div class="form-group">
                        <label class="contact-label" for="goal-time">達成時間</label>
                        <input type="date" name="goal-time" id="goal-time">
                    </div>
                    <br>
                    <br>
                    
                </form>
            </div>
        </div>
    </div>

    <span class="sidebar">
      <a href="${pageContext.request.contextPath}/views/index" class="tooltip-btn" data-tooltip="個人資訊"><img src="${pageContext.request.contextPath}/asset4/image/user-avatar.png" style="height: 50px; width: 50px;"></a>
        <a href="${pageContext.request.contextPath}/views/goal" class="tooltip-btn" data-tooltip="健身目標"><img src="${pageContext.request.contextPath}/asset4/image/user-editing.jpg" style="height: 50px; width: 50px;"></a>
        <a href="${pageContext.request.contextPath}/views/bodyreport" class="tooltip-btn" data-tooltip="個人健康報表"><img src="${pageContext.request.contextPath}/asset4/image/user-target.jpg" style="height: 50px; width: 50px;"></a>
        <a href="${pageContext.request.contextPath}/calendarrecord.jsp" class="tooltip-btn" data-tooltip="打卡紀錄">
            <img src="${pageContext.request.contextPath}/asset4/image/user-test(3).jpg" style="height: 50px; width: 50px;">
        </a>
    </span>
    <script src="${pageContext.request.contextPath}/asset4/js/indexjs.js"></script>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const loginEmail = sessionStorage.getItem("logInEmail");
        console.log("Login email from session storage:", loginEmail);

        if (loginEmail) {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "http://localhost:8080/user/" + loginEmail, true);
            console.log("XHR created:", xhr);

            xhr.onreadystatechange = function() {
                console.log("Ready state change:", xhr.readyState);

                if (xhr.readyState === 4) {
                    console.log("XHR response text:", xhr.responseText);
                    if (xhr.status === 200) {
                        const user = JSON.parse(xhr.responseText);
                        console.log("User data fetched:", user);

                        var fieldMapping = {
                            preview: 'face',
                            nickname: "nickname",
                            email: 'email',
                            sex: 'gender',
                            birth: 'birthday',
                            tel: 'phone',
                            height: 'height',
                            weight:'target_weight',
                            goal: 'purpose',
                            habit:'activity_level'
                        };

                        for (var field in fieldMapping) {
                            if (fieldMapping.hasOwnProperty(field)) {
                                const element = document.getElementById(field);
                                const value = user[fieldMapping[field]];
                                if (element) {
                                    if (field === 'preview' && value) {
                                        element.src = value;
                                    } else {
                                        element.value = value !== null && value !== undefined ? value : "";
                                    }
                                }
                            }
                        }

                        // 檢查 surveys 屬性是否存在
                        console.log("User surveys:", user.surveys);

                        if (user.surveys && user.surveys.length > 0) {
                            console.log("Surveys:", user.surveys);
                            const latestSurvey = user.surveys.reduce((prev, current) => {
                                return (new Date(prev.updateAt) > new Date(current.updateAt)) ? prev : current;
                            });
                            console.log("Latest Survey:", latestSurvey);

                            document.getElementById('weight').value = latestSurvey.currentWeight !== null && latestSurvey.currentWeight !== undefined ? latestSurvey.currentWeight : "";
                        } else {
                            console.log("No surveys found for the user.");
                        }
                    } else {
                        console.log("Failed to fetch user data. Status code:", xhr.status);
                        console.log("無法獲取用戶資料");
                    }
                }
            };

            xhr.send();
        } else {
            console.log("No login email found in session storage.");
        }
    });
    </script>
</body>

</html>
