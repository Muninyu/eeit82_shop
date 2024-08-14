<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../asset4/css/logNquesStyles.css">
    <title>登入畫面</title>
</head>
<body class="log-sign-body">
    <a href="/index" class="logo">
		<h2 style="color: white;">B&B</h2>
	</a>
    <a href="/index" class="index">首頁</a>
    <div class="container-log">
        <h2>會員登入</h2>
        <form id="loginForm">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">密碼</label>
            <input type="password" id="password" name="password" required>

            <label class="forgetpwd"><a href="#" style=" text-decoration: none;">忘記密碼</a></label>
            <label class="signin"><a href="${pageContext.request.contextPath}/views/question1" style=" text-decoration: none;">還沒有帳戶? 前往註冊</a></label>

            <button type="submit">登入</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
    document.getElementById('loginForm').addEventListener('submit', function(event){
    	event.preventDefault();
    	 const email = document.getElementById('email').value;
    	    const password = document.getElementById('password').value;

    	    if (email && password) {
    	        const requestData = {
    	            email: email,
    	            password: password
    	        };
    	        axios.post('http://localhost:8080/login', requestData)
                .then(function (res) {
                	console.log('Response:', res);
                    if (res.data.success) {
                        sessionStorage.setItem('logInEmail', email);
                        sessionStorage.setItem('loginId', res.data.loginId); 
                        window.location.href = '/shop';
                    } else {
                        alert(res.data.message);
                    }
                })
                .catch(function (error) {
                    console.error('There was an error!', error);
                    alert('登入失敗，請重試');
                });
        } else {
            alert('請填寫所有欄位');
        }
    })
    </script>
</body>
</html>
