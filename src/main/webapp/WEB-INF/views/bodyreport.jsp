<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <title>健身報表</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/asset4/css/styles.css">
    <style>
    input{
    border: none;
    pointer-events: none;
    }
   select{
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
                <img src="<%= request.getContextPath() %>/asset4/image/nav_home.png" style="height: 50px; width: 50px;"><a href="<%= request.getContextPath() %>/dashboard/dashboard.html">首頁</a>
            </div>
            <div class="menu-item">
                <img src="<%= request.getContextPath() %>/asset4/image/nav_profile.png" style="height: 50px; width: 50px;"><a href="<%= request.getContextPath() %>/dashboard-member/index.html">個人檔案</a>
            </div>
            <div class="menu-item">
                <img src="<%= request.getContextPath() %>/asset4/image/nav_mushrooms.png" style="height: 50px; width: 50px;"><a href="<%= request.getContextPath() %>/dashboard-elf/elves.html">健康精靈</a>
            </div>
            <div class="menu-item">
                <img src="<%= request.getContextPath() %>/asset4/image/nav_calendar.png" style="height: 50px; width: 50px;"><a href="<%= request.getContextPath() %>/dashboard-myplan/index.html">我的計畫</a>
            </div>
            <div class="menu-item">
                <img src="<%= request.getContextPath() %>/asset4/image/nav_buy.png" style="height: 50px; width: 50px;"><a href="<%= request.getContextPath() %>/shop-buyer/shop-index.html">健身好物</a>
            </div>
        </div>
    </div>
    <div class="main-content">
        <div class="rp-container">
        	<div class="form-grid">       	
            <div class="section">
                <h2>個人基本資料</h2>
                <p>性別: <input id="sex" value=""></p>
                <p>身高: <input id="height" value="">  cm</p>
                <p>體重: <input id="weight" value="">  kg</p>
                <p>年齡: <input id="age" value=""> 歲</p>
                <p>運動等級: <select name="habit" id="habit">
                            <option selected="true" disabled>==下列請選擇==</option>
                            <option value="1">久坐</option>
                            <option value="2">輕度活動</option>
                            <option value="3">中度活動</option>
                            <option value="4">高度活動</option>
                            <option value="5">超高度活動</option>
                        </select></p>
            </div>
            <div class="section">
                <h2>數據</h2>
                <p>BMI值: <input id="bmi" value=""></p>
                <p>BMR值: <input id="bmr" value=""> kcal/day</p>
                <p>TDEE值: <input id="tdee" value=""> kcal/day</p>
            </div>
            </div>
            <div class="section">
                <h2>體重變化折線圖</h2>
                <div class="chart-container">
                    <canvas id="weightChart"></canvas>
                </div>
            </div>
            <div class="section">
                <h2>備註</h2>
                <textarea placeholder="在此輸入備註..."></textarea>
            </div>
        </div>
    </div>

    <span class="sidebar">
       <a href="${pageContext.request.contextPath}/views/index" class="tooltip-btn" data-tooltip="個人資訊"><img src="${pageContext.request.contextPath}/asset4/image/user-avatar.png" style="height: 50px; width: 50px;"></a>
        <a href="${pageContext.request.contextPath}/views/goal" class="tooltip-btn" data-tooltip="健身目標"><img src="${pageContext.request.contextPath}/asset4/image/user-editing.jpg" style="height: 50px; width: 50px;"></a>
        <a href="${pageContext.request.contextPath}/views/bodyreport" class="tooltip-btn" data-tooltip="個人健康報表"><img src="${pageContext.request.contextPath}/asset4/image/user-target.jpg" style="height: 50px; width: 50px;"></a>
        <a href="calendarrecord.html" class="tooltip-btn" data-tooltip="打卡紀錄"><img src="<%= request.getContextPath() %>/asset4/image/user-test(3).jpg" style="height: 50px; width: 50px;"></a>
    </span>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="<%= request.getContextPath() %>/asset4/js/script.js"></script>
     <script>
     document.addEventListener("DOMContentLoaded", function() {
    	    const loginEmail = sessionStorage.getItem("logInEmail");
    	    console.log("Login email from session storage:", loginEmail);

    	    if (loginEmail) {
    	    	//建立兩個伺服器資料
    	        const xhr = new XMLHttpRequest();
    	        const xhr1 = new XMLHttpRequest();

    	        xhr.open("GET", "http://localhost:8080/user/" + loginEmail, true);
    	        xhr1.open("GET", "http://localhost:8080/user/weight-chart/" + loginEmail, true);

    	        xhr1.onreadystatechange = function() {
    	            
    	            if (xhr1.readyState === 4) {
    	                if (xhr1.status === 200) {
    	                	const response = JSON.parse(xhr1.responseText);
                            console.log("User1 data fetched:", response);

                            const user = response.user;
                            const weights = response.weights;
    	                    // 拿當前時間的前六個月
    	                    const currentDate = new Date();
    	                    const monthLabels = [];
    	                    for (let i = 5; i >= 0; i--) {
    	                        const date = new Date(currentDate.getFullYear(), currentDate.getMonth() - i, 1);
    	                        monthLabels.push(date.toLocaleString('default', { month: 'long' }));
    	                    }

    	                    // 從 fitnessGoals 中提取 weights 
    	                    // 設 user.fitnessGoals 是包含體重的數據
    	                    const fitnessGoals = user.fitnessGoals; 
    	                    // 初始化 currentWeights 数據為 NaN
    	                    const currentWeights = new Array(6).fill(NaN); 
    	                    //存月平均體重
    	                    const monthData = {};
    	                    //設目標體重為  target_weight
    	                    const targetWeight = user.target_weight; 

    	                    fitnessGoals.forEach(fitnessGoal => {
    	                        const updateAt = new Date(fitnessGoal.update_at);
    	                        const monthDiff = currentDate.getMonth() - updateAt.getMonth() + 
    	                                          (12 * (currentDate.getFullYear() - updateAt.getFullYear()));
    	                        if (monthDiff >= 0 && monthDiff < 6) {
                                    const monthIndex = 5 - monthDiff;
                                    if (!monthData[monthIndex]) {
                                        monthData[monthIndex] = [];
                                    }
                                    monthData[monthIndex].push(fitnessGoal.current_weight);
                                }
    	                    });
    	                 	// 計算每個月的平均體重
                            for (let i = 0; i < 6; i++) {
                                if (monthData[i] && monthData[i].length > 0) {
                                    const totalWeight = monthData[i].reduce((sum, weight) => sum + weight, 0);
                                    const avgWeight = totalWeight / monthData[i].length;
                                    currentWeights[i] = avgWeight;
                                } else {
                                    currentWeights[i] = 0; // 如果該月沒有數據，預設為0
                                }
                            }
    	                    const goalWeights = new Array(6).fill(targetWeight); 

    	                    // 圖表start
    	                    var ctx = document.getElementById('weightChart').getContext('2d');
    	                    var weightChart = new Chart(ctx, {
    	                        type: 'line',
    	                        data: {
    	                            labels: monthLabels,
    	                            datasets: [{
    	                                label: '現在體重 (kg)',
    	                                data: currentWeights,
    	                                borderColor: 'rgb(75, 192, 192)',
    	                                fill: false
    	                            }, {
    	                                label: '目標體重 (kg)',
    	                                data: goalWeights,
    	                                borderColor: 'rgb(255, 99, 132)',
    	                                fill: false
    	                            }]
    	                        },
    	                        options: {
    	                            responsive: true,
    	                            scales: {
    	                                x: {
    	                                    display: true,
    	                                    title: {
    	                                        display: true,
    	                                        text: '月份'
    	                                    }
    	                                },
    	                                y: {
    	                                    display: true,
    	                                    title: {
    	                                        display: true,
    	                                        text: '體重 (kg)'
    	                                    }
    	                                }
    	                            }
    	                        }
    	                    });
    	                }
    	            }
    	        };
    	     // 圖表end
    	     // 資料導入 運算BMI BMR TDEE  start
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
    	                        height: 'height_cm',
    	                        weight:'current_weight',
    	                        goal: 'purpose',
    	                        habit:'activity_level',
    	                        age:'age'
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

    	                   
    	                    
    	                    // BMI計算
    	                    if (height.value && weight.value) {
    	                        const heightInMeters = height.value / 100;
    	                        const bmi = weight.value / Math.pow(heightInMeters, 2);
    	                       
    	                       document.getElementById("bmi").value = bmi.toFixed(2); // 保留兩位小數
    	                    } else {
    	                        console.log("Height, weight, or BMI element not found.");
    	                    }
    	                    // BMR計算
    	                    if(sex.value == "male"){
    	                        const bmr = 13.7 * weight.value + 5 * height.value - 6.8 * age.value + 66;
    	                        document.getElementById("bmr").value = bmr.toFixed(2);
    	                    } else if(sex.value == "female"){
    	                        const bmr = 9.6 * weight.value + 1.8 * height.value - 4.7 * age.value + 655;
    	                        document.getElementById("bmr").value = bmr.toFixed(2);
    	                    }
    	                    // TDEE計算
    	                    switch (habit.value) {
    	                        case "1":
    	                            const tdee1 = 1.2 * document.getElementById("bmr").value;
    	                            document.getElementById("tdee").value = tdee1.toFixed(0);
    	                            break;
    	                        case "2":
    	                            const tdee2 = 1.375 * document.getElementById("bmr").value;
    	                            document.getElementById("tdee").value = tdee2.toFixed(0);
    	                            break;
    	                        case "3":
    	                            const tdee3 = 1.55 * document.getElementById("bmr").value;
    	                            document.getElementById("tdee").value = tdee3.toFixed(0);
    	                            break;
    	                        case "4":
    	                            const tdee4 = 1.725 * document.getElementById("bmr").value;
    	                            document.getElementById("tdee").value = tdee4.toFixed(0);
    	                            break;
    	                        case "5":
    	                            const tdee5 = 1.9 * document.getElementById("bmr").value;
    	                            document.getElementById("tdee").value = tdee5.toFixed(0);
    	                            break;
    	                    }
    	                } else {
    	                    console.log("Failed to fetch user data. Status code:", xhr.status);
    	                    console.log("無法獲取用戶資料");
    	                }
    	            }
    	        };

    	        xhr.send();
    	        xhr1.send(); 
    	    } else {
    	        console.log("No login email found in session storage.");
    	    }
    	});
     // 資料導入 運算BMI BMR TDEE  end
        </script>
</body>

</html>
