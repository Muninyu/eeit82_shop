<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beauty & Beast</title>
    <!-- 引入 LineIcons 字體庫 -->
    <link href="https://cdn.lineicons.com/4.0/lineicons.css" rel="stylesheet" />
    <!-- 引入 Bootstrap 5 CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- 引入自定義 CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>
    <div class="wrapper">
        <!-- 側邊欄開始 -->
        <aside id="sidebar">
            <div class="d-flex">
                <!-- 切換按鈕 -->
                <button class="toggle-btn" type="button">
                    <i class="fas fa-bars"></i>
                </button>
                <!-- 側邊欄標誌 -->
                <div class="sidebar-logo">
                    <a href="/dashboard">B&B</a>
                </div>
            </div>
            <!-- 側邊欄導航 -->
            <ul class="sidebar-nav">

                <li class="sidebar-item">
                    <a href="/dashboard" class="sidebar-link">
                        <img src="${pageContext.request.contextPath}/img/icon/nav_home.ico" class="icon-type">
                        <span>首頁</span>
                    </a>
                </li>

                <!-- 單個導航項目 -->
                <li class="sidebar-item">
                    <a href="${pageContext.request.contextPath}/views/index" class="sidebar-link ">
                        <img src="${pageContext.request.contextPath}/img/icon/feature04.ico" class="icon-type">
                        <span>會員中心</span>
                    </a>
                </li>
                <!-- 嵌套導航項目 -->
                <li class="sidebar-item">
                    <a href="#" class="sidebar-link">
                        <img src="${pageContext.request.contextPath}/img/icon/nav_mushrooms.ico" class="icon-type">
                        <span>健身精靈</span>
                    </a>
                </li>
                <!-- 具有下拉菜單的導航項目 -->
                <li class="sidebar-item">
                    <a href="/page/page3" class="sidebar-link collapsed has-dropdown" data-bs-toggle="collapse"
                        data-bs-target="#auth" aria-expanded="false" aria-controls="auth">
                        <img src="${pageContext.request.contextPath}/img/icon/feature03.ico" class="icon-type">
                        <span>我的計畫</span>
                    </a>
                    <ul id="auth" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item">
                            <a href="/api/caloriesPage" class="sidebar-link">運動計畫</a>
                        </li>
                        <li class="sidebar-item">
                            <a href="/eat/eatcalories" class="sidebar-link">飲食紀錄</a>
                        </li>
                    </ul>
                </li>

                <!-- 其他導航項目 -->
                <li class="sidebar-item">
                    <a href="/shop" class="sidebar-link">
                        <img src="${pageContext.request.contextPath}/img/icon/nav_buy.ico" class="icon-type">
                        <span>健身好物</span>
                    </a>
                </li>

            </ul>
            <!-- 側邊欄底部 -->
            <div class="sidebar-footer">
                <a href="/dashboard" class="sidebar-link">
                    <img src="${pageContext.request.contextPath}/img/icon/nav_logout.ico" class="icon-type">
                    <span>上一頁</span>
                </a>
            </div>
        </aside>
        <!-- 主內容區域 -->
        <div class="main p-3">
            <div class="main-content">
                <div class="header">
                    <h1>B&B</h1>
                </div>
                <div class="plan-section">
                    <h2>我的計畫</h2>
                    <div class="plans">
                        <div class="plan">
                            <h3><i class="fas fa-dumbbell"></i> 開啟計畫</h3>
                            <br>
                            <p>坐而言不如起而行，現在立馬開啟你的健身運動吧！</p>
                            <a href="/api/caloriesPage">立即出發</a>
                        </div>
                        <div class="plan">
                            <h3><i class="fas fa-utensils"></i> 飲食紀錄</h3>
                            <br>
                            
                            <p>除了運動，還要搭配飲食，保持良好的身形。天天有菜單更新，記得查看哦！</p>
                            <a href="/eat/eatcalories">立即出發</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="custom-box">
            <div class="header1">
				<h2>每日簽到</h2>
			</div>
            
            <div class="calendar">
                <div class="calendar-header">
                    <!-- 年 -->
                    <div class="year-picker">
                        <span class="year-change" id="prev-year">
                            <pre><</pre>
                        </span>
                        <span id="year">2024</span>
                        <span class="year-change" id="next-year">
                            <pre>></pre>
                        </span>
                    </div>

                    <!-- 月 -->
                    <span class="month-picker" id="month-picker">May</span>
                </div>
                <div class="calendar-body">
                    <!-- 星期 -->
                    <div class="calendar-week-day">
                        <div>日</div>
                        <div>一</div>
                        <div>二</div>
                        <div>三</div>
                        <div>四</div>
                        <div>五</div>
                        <div>六</div>
                    </div>

                    <!-- 日期 -->
                    <div class="calendar-days"></div>
                </div>

                <div class="month-list"></div>
            </div>
            <div class="btn1-container">
                <button class="btn1" id="btncheck" data-hover="&#128073;click me!">
                    <div style="color: white;">簽到</div>
                </button>
            </div>
           
        </div>
    </div>
    </div>
    <!-- 引入 Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    <!-- 引入自定義 JavaScript -->
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
    <script>
        // 从 sessionStorage 中获取 response
    document.addEventListener("DOMContentLoaded", function() {
    console.log(sessionStorage);
    	const responseString = sessionStorage.getItem("loginId");
        if (responseString) {
            // 解析 response 为 JavaScript 对象
            const responseObject = JSON.parse(responseString);
            console.log('Parsed response object:', responseObject);

            // 从 response 对象中抓取 user_id
            
            console.log('Extracted userId:', responseObject);
            if (responseObject) {
                // 檢查用戶今天是否已經簽到
                fetch(`/checkCheckinStatus?userId=`+ responseObject, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok ' + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.hasCheckedInToday) {
                        console.log('User has already checked in today.');
                        getCheckinLogsByUserId(responseObject);
                    } else {
                        console.log('User has not checked in today.');
                        // 发送 POST 请求到 /add
                        fetch('/add', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: new URLSearchParams({
                                'userId': responseObject,
                            })
                        })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok ' + response.statusText);
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Success:', data);
                            // 这里调用 getCheckinLogsByUserId 函数
                            getCheckinLogsByUserId(responseObject);
                        })
                        .catch((error) => {
                            console.error('Error:', error);
                        });
                    }
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
            } else {
                console.error('UserId is undefined or null');
            }
        } else {
            console.error('No response found in sessionStorage');
        }
    });


    function getCheckinLogsByUserId(responseObject) {
    	 console.log('Fetching checkin logs for userId:',responseObject);
    	 fetch(`/check/`+responseObject, {
    	        method: 'GET', // 使用 GET 方法
    	    })
    	    .then(response => {
    	        if (!response.ok) {
    	            throw new Error('Network response was not ok ' + response.statusText);
    	        }
    	        return response.json();
    	    })
    	    .then(data => {
    	        console.log('Checkin logs:', data);
    	        data.forEach(log => {
    	            const checkinDate = new Date(log.checkin_date);
    	            const year = checkinDate.getFullYear();
    	            const month = checkinDate.getMonth();
    	            const date = checkinDate.getDate();
    	            console.log('Fetching checkin logs for userId:', responseObject);
    	            // 如果是当前月份和年份，标记签到日期
    	            if (year === new Date().getFullYear() && month === new Date().getMonth()) {
    	                const firstDayOfMonth = new Date(year, month, 1).getDay();
    	                const calculatedIndex = Math.max(date + firstDayOfMonth, 1);
    	                const dayElement = document.querySelector(`.calendar-days div:nth-child(`+calculatedIndex+`)`);
    	                if (dayElement) {
    	                    dayElement.style.backgroundColor = "green"; // 标记已签到日期
    	                }
    	            }
    	        });
    	    })
    	    .catch(error => {
    	        console.error('There was a problem with the fetch operation:', error);
    	    });
    }
    function updateUser() {
    	
    	const responseObject = JSON.parse(responseString);
    	const userId = responseObject.user_id;
    	 const fitnessGoal={
    			 user_id: userId,
    			 current_weight : document.getElementById("currentWeight").value
    	 };
		 sendUserData(fitnessGoal);
    	
    	}

   function sendUserData(fitnessGoal) {
    	 fetch('/updateWeight', {
    	     method: 'POST',
    	     headers: {
    	         'Content-Type': 'application/json'
    	     },
    	     body: JSON.stringify(fitnessGoal)
    	 })
    	 .then(response => {
    		 console.log('Response:', response);
    		 if (!response.ok) {
    	     throw new Error('Network response was not ok ' + response.statusText);
    	 }
    		 })
             
             
    }
</script>
</body>

</html>
