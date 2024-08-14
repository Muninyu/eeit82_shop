<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>胸部高級</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/sports.css">
</head>
<body>
    <div class="container">
        <h1>胸部高級</h1>
        <div id="exercise-container">
            <h2 id="exercise-name">頭高位俯卧撑</h2>
            <img id="exercise-gif" src="<%= request.getContextPath() %>/pushup.gif" alt="Exercise GIF" width="320" height="240">
            <p id="exercise-description">X16</p>
            <div id="timer">剩餘時間: <span id="time-left">30</span> 秒</div>
            <div id="calories">已消耗熱量: <span id="calories-burned">0</span> 大卡</div>
        </div>
        <button id="next-button">下一步</button>
        <button id="end-button">结束</button>
        <button id="exit-button">退出</button>
    </div>

    <script src="<%= request.getContextPath() %>/js/chest_l3.js"></script>
</body>
</html>
