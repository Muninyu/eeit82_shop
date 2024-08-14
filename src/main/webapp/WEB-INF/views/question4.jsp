<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>小測驗4</title>
    <link rel="stylesheet" href="/asset4/css/logNquesStyles.css">
</head>
<body>
    <img src="/asset4/image/B&B_text.png" class="logo"></img>
    <a href="/index" class="index">首頁</a>
    <div class="container">
        <h2>每周運動量</h2>
        <form action="" method="post" enctype="multipart/form-data" autocomplete="off" onsubmit="validateForm4(event)">
            <!-- 1.運動量 -->
            <input  type="radio" name="ques4" id="exercise1" value="1"><label class="form-label" for="exercise1">久坐（坐式生活、只有少量走路）</label><br>
                        <input  type="radio" name="ques4" id="exercise2" value="2"><label class="form-label" for="exercise2">輕度活動（每週運動1～3天）</label><br>
                        <input  type="radio" name="ques4" id="exercise3" value="3"><label class="form-label" for="exercise3">中度活動（每週運動3～5天）</label><br>
                        <input  type="radio" name="ques4" id="exercise4" value="4"><label class="form-label" for="exercise4">高度活動（每週運動5～7天）</label><br>
                        <input  type="radio" name="ques4" id="exercise5" value="5"><label class="form-label" for="exercise5">超高度活動（每日均有大量長時間運動）</label><br>

            <button type="submit">註冊拿自己的健康報表</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="/asset4/js/script.js">  </script>
    <script type="text/javascript">
  
    </script>
</body>
</html>
