<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../asset4/css/logNquesStyles.css">
    <title>註冊畫面</title>
    
</head>
<body class="log-sign-body">
    <img src="../asset4/image/B&B_text.png" class="logo"></img>
    <a href="#" class="index">首頁</a>
    <div class="container-log">
        <h2>會員註冊</h2>
        <form onsubmit="validateForm5(event)">
            <label for="username">用戶名稱</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">密碼</label>
            <input type="password" id="password" name="password" required>

            <label for="confirm-password">確認密碼</label>
            <input type="password" id="confirm-password" name="confirm-password" required>

            <button type="submit">註冊</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bcryptjs@2.4.3/dist/bcrypt.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="/asset4/js/script.js">  </script>
</body>
</html>
