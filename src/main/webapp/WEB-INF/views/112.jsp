<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>商品管理</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/asset3/css/112.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
			<h1>商品管理</h1>
			<hr>
			<h3>商品總覽</h3>

			<!-- 分頁 -->
			<div class="tabs">
				<a href="http://localhost:8080/sellerProducts"
					style="text-decoration: none; color: white;">
					<div class="tab active" data-tab="tab0">我的商品</div>
				</a>
				<div class="tab" data-tab="tab1">新增商品</div>

			</div>

			<div class="tab-content active" id="tab0">
				<div class="product-grid" id="MyProducts">
					<!-- 商品列表 -->
					<c:forEach var="product" items="${productsList}">
						<div class="product-item" id="${product.product_name}">
							<!-- 商品圖片 -->
							<img src="data:image/jpeg;base64,${product.image_base64}"
								alt="${product.product_name}">
							<!-- 商品名稱 -->
							<p>${product.product_name}</p>
							<!-- 編輯按鈕 -->
							<button class="edit-btn tab" id="${product.product_id}"
								data-tab="tab2" onclick="edit(this)">編輯</button>
							<!-- 刪除按鈕 -->
							<button class="delete-btn" id="${product.product_id}"
								onclick="deleteProduct(this)">刪除</button>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="tab-content" id="tab1">
				<form action="/add1" method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<label for="productName">商品名稱</label> <input type="text"
							class="form-control" id="product_name" name="product_name"
							required>
					</div>
					<div class="form-group">
						<label for="subtitle">副標題</label> <input type="text"
							class="form-control" id="subtitle" name="subtitle">
					</div>
					<div class="form-group">
						<label for="description">描述</label>
						<textarea class="form-control" id="description" name="description"
							rows="3"></textarea>
					</div>
					<div class="form-group">
						<label for="price">價格</label> <input type="number"
							class="form-control" id="price" name="price" min="0" step="0.01"
							required>
					</div>
					<div class="form-group">
						<label for="categoryId">類別</label> <select class="form-control"
							id="category_id" name="category_id" required>
							<option value="1">有氧器材</option>
							<option value="2">重訓器材</option>
							<option value="3">健身補充品</option>
							<option value="4">健身服飾</option>
							<!-- 根據實際情況添加更多選項 -->
						</select>
					</div>
					<div class="form-group">
						<label for="image">選擇圖片 (PNG/JPG)</label> <input type="file"
							class="form-control-file" id="image_base64" name="image_base64"
							accept=".png, .jpg, .jpeg" required>
					</div>
					<div class="form-group">
						<label for="stockQuantity">庫存數量</label> <input type="number"
							class="form-control" id="stock_quantity" name="stock_quantity"
							min="0" required>
					</div>
					
					<button type="submit" class="btn btn-primary">確定新增</button>
				</form>
			</div>




			<!--  -->




			<div class="tab-content" id="tab2">
				<h2>編輯商品</h2>
				<form action="/renew" method="POST" enctype="multipart/form-data">
					<div class="form-group">
						<label for="edit_product_name">商品名稱</label> <input type="text"
							class="form-control" id="edit_product_name"
							name="edit_product_name" required>
					</div>
					<div class="form-group">
						<label for="edit_subtitle">副標題</label> <input type="text"
							class="form-control" id="edit_subtitle" name="edit_subtitle">
					</div>
					<div class="form-group">
						<label for="edit_description">描述</label>
						<textarea class="form-control" id="edit_description"
							name="edit_description" rows="3"></textarea>
					</div>
					<div class="form-group">
						<label for="edit_price">價格</label> <input type="number"
							class="form-control" id="edit_price" name="edit_price" min="0"
							step="0.01" required>
					</div>
					<div class="form-group">
						<label for="edit_category_id">類別</label> <select
							class="form-control" id="edit_category_id"
							name="edit_category_id" required>
							<option value="1">有氧器材</option>
							<option value="2">重訓器材</option>
							<option value="3">健身補充品</option>
							<option value="4">健身服飾</option>
							<!-- 根據實際情況添加更多選項 -->
						</select>
					</div>
					<div class="form-group">
						<label for="edit_image_base64">選擇圖片 (PNG/JPG)</label> <input
							type="file" class="form-control-file" id="edit_image_base64"
							name="edit_image_base64" accept=".png, .jpg, .jpeg">
					</div>
					<div class="form-group">
						<label for="edit_stock_quantity">庫存數量</label> <input type="number"
							class="form-control" id="edit_stock_quantity"
							name="edit_stock_quantity" min="0" required>
					</div>
					

					<button type="button" class="btngreen" id="edit_sales_id"
						onclick="updateProduct()">保存編輯</button>
					<button type="button" class="btnred " onclick="cancelEdit()">取消編輯</button>
				</form>
			</div>

		</div>
		<div class="secondary-content">
			<h2>商品查詢</h2>
			<form id="productSearchForm">
				<div class="form-group">
					<label for="productName">商品名稱:</label> <input type="text"
						id="productName" name="productName" placeholder="请输入商品名稱">
				</div>
				<%--
				<div class="form-group">
					 <label for="category">商品分類:</label> <select id="category"
						name="category">
						<option value="">全部分類</option>
						<option value="cardio">有氧器材</option>
						<option value="weight_training">重訓器材</option>
						<option value="supplements">營養補充品</option>
						<option value="sportswear">運動服飾</option>
					</select>
				</div>
				--%>
				<div class="form-group">
					<button class="btngreen" type="button" onclick="searchProducts()">查詢</button>
				</div>
			</form>
			<!-- 查询结果将在此显示 -->
			<div id="searchResults">
				<!-- 查询结果将动态添加至此 -->
			</div>
			
		</div>
	</div>


	<script>
