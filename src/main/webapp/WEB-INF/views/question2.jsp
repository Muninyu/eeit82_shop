<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/asset4/css/logNquesStyles.css">
    <title>小測驗2</title>
</head>
<body>
    <img src="/asset4/image/B&B_text.png" class="logo"></img>
    <a href="/index" class="index">首頁</a>
    <div class="container">
        <h2>建立目標吧!</h2>
        <form id="surveyForm" action="" method="post" enctype="multipart/form-data" autocomplete="off" onsubmit="validateForm2(event)">
            <!-- 1.主要目標 -->
            <label class="form-label" for="main-goal">主要目標</label>
                        <select name="main-goal" id="main-goal">
                            <option selected="true" disabled>==請選擇==</option>
                            <option value="muscle">我要增加肌肉</option>
                            <option value="weight_loss">我要瘦身減重</option>
                            <option value="health">我要保持健康</option>
                        </select>
            <!-- 2.現在體重 -->
            <div class="form-label">
                <label class="contact-label" for="nowWeight">現在體重</label>
                <input type="text" name="nowWeight" id="nowWeight" placeholder="請輸入體重" required>
            </div>
            <!-- 3.目標體重 -->
            <div class="form-label">
                <label class="contact-label" for="goalWeight">目標體重</label>
                <input type="text" name="goalWeight" id="goalWeight" placeholder="請輸入體重" required>
            </div>

            <button type="submit" >下一題</button>
        </form>
    </div>
     <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="/asset4/js/script.js">  </script>
	<script type="text/javascript">
 
    
    
    </script>
</body>
</html>
