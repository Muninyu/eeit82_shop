<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/asset4/css/logNquesStyles.css">
    <title>小測驗1</title>
    
</head>
<body>
    <img src="/asset4/image/B&B_text.png" class="logo"></img>
    <a href="/index" class="index">首頁</a>
    <div class="container">
        <h2>讓我們了解你</h2>
        <form id="surveyForm" action="" method="post" enctype="multipart/form-data" autocomplete="off" onsubmit="validateForm1(event)">
            <!-- 1.性別 -->
            <label class="form-label"  for="gender">性別</label>
            <input type="radio" name="gender" id="male" value="male" checked><label class="contact-label" for="male" style="display: inline;">男性</label>
            <input type="radio" name="gender" id="female" value="female" ><label class="contact-label" for="female" style="display: inline;">女性</label>
            <!-- 2.生日 -->
            <div class="form-label">
                <label class="contact-label" for="birth">生日</label>
                <input type="date" name="birth" id="birth">
            </div>
            <!-- 3.身高 -->
            <div class="form-label">
                <label class="contact-label" for="height">身高</label>
                <input type="text" name="height" id="height" placeholder="請輸入身高" required>
            </div>

            <button type="submit">下一題</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="/asset4/js/script.js">  </script>
    <script type="text/javascript">

    
    
    </script>
</body>
</html>