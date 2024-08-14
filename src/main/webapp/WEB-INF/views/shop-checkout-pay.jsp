<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BeautyBeast</title>
    <!-- css引用 -->
    <link rel="stylesheet" href="/asset5/css/shop-checkout-style.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <!-- font -->
    <!-- English -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
        rel="stylesheet">
    <!-- Chinese -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100..900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
        rel="stylesheet">
    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
        integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body>
    <nav class="navbar navbar-expand-xl nav-bg">
        <div class="container-fluid" id="navbar">
            <!-- RWD button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- logo -->
            <a class="nav-title" href="./shop-index.html">B&B</a>
            <!-- navbar context -->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <a class="nav-hover-container" href="<c:url value='/shop/class/1'/>">
                        <li class="nav-hover-text">有氧器材</li>
                    </a>
                    <a class="nav-hover-container" href="<c:url value='/shop/class/2'/>">
                        <li class="nav-hover-text">重訓器材</li>
                    </a>
                    <a class="nav-hover-container" href="<c:url value='/shop/class/3'/>">
                        <li class="nav-hover-text">營養補充品</li>
                    </a>
                    <a class="nav-hover-container" href="<c:url value='/shop/class/4'/>">
                        <li class="nav-hover-text">運動服飾</li>
                    </a>
                    <a class="nav-hover-container" href="<c:url value='/shop/orderhistory'/>">
                        <li class="nav-hover-text">我的訂單</li>
                    </a>
                    <!-- logout button -->
                    <a class="nav-hover-container" href="../index bb.html">
                        <li class="nav-log nav-hover-text">LOG OUT</li>
                    </a>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container-fluid w-75 my-5">
        <!-- cart bar -->
        <div class="row cartbar-set position-relative">
            <div class="col-4"></div>
            <div class="col-4 cartbar-set2"></div>
            <div class="col-4"></div>
            <div class="col-4 ">
                <p class="cartbar-ball position-absolute top-0 start-333 translate-middle">1</p>
                <br>
                <p class="position-absolute top-50 start-333 translate-middle mt-4">購物車</p>
            </div>
            <div class="col-4">
                <p class="cartbar-ball position-absolute top-0 start-50 translate-middle">2</p>
                <br>
                <p class="position-absolute top-50 start-50 translate-middle mt-4">填寫資料</p>
            </div>
            <div class="col-4">
                <p class="cartbar-ball position-absolute top-0 start-666 translate-middle active">3</p>
                <p class="position-absolute top-50 start-666 translate-middle mt-4">結帳</p>
            </div>
        </div>
        <div class="col-12 text-center mt-5">
            <h1>付款完成</h1>
            <h1>已送出訂單</h1>
            <img src="/asset5/img/checkout/checked.png" alt="">
        </div>
    </div>
    <!-- footer -->
    <footer>
        <div class="container-fluid w-50 footer-bg">
            <div class="row ms-5 pt-5">
                <div class="col-md-4">
                    <p class="footer-font-title">BeautyBeast</p>
                    <ul class="footer-context">
                        <li><a href="../about.html">關於我們</a> </li>
                        <li><a href="/dashboard-elf/elves.html">健康精靈</a> </li>
                        <li><a href="/dashboard-myplan/index.html">健身目標</a> </li>
                        <li><a href="shop-index.html">健康好物</a></li>
                        <li><a href="../contact.html">聯絡我們</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <div class="row">
                        <div class="col-lg-6"><a href="#facebook"><i
                                    class="fa-brands fa-facebook-f footer-icon m-3"></i></a></div>
                        <div class="col-lg-6"><a href="#linkedin"><i
                                    class="fa-brands fa-linkedin-in footer-icon m-3"></i></a></div>
                        <div class="col-lg-6"><a href="#twitter"><i
                                    class="fa-brands fa-twitter footer-icon m-3"></i></a></div>
                        <div class="col-lg-6"><a href="#twitter"><i
                                    class="fa-brands fa-instagram footer-icon m-3"></i></a></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <img src="/asset5/img/index/B&B_logo.png" alt="" class="footer-logo">
                </div>
                <div class="col-md-12">
                    <p class="footer-font-company">Copyright © 2024 BeautyBeast Website. All rights reserved. </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- javascript引用 -->
    <script src="/asset5/js/shop-checkout-script.js"></script>
</body>

</html>