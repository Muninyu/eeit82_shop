<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<% %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BeautyBeast</title>
    <!-- css引用 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset5/css/shop-index-style.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- font -->
    <!-- English -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
        href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
        rel="stylesheet">
    <!-- Chinese -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link
        href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100..900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
        rel="stylesheet">
    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
</head>

<body>
    <!-- navbar -->
    <nav class="navbar navbar-expand-xl nav-bg">
        <div class="container-fluid" id="navbar">
            <!-- RWD button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- logo -->
            <a class="nav-title" href="<c:url value='/shop'/>">B&B</a>
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
                    <!-- cart icon -->
                    <a href="<c:url value='/shop/cart'/>" id="nav-cart-hover-container">
                        <li class="position-relative" id="nav-cart-hover-text" >
                            <i class="fa-solid fa-cart-shopping"></i>
                            <!-- cart hover -->
                            <div class="position-absolute top-100 start-50" id="nav-cart">
                                <!-- cart hover title -->
                                <div class="row nav-cart-title my-2">
                                    <div class="col-5">
                                        <p>商品</p>
                                    </div>
                                    <div class="col-3">
                                        <p>規格</p>
                                    </div>
                                    <div class="col-4 row">
                                        <div class="col-4">
                                            <p>單價</p>
                                        </div>
                                        <div class="col-4">
                                            <p>數量</p>
                                        </div>
                                        <div class="col-4">
                                            <p>總計</p>
                                        </div>
                                    </div>
                                </div>
                                <!-- cart hover context -->
                                <c:forEach var="carts" items="${carts}">
	                            	<div class="row my-2 w-100 mx-0 nav-cart-context">
	                                    <div class="col-5 clearfix nav-cart-height">
	                                        <img src="data:image/png;base64,${carts.products.image_base64}" alt=""
	                                            class="float-start nav-cart-img me-1">
	                                        <p>${carts.products.product_name}</p>
	                                    </div>
	                                    <div class="col-3 nav-cart-height">
	                                        <p>${carts.productSpecifications.spec_name}</p>
	                                    </div>
	                                    <div class="col-4 row nav-cart-height">
	                                        <div class="col-4 cart-text-center">
	                                            <p class="cart-order-price">$${carts.products.price}</p>
	                                        </div>
	                                        <div class="col-4 cart-text-center">
	                                            <p class="cart-order-count">${carts.cart_quantity}</p>
	                                        </div>
	                                        <div class="col-4 cart-text-center">
	                                            <p class="cart-order-sum"></p>
	                                        </div>
	                                    </div>
	                                </div>
                                </c:forEach>
                                <!-- cart hover button -->
                                <div class="d-flex flex-row-reverse" id="nav-cart-button">
                                    <button class="nav-cart-button">查看我的購物車</button>
                                </div>
                            </div>
                        </li>
                    </a>
                    <!-- logout button -->
                    <a class="nav-hover-container" href="/logout">
                        <li class="nav-log nav-hover-text">LOG OUT</li>
                    </a>
                </ul>
            </div>
        </div>
    </nav>
    <!-- carousel -->
    <div class="container-fluid px-0">
        <div id="carouselExampleCaptions" class="carousel slide mx-auto" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"
                    aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                    aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                    aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="5000">
                    <img src="${pageContext.request.contextPath}/asset5/img/index/carousel01.jpg" class="d-block w-100" alt="carousel01">
                </div>
                <div class="carousel-item" data-bs-interval="5000">
                    <img src="${pageContext.request.contextPath}/asset5/img/index/carousel02.jpg" class="d-block w-100" alt="carousel02">
                </div>
                <div class="carousel-item" data-bs-interval="5000">
                    <img src="${pageContext.request.contextPath}/asset5/img/index/carousel03.jpg" class="d-block w-100" alt="carousel03">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    <!-- slide1 -->
    <div class="container-fluid w-75 mt-4 px-5 slide-bg-set1">
        <div class="row">
            <!-- slide title -->
            <div class="col-lg-6">
                <div>
                    <p class="slide-title1">強力推薦</p>
                    <p class="slide-title2">今日優選</p>
                </div>
            </div>
            <!-- slide button -->
            <div class="col-lg-6 ">
                <div class="slide-title3">
                    <a href="./shop-class.html">View All</a>
                </div>
            </div>
            <!-- slide context -->
            <div class="col-lg-12 row">
                <!-- product card -->
                <c:forEach var="randomProducts" items="${randomProducts}">
	                <div class="col-xl-3 col-md-6 px-4 my-2">
	                    <a href="<c:url value='/shop/product/${randomProducts.product_id}'/>">
	                        <div class="pc-bg-set1">
	                            <div>
	                                <img src="data:image/png;base64,${randomProducts.image_base64}" alt="product" class="pc-img-set">
	                            </div>
	                            <div class="row">
	                                <div class="col-8 mt-3 ps-5">
	                                    <p class="pc-font-set1">${randomProducts.productCategories.category_name}</p>
	                                    <p class="pc-font-set2">${randomProducts.product_name}</p>
	                                </div>
	                                <div class="col-4 mt-3">
	                                    <i class="fa fa-shopping-bag pc-icon"></i>
	                                </div>
	                            </div>
	                        </div>
	                    </a>
	                </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <!-- slide2 -->
    <div class="container-fluid w-75 mt-4 px-5 slide-bg-set2">
        <div class="row">
            <!-- slide title -->
            <div class="col-6">
                <div>
                    <p class="slide-title1">不能錯過</p>
                    <p class="slide-title2">熱門商品</p>
                </div>
            </div>
            <!-- slide button -->
            <div class="col-6 ">
                <div class="slide-title3">
                    <a href="./shop-class.html">View All</a>
                </div>
            </div>
            <!-- slide context -->
            <div class="col-lg-12 row">
                <!-- product card -->
                <c:forEach var="topProducts" items="${topProducts}" >
	                <div class="col-xl-2 col-md-6 px-4 my-2">
	                    <a href="<c:url value='/shop/product/${topProducts.product_id}'/>">
	                        <div class="pc-bg-set">
	                            <div>
	                                <img src="data:image/png;base64,${topProducts.image_base64}" alt="product01" class="pc-img-set">
	                            </div>
	                            <div class="p-2 text-center">
	                                <p class="pc-font-set3">${topProducts.productCategories.category_name}</p>
	                                <p class="pc-font-set4">${topProducts.product_name}</p>
	                                <button class="pc-font-set5">查看詳情</button>
	                            </div>
	                        </div>
	                    </a>
	                </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <!-- slide3 -->
    <div class="container-fluid w-75 mt-4 px-5 slide-bg-set1">
        <div class="row">
            <!-- slide title -->
            <div class="col-12">
                <div>
                    <p class="slide-title1">分類</p>
                    <p class="slide-title2">尋找你的健身好物</p>
                </div>
            </div>
            <!-- slide context -->
            <div class="col-lg-12 row">
                <!-- product card -->
                <div class="col-xl-3 col-md-6 px-4 py-2 pc-hover-container">
                    <a href="<c:url value='/shop/class/1'/>" class="position-relative">
                        <div class="pc-bg-set">
                            <div class="p-2">
                                <img src="${pageContext.request.contextPath}/asset5/img/index/category01.jpg" alt="product01" class="pc-img-set">
                            </div>
                            <div>
                                <div style="height: 60px;"></div>
                                <p class="pc-font-set6 pc-hover-text position-absolute">有氧器材</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6 px-4 py-2 pc-hover-container">
                    <a href="<c:url value='/shop/class/2'/>" class="position-relative">
                        <div class="pc-bg-set">
                            <div class="p-2">
                                <img src="${pageContext.request.contextPath}/asset5/img/index/category02.jpg" alt="product01" class="pc-img-set">
                            </div>
                            <div>
                                <div style="height: 60px;"></div>
                                <p class="pc-font-set6 pc-hover-text position-absolute">重訓器材</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6 px-4 py-2 pc-hover-container">
                    <a href="<c:url value='/shop/class/3'/>" class="position-relative">
                        <div class="pc-bg-set">
                            <div class="p-2">
                                <img src="${pageContext.request.contextPath}/asset5/img/index/category03.jpg" alt="product01" class="pc-img-set">
                            </div>
                            <div>
                                <div style="height: 60px;"></div>
                                <p class="pc-font-set6 pc-hover-text position-absolute">營養補充品</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-3 col-md-6 px-4 py-2 pc-hover-container">
                    <a href="<c:url value='/shop/class/4'/>" class="position-relative">
                        <div class="pc-bg-set">
                            <div class="p-2">
                                <img src="${pageContext.request.contextPath}/asset5/img/index/category04.jpg" alt="product01" class="pc-img-set">
                            </div>
                            <div>
                                <div style="height: 60px;"></div>
                                <p class="pc-font-set6 pc-hover-text position-absolute">運動服飾</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
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
    <script src="${pageContext.request.contextPath}/asset5/js/shop-index-script.js"></script>
</body>

</html>