document.addEventListener('DOMContentLoaded', function () {
    // 添加激活侧边栏的类
    setTimeout(function () {
        document.getElementById('sidebar').classList.add('active');
    }, 500);

    // 添加标题显示的类
    setTimeout(function () {
        document.querySelector('.main-content h1').classList.add('show');
    }, 1000);

    // 标签页切换功能
    const tabs = document.querySelectorAll('.tab');
    const tabContents = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
        tab.addEventListener('click', function () {
            // 移除所有标签和内容的激活类
            tabs.forEach(t => t.classList.remove('active'));
            tabContents.forEach(tc => tc.classList.remove('active'));

            // 激活当前标签和对应的内容
            this.classList.add('active');
            document.getElementById(this.dataset.tab).classList.add('active');
        });
    });



    // 登出功能
    var logoutButton = document.getElementById('logoutButton');
    logoutButton.addEventListener('click', function () {
        var confirmLogout = confirm('是否確定登出？');
        if (confirmLogout) {
            window.location.href = 'test2.html';
        }
    });
});

document.querySelector('.secondary-content').classList.add('slide-in');



function edit (object){
	var product =　{
			product_id : object.id
	};
	$.ajax({
		type:"POST",
		url:"/editProducts",
		contentType: "application/json",
		data: JSON.stringify(product),
		success: function (response) {
	        
			document.getElementById('edit_sales_id').name =response.product_id;
	        document.getElementById('edit_product_name').value =response.product_name;
	        document.getElementById('edit_subtitle').value =response.subtitle;
	        document.getElementById('edit_description').value =response.description;
	        document.getElementById('edit_price').value =response.price;
	        document.getElementById('edit_category_id').value =response.productCategories.category_id;
	        document.getElementById('edit_stock_quantity').value =response.stock_quantity;
	        document.getElementById('edit_sales_quantity').value =response.sales_quantity;
	    
	    },
	    error: function () {
	        alert("商品編輯失敗，請重試！");
	    }
	})
}

function cancelEdit() {
    if (confirm('確定取消編輯？')) {
        // 用户点击了确认
        // 可以在这里添加取消编辑时的逻辑处理，比如重置表单字段等
    	  window.location.href = '<c:url value="/sellerProducts"/>';
    } else {
        // 用户点击了取消，不执行任何操作
    }
}



function updateProduct() {
    var formData = new FormData();
    formData.append("edit_sales_id", $("#edit_sales_id")[0].name);
    formData.append("edit_product_name", $("#edit_product_name").val());
    formData.append("edit_subtitle", $("#edit_subtitle").val());
    formData.append("edit_description", $("#edit_description").val());
    formData.append("edit_price", $("#edit_price").val());
    formData.append("edit_category_id", $("#edit_category_id").val());
    formData.append("edit_image_base64", $("#edit_image_base64")[0].files[0]);
    formData.append("edit_stock_quantity", $("#edit_stock_quantity").val());
    formData.append("edit_sales_quantity", $("#edit_sales_quantity").val());

    $.ajax({
        type: "POST",
        url: "/renew", // 你的後端控制器URL
        data: formData,
        processData: false,
        contentType: false,
        enctype: 'multipart/form-data',
        cache: false,
        success: function(response) {
            alert('商品已成功更新！');
            // 可以根據需要進行頁面的刷新或者其他處理
            location.reload();
        },
        error: function(e) {
            alert('更新失敗：' + e.responseText);
        }
    });
}


function deleteProduct(object) {
    if (confirm('確定要刪除這個商品嗎？')) {
        $.ajax({
            type: "POST",
            url: "/deleteProduct/" + object.id,  // 确保这里的路径正确
            success: function (response) {
                alert('商品已成功刪除！');
                location.reload();
                // 可以根据需要刷新页面或者进行其他处理
            },
            error: function (e) {
            	console.log(e)
                alert('刪除失敗：' + e.responseText);
            }
        });
    }
}
//查詢

function searchProducts() {
    var productName1 = document.getElementById('productName').value;
    $.ajax({
        type: "POST",
        url: "/searchProducts",
        contentType: "application/json",
        data: JSON.stringify({
            productName: productName1
        }),
        success: function(product_ids) {
        	var params = product_ids.map(product_id => "product_id=" + encodeURIComponent(product_id)).join("&");
        	window.location.href = "/search?" + params;

        	
        },
        error: function(e) {
            alert('查詢失敗：' + e.responseText);
        }
    });
}




















</script>

</body>

</html>
