<%@page import="org.hibernate.boot.archive.spi.AbstractArchiveDescriptorFactory"%>
<%@page import="com.example.demo.Orders"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>訂單管理</title>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/asset3/css/113.css">

</head>

<body>
	<div class="container">
		<div class="sidebar" id="sidebar">
			<div class="user-info">
				<img class="user-avatar" src="/asset3/B_B_logo.jpg" alt="用戶头像">
				<h2 class="user-name">管理員</h2>
				<hr class="separator">
			</div>
			<a href="<c:url value='/seller'/>">賣家<br>中心
			</a> <a href="<c:url value='/sellerProducts'/>">商品<br>管理
			</a> <a href="<c:url value='/sellerOrder'/>">訂單<br>管理
			</a> <a href="<c:url value='/sellercontact'/>">聯絡<br>表單
			</a> <a href="#" id="logoutButton">登出</a>
		</div>
		<div class="main-content" id="mainContent">
			<!-- 主內容 -->
			<h1>訂單管理</h1>
			<button class="btngreen" onclick="statuschange()">儲存</button>
			<hr>
			<div class="order-form">
				<table border="1">
					<thead>
						<tr>
							<th>訂單編號</th>
							<th>訂單狀態</th>
							<th>狀態變更</th>
							<th>客戶姓名</th>
							<th>總金額</th>
							<th>訂購時間</th>
							<th>詳細資訊</th>
						</tr>
					</thead>
					<tbody id="orderTableBody">
						<!-- 假訂單資料將會動態添加至此 -->
						<%
						Integer temp = 0;
						List<Integer> ordersum = (List<Integer>)request.getAttribute("ordersum");
						%>
						<c:forEach var ="orders" items="${orders}">
						<tr>
							<td class="order_newid"></td>
							<td class="order-status">${orders.status}</td>
							<td>
								<select class="order-change">
									<option disabled selected>請選擇
									<option value="待處理">待處理
									<option value="處理中">處理中
									<option value="已出貨">已出貨
									<option value="已完成">已完成
									<option value="已取消">已取消
								</select>
							</td>
							<td>${orders.order_name }</td>
							<td>
							<%=ordersum.get(temp) %>
							<%temp = temp + 1;%>
							</td>
							<td class="order_date">${orders.order_date}</td>
							<td class="user_id" style="display: none;">${orders.users.user_id}</td>
							<td><button onclick="showOrderDetails(${orders.order_id })">詳細資訊</button></td>
						</tr>
							
						</c:forEach>

					</tbody>

				</table>

			</div>
			<!-- 模态框容器 -->
			<div id="myModal" class="modal">
				<div class="modal-content">
					<span class="close">&times;</span>
					<div id="modalOrderDetails"></div>
				</div>
			</div>
		</div>
		<div class="secondary-content">
			<h2>訂單查詢</h2>
			<input type="text" id="orderSearchInput" placeholder="輸入訂單編號或用戶姓名">
			<button id="searchButton">搜索</button>
			<p id="errorMessage" style="display: none;"></p>
		</div>
	</div>

	<script>
        // 等待页面加载完成后，延迟一段时间再滑入侧边栏和显示标题
        document.addEventListener('DOMContentLoaded', function () {
            setTimeout(function () {
                document.getElementById('sidebar').classList.add('active');
            }, 500); // 设置滑入延迟时间，单位为毫秒，可以根据需要调整

            setTimeout(function () {
                document.querySelector('.main-content h1').classList.add('show');
            }, 1000); // 设置显示延迟时间，单位为毫秒，可以根据需要调整
        });

        // ========================假定單
        document.addEventListener('DOMContentLoaded', function () {
            // 将假订单数据填充到表格中
            const orderTableBody = document.getElementById('orderTableBody');

            // 获取表格元素
            const orderTable = document.querySelector('table');

            // 设置表格宽度样式
            orderTable.style.width = '100%'; // 设置表格宽度为 100%

            
            const orderStatusCell = $('.order-status');
            for(let i = 0; i < orderStatusCell.length ; i++){
            	switch ($('.order-status')[i].innerHTML) {
                case '待處理':
                	$('.order-status').eq(i).addClass('pending');
                    break;
                case '處理中':
                	$('.order-status').eq(i).addClass('processing');
                    break;
                case '已出貨':
                	$('.order-status').eq(i).addClass('shipped');
                    break;
                case '已完成':
                	$('.order-status').eq(i).addClass('completed');
                    break;
                case '已取消':
                	$('.order-status').eq(i).addClass('cancelled');
                    break;
                default:
                    break;
            }
            }
            
            
            
            
        });



        // 添加在 body 结束标签前的 JavaScript 代码

        // 获取模态框、关闭按钮以及订单详细信息容器
        var modal = document.getElementById('myModal');
        var span = document.getElementsByClassName("close")[0];
        var modalOrderDetails = document.getElementById('modalOrderDetails');
        
        //<c:forEach var ="orders" items="${orders }">
        //	var console.log(${orders.order_id});
        //</c:forEach>
        // 点击详细信息按钮显示模态框
        function showOrderDetails(orderNumber) {
            modal.style.display = "block";

            // 清空模态框中的内容
            modalOrderDetails.innerHTML = '';

            // 根据订单编号查找相应的订单详细信息
           // const order = fakeOrders.find(order => order.orderNumber === orderNumber);

            // 创建包含订单详细信息的 HTML 元素
            
            const detailsElement = document.createElement('div');
            let tempHTML = [];
            <c:forEach var ="orders" items="${orders}" varStatus="loop">
            	tempHTML[${loop.index + 1}] =`        		
        		<h2>訂單詳細資訊</h2>
            	<p>訂單編號 : ${orders.order_id}</p>
        		<p>訂單狀態 : ${orders.status}</p>
        		<p>訂單姓名 : ${orders.order_name}</p>
        		<p>買家電話 : ${orders.order_phone}</p>
        		<p>訂單日期 : ${orders.order_date}</p>
        		<p>訂單地址 : ${orders.shipping_address}</p>
        		<p>訂單項目 :<br>
        		<div style="margin-top: 20px;">
        	    <table class="order-details">
        	        <thead>
        	            <tr>
        	                <th>商品名稱</th>
        	                <th>商品金額</th>
        	                <th>商品規格</th>
        	                <th>商品數量</th>
        	            </tr>
        	        </thead>
        	        <tbody>
        	            <c:forEach var="orderDetail" items="${orderDetailsAll[orders.order_id]}">
        	                <tr>
        	                    <td>${orderDetail.products.product_name}</td>
        	                    <td>${orderDetail.products.price}</td>
        	                    <td>${orderDetail.productSpecifications.spec_name}</td>
        	                    <td>${orderDetail.quantity}</td>
        	                </tr>
        	            </c:forEach>
        	        </tbody>
        	    </table>
        	</div>
        		<p>
        		`
	        </c:forEach>
            // 将订单详细信息添加到模态框
            modalOrderDetails.innerHTML = tempHTML[orderNumber];
        };

        // 点击关闭按钮隐藏模态框
        span.onclick = function () {
            modal.style.display = "none";
        };

        // 点击模态框外部区域也可以隐藏模态框
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        };

        // 登出================
        // 获取登出按钮元素
        var logoutButton = document.getElementById('logoutButton');

        // 添加点击事件监听器
        logoutButton.addEventListener('click', function () {
            // 弹出确认对话框
            var confirmLogout = confirm('是否確定登出？');

            // 如果用户点击了确定
            if (confirmLogout) {
                // 重定向到指定的 HTML 文件
                window.location.href = 'test2.html';
            }
        });

        document.querySelector('.secondary-content').classList.add('slide-in');

        // 添加订单搜索功能
        function searchOrder() {
            // 获取输入框中的搜索词
            var searchTerm = document.getElementById('orderSearchInput').value.trim().toLowerCase();

            // 如果搜索词为空，则显示错误信息并返回
            if (searchTerm === "") {
                document.getElementById('errorMessage').innerText = "請輸入訂單編號或客戶姓名";
                document.getElementById('errorMessage').style.display = "block";
                return;
            } else {
                // 清空错误信息
                document.getElementById('errorMessage').style.display = "none";
            }

            // 在假订单列表中查找匹配的订单
            const matchedOrders = fakeOrders.filter(order => {
                // 将订单编号和客户姓名都转换为小写，以便忽略大小写进行匹配
                const orderNumberLower = order.orderNumber.toLowerCase();
                const customerNameLower = order.customerName.toLowerCase();
                return orderNumberLower.includes(searchTerm) || customerNameLower.includes(searchTerm);
            });

            // 如果找到匹配的订单
            if (matchedOrders.length > 0) {
                // 只显示第一个匹配的订单的详细信息
                showOrderDetails(matchedOrders[0].orderNumber);
            } else {
                // 如果未找到匹配的订单，显示错误信息
                document.getElementById('errorMessage').innerText = "未找到匹配的訂單";
                document.getElementById('errorMessage').style.display = "block";
            }
        };

        // 获取搜索按钮元素
        var searchButton = document.getElementById('searchButton');

        // 添加点击事件监听器
        searchButton.addEventListener('click', function () {
            searchOrder();
        });
        
        for(i = 0; i < $(".order_newid").length; i++){
    		orderdateFormate = $(".order_date")[i].textContent.replace(/[-:\s]/g, '');
	    	$(".order_newid")[i].textContent = "BB"+ orderdateFormate + $(".user_id")[i].textContent;		
    	}
        
        for(i = 0; i < $(".order-change").length; i++){
        	$(".order-change")[i].value = $(".order-status")[i].innerHTML;
        }
        function statuschange(){
        	for(i = 0; i < $(".order-change").length; i++){
        		$(".order-status")[i].innerHTML = $(".order-change")[i].value;
            }
            const orderStatusCell = $('.order-status');
            for(let i = 0; i < orderStatusCell.length ; i++){$('.order-status').eq(i).removeClass('pending processing shipped completed cancelled');
            	switch ($('.order-status')[i].innerHTML) {
                case '待處理':
                	$('.order-status').eq(i).addClass('pending');
                    break;
                case '處理中':
                	$('.order-status').eq(i).addClass('processing');
                    break;
                case '已出貨':
                	$('.order-status').eq(i).addClass('shipped');
                    break;
                case '已完成':
                	$('.order-status').eq(i).addClass('completed');
                    break;
                case '已取消':
                	$('.order-status').eq(i).addClass('cancelled');
                    break;
                default:
                    break;
            }
            }
        }
    </script>

</body>

</html>