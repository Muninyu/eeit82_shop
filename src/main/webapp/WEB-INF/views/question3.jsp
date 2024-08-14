<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/asset4/css/logNquesStyles.css">
    <title>小測驗3</title>
</head>
<body>
    <img src="/asset4/image/B&B_text.png" class="logo"></img>
    <a href="/index" class="index">首頁</a>
    <div class="container">
        <h2>每天喝水情形</h2>
        <form action="" method="post" enctype="multipart/form-data" autocomplete="off" onsubmit="validateForm3(event)">
            <!-- 1.喝水 -->
                        <input  type="radio" name="ques3" id="water1"><label class="form-label" for="water1">我只喝茶或咖啡</label><br>
                        <input  type="radio" name="ques3" id="water2"><label class="form-label" for="water2">不超過0.5升</label><br>
                        <input  type="radio" name="ques3" id="water3"><label class="form-label" for="water3">大約0.5升~1.5升</label><br>
                        <input  type="radio" name="ques3" id="water4"><label class="form-label" for="water4">大約1.5升~2.5升</label><br>
                        <input  type="radio" name="ques3" id="water5"><label class="form-label" for="water5">超過2.5升</label><br>
            <button type="submit" >最後一題</button>
        </form>
    </div>
     <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="/asset4/js/script.js">  </script>
    <script type="text/javascript">

    </script>

</body>
</html>
