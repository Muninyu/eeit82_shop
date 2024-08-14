<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BeautyBeast</title>
    <!-- css引用 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset5/css/shop-order-style.css">
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
                <p class="cartbar-ball position-absolute top-0 start-50 translate-middle active">2</p>
                <br>
                <p class="position-absolute top-50 start-50 translate-middle mt-4">填寫資料</p>
            </div>
            <div class="col-4">
                <p class="cartbar-ball position-absolute top-0 start-666 translate-middle">3</p>
                <p class="position-absolute top-50 start-666 translate-middle mt-4">結帳</p>
            </div>
        </div>
        <hr class="mt-5">
        <!-- cart title -->
        <div class="row cart-title">
            <div class="col-lg-4">
                <p>商品</p>
            </div>
            <div class="col-lg-8 row">
                <div class="col-md-3">
                    <p>規格</p>
                </div>
                <div class="col-md-3">
                    <p>單價</p>
                </div>
                <div class="col-md-3">
                    <p>數量</p>
                </div>
                <div class="col-md-3">
                    <p>總計</p>
                </div>
            </div>
        </div>
        <hr>
        <!-- cart context -->
        <c:forEach var="carts" items="${carts}">
	        <div class="row cart-contain my-4 py-3">
	            <div class="col-lg-4 cart-height row">
	                <div class="col-4">
	                	<img src="data:image/png;base64,${carts.products.image_base64}" alt="" class="float-start cart-img me-5">
	                </div>
	                <div class="col-8">
	                	<p class="product-name" id="${carts.products.product_id}">${carts.products.product_name}</p>
	                </div>
	            </div>
	            <div class="col-lg-8 row cart-height">
	                <div class="col-md-3 cart-text-center">
	                    <p class="order-spec">${carts.productSpecifications.spec_name}</p>
	                </div>
	                <div class="col-md-3 cart-text-center">
	                    <p class="order-price">$${carts.products.price}</p>
	                </div>
	                <div class="col-md-3 cart-text-center">
	                    <p class="order-count">${carts.cart_quantity}</p>
	                </div>
	                <div class="col-md-3 cart-text-center">
	                    <p class="order-sum"></p>
	                </div>
	            </div>
	        </div>
        </c:forEach>
        <!-- cart information -->
        <div class="row cart-contain my-4 py-3 pe-4">
            <div class="m-3 cartinf-font">
                <div class="clearfix">
                    <p class="float-start">小計:</p>
                    <p class="float-end" id="order-producttotal"></p>
                </div>
                <div class="clearfix">
                    <p class="float-start">運費:</p>
                    <p class="float-end" id="order-send">$60</p>
                </div>
                <hr class="my-1">
                <div class="clearfix">
                    <p class="float-start">合計:</p>
                    <p class="float-end" id="order-total"></p>
                </div>
            </div>
        </div>
        <hr>
        <!-- cart send -->
        <div class="row my-5">
            <div class="col-lg-6 cartsend-contain mx-3 p-0">
                <p class="cartsend-title">顧客資料</p>
                <div class="m-3">
                    <p class="cartsend-font">顧客名稱</p>
                    <input type="text" name="" id="custom_name" class="cartsend-select" value="${user.real_name}" disabled>
                    <p class="cartsend-font">電子信箱</p>
                    <input type="text" name="" id="custom_email" class="cartsend-select" value="${user.email}" disabled>
                    <p class="cartsend-font">電話號碼</p>
                    <input type="text" name="" id="custom_phone" class="cartsend-select" value="${user.phone}" disabled>
                </div>
            </div>
            <div class="col-lg-5 cartsend-contain mx-3 p-0">
                <p class="cartsend-title">送貨資訊</p>
                <div class="m-3">
                    <p class="cartsend-font2">選擇的送貨方式：超商取貨</p>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="CheckToEqual">
                        <label class="form-check-label" for="flexCheckDefault">
                            收件人資料與顧客資料相同
                        </label>
                    </div>
                    <p class="cartsend-font">收件人名稱</p>
                    <input type="text" id="order_name" class="cartsend-select">
                    <p class="cartsend-font">收件人電話</p>
                    <input type="text" id="order_phone" class="cartsend-select">
                    <div class="clearfix">
	                    <p class="cartsend-font float-start">收貨門市</p>
	                    <button class="float-start store-btn" onclick="storechoice()">選擇門市</button>
                    </div>
                    <input type="text" id="shipping_address" class="cartsend-select" value="${store}" readonly>
                </div>
            </div>
            <div class="col-lg-6 mx-3 my-3 p-0">
                <a href="./shop-cart.html"><button class="cartinf-btn">返回購物車</button></a>
            </div>
            <div class="col-lg-5 mx-3 my-3 p-0">
                <button class="cartinf-btn" onclick="ordersubmit()">提交訂單</button>
            </div>
        </div>
    </div>
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
    <script src="${pageContext.request.contextPath}/asset5/js/shop-order-script.js"></script>
    <script>
	    document.getElementById('CheckToEqual').addEventListener('change', function() {
	        if (this.checked) {
	            $('#order_name')[0].value = "${user.real_name}";
	            $('#order_phone')[0].value = "${user.phone}";	            
	        } else {
	        	$('#order_name')[0].value = "";
	            $('#order_phone')[0].value = "";
	        }
	    });
	    function ordersubmit(){
	    	var order = {
	    		order_name : $('#order_name')[0].value,
	    		order_phone : $('#order_phone')[0].value,
	    		shipping_address : $("#shipping_address")[0].value
	    	}
	    	$.ajax({
	    		type: "POST",
	    		url: "/createOrder",
	    		contentType: 'application/json',
	    		data: JSON.stringify(order),
	    		success: function(){
	    			window.location.href = "/shop/checkout";
	    		},
	    		error: function(){
	    		}
	    	});
	    }
	    function storechoice(){
	    	var shop = {
	    		IsCollection : "N"
	    	}
	    	$.ajax({
	    		type: "POST",
	    		url: "/toFamiShopChoice/notpay",
	    		contentType: 'application/json',
	    		data: JSON.stringify(shop),
	    		success: function(response){
                    document.write(response);
	    		},
	    		error: function(){
	    		}
	    	});
	    }
    </script>
</body>

</html>