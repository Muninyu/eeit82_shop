<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.DailyCalories" %>
<%
    ObjectMapper objectMapper = new ObjectMapper();
    String dailyCaloriesJson = (String) request.getAttribute("dailyCaloriesJson");
    Integer totalCalories = (Integer) request.getAttribute("totalCalories");
%>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- 引入自定義 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        #dietLog {
            height: 300px;
            max-height: 300px; /* 你可以根据需要调整高度 */
            overflow-y: auto; /* 启用垂直滚动条 */
            border: 1px solid #ccc; /* 可选：添加边框以更明显地区分列表区域 */
            padding: 10px; /* 可选：增加内边距 */
        }
        
    </style>
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
                    <a href="./index.html" class="sidebar-link collapsed has-dropdown" data-bs-toggle="collapse"
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
                <a href="/page/page3" class="sidebar-link">
                    <img src="${pageContext.request.contextPath}/img/icon/nav_logout.ico" class="icon-type">
                    <span>上一頁</span>
                </a>
            </div>
        </aside>
        <!-- 主內容區域 -->
        <div class="main p-3">
            <div class="main-content">
                <div class="header">
                    <h1>飲食紀錄</h1>
                </div>
                <div class="plan-section">
                    <h2>Today</h2>
                    <div class="plans">
                        <div class="plan" style="height: 160px; width: 100%;">
                            <h3><i class="fas fa-utensils"></i> 餐點選擇</h3>
                            <br>
                            <button class="btn" onclick="openForm('餐點')">填寫</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main-content">
                <div class="header">
                    <h1>卡路里紀錄表</h1>
                </div>
                <div class="plan-section " >
                    <canvas id="myChart"></canvas>
                </div>
                <div>
                   
                    <table>
                       
                        <tbody>
                            <c:forEach var="meal" items="${userMeals}">
                                <tr>
                                    <td>${meal.meal_name}</td>
                                    <td>${meal.meal_calories}</td>
                                    <td>${meal.meal_date}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeForm()">&times;</span>
                <h2 id="mealType">填寫搜尋</h2>
                <h1>食物搜尋</h1>
                <div class="form-row align-items-center">
                    <div class="col-auto">
                        <input type="text" id="searchInput" class="form-control mb-2" placeholder="輸入食物名稱">
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-primary mb-2" onclick="searchCalories()">搜尋</button>
                    </div>
                </div>
                <div id="results"></div>
                <button class="btn btn-primary mt-2" onclick="refreshPage()">提交</button>
            </div>
        </div>

        <div class="custom-box">
            <input type="date" id="logDate" /><br><br>
            <ul id="dietLog"></ul>
            <p>日期:<span id="displayDate"></span>&nbsp;<br>總卡路里: <span id="totalCalories">0.00</span> kcal</p>

            <div class="btn1-container">
                <!-- <button class="btn1" id="btncheck" data-hover="&#128073;click me!">
                    <div style="color: white;">簽到</div>
                </button> -->
            </div>
            <div style="text-align: center;">
                <h2>總共攝取<%= totalCalories != null ? totalCalories : 0 %>大卡</h2>
            </div>
        </div>
    </div>
    </div>
    <!-- 引入 Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        // 選單
        var modal = document.getElementById("myModal");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on the button, open the modal
        function openForm(mealType) {
            modal.style.display = "block";
            document.getElementById("mealType").innerText = mealType + "填寫表單";
        }

        // When the user clicks on <span> (x), close the modal
        function closeForm() {
            modal.style.display = "none";
        }

        const chartElement = document.getElementById('myChart');
        const dailyCalories = JSON.parse('<%= dailyCaloriesJson %>');

        const labels = dailyCalories.map(dc => dc.date);
        const data = dailyCalories.map(dc => dc.totalCalories);

        const chartData = {
            labels: labels,
            datasets: [{
                label: '卡路里',
                data: data,
            }]
        };

        new Chart(chartElement, {
            type: 'line',
            data: chartData,
        });
    </script>
     <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>

</html>
