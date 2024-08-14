<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>賣家中心</title>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/asset3/css/111.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

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
			<!-- 主内容 -->
			<h1>數據總覽</h1>
			<hr>
			<h3>每年銷售額、銷售量及增長趨勢</h3>
			<div id="salesChart" style="width: 800px; height: 400px;"></div>
			<hr>
			<h3>全年訪問量圓形圖</h3>
			<div id="visitChart" style="width: 600px; height: 400px;"></div>
			<hr>
		</div>
		<div class="secondary-content">
			<h2>搜尋數據</h2>
			<div>
				
				<label style="font-size: 18px;" for="yearSelect">年份：</label> <select
					id="yearSelect">
					<!-- 这里放置年份选项，从2020年到2024年 -->
					<!-- 你可以使用 JavaScript 动态生成这些选项 -->
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023" selected>2023</option>
					<option value="2024">2024</option>
				</select>
			</div>
			<div class="data-info">
				<h2>數據信息</h2>
				<ul id="dataInfoList">
					<!-- 这里将使用 JavaScript 动态生成数据信息 -->
				</ul>
			</div>



		</div>
	</div>

	<script>
		// 等待页面加载完成后，延迟一段时间再滑入侧边栏和显示标题
		document.addEventListener('DOMContentLoaded', function() {
			setTimeout(function() {
				document.getElementById('sidebar').classList.add('active');
			}, 500); // 设置滑入延迟时间，单位为毫秒，可以根据需要调整

			setTimeout(function() {
				document.querySelector('.main-content h1').classList
						.add('show');
			}, 1000); // 设置显示延迟时间，单位为毫秒，可以根据需要调整
		});
		
		//=============================================================================

		// 根据年份生成销售数据
		function generateSalesData(year) {
			// 生成虚假销售数据
			var salesAmount = [5000, 5380, 10200, 5839, 15280, 17030, 8800, 7640, 17980, 12460, 8000, 19360];
			var salesVolume = [30, 35, 40, 32, 45, 50, 55, 42, 38, 48, 52, 58];
			

			return {
				salesAmount : salesAmount,
				salesVolume : salesVolume
			};
		}

		// 根据年份生成访问数据（每个月的访问量）
		function generateVisitData(year) {
			// 生成虚假每月访问数据
			var visitData = [80, 73, 29, 72, 48, 63, 82, 36, 38, 74, 92, 53];

			return visitData;
		}

		// 更新图表
		function updateCharts() {
			var year = document.getElementById('yearSelect').value;

			// 更新柱状图的数据
			var salesData = generateSalesData(year);
			salesChart.updateSeries([ {
				name : '销售额',
				data : salesData.salesAmount
			}, {
				name : '销售量',
				data : salesData.salesVolume
			} ]);
			console.log("Updated sales data:", salesData); // 添加调试输出

			// 销毁现有的圆形图
			if (visitChart) {
				visitChart.destroy();
			}

			// 生成新的随机访问数据并创建新的圆形图
			var visitData = generateVisitData(year);
			var visitChartOptions = {
				chart : {
					type : 'pie',
					height : 400,
					width : '100%',
					toolbar : {
						show : false
					}
				},
				series : visitData,
				labels : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月',
						'九月', '十月', '十一月', '十二月' ]
			};
			visitChart = new ApexCharts(document.getElementById('visitChart'),
					visitChartOptions);
			visitChart.render();

			// 清空数据信息列表
			var dataInfoList = document.getElementById("dataInfoList");
			dataInfoList.innerHTML = '';

			// 更新数据信息
			generateDataInfo();
		}

		// 生成初始图表数据
		var initialYear = document.getElementById('yearSelect').value;
		var initialSalesData = generateSalesData(initialYear);
		var initialVisitData = generateVisitData(initialYear);

		// 初始化柱状图
		var salesChartOptions = {
			chart : {
				type : 'bar',
				height : 600,
				width : "100%",
				toolbar : {
					show : false
				}

			},
			series : [ {
				name : '銷售額',
				data : initialSalesData.salesAmount,
				color : '#263d62'
			}, {
				name : '銷售量',
				data : initialSalesData.salesVolume,
				color : '#1791c8'
			} ],
			xaxis : {
				categories : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月',
						'九月', '十月', '十一月', '十二月' ],
						
				labels : {
					style : {
						fontSize : '16px', // 設置 x 軸標籤字體大小
						colors: ['#000000'],
						fontWeight: '700'
					}
				}
			},
			
			yaxis : {
				labels : {
					style : {
						fontSize : '16px', // 設置 y 軸標籤字體大小
						colors: ['#000000'],
						fontWeight: '700'
					}
				}
			},
			dataLabels: {
                position: 'top', // 设置数据标签的位置为柱子顶部
                enabled: true, // 启用数据标签
                style: {
                    fontSize: '16px',
                    colors: ['white'] // 设置数据标签文字颜色
                },
                dropShadow: {
                    enabled: true, // 启用光晕效果
                    blur: 6, // 光晕的模糊程度
                    opacity: 1.0, // 光晕的透明度
                    color: 'black'
                }
            },
		    grid: {
		        show: true, // 显示网格线
		        borderColor: 'gray', // 网格线颜色
		        position: 'back', // 网格线显示在数据点的背后
		        xaxis: {
		            lines: {
		                show: false // 显示 X 轴网格线
		            }
		        },
		        yaxis: {
		            lines: {
		                show: true // 显示 Y 轴网格线
		            }
		        },
		        padding: {
		            top: 0,
		            right: 0,
		            bottom: 10,
		            left: 10
		        },
		    },



		};
		var salesChart = new ApexCharts(document.getElementById('salesChart'),
				salesChartOptions);
		salesChart.render();

		// 初始化圆形图
		var visitChartOptions = {
			chart : {
				type : 'pie',
				height : 400,
				width : '100%',
				toolbar : {
					show : false
				}
			},
			series : initialVisitData,
			labels : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月',
					'十月', '十一月', '十二月' ]
			
		};
		var visitChart = new ApexCharts(document.getElementById('visitChart'),
				visitChartOptions);
		visitChart.render();

		//=================================
		// 生成虚拟数据信息
		function generateDataInfo() {
			var totalSalesAmount = 0;
			var totalSalesVolume = 0;
			var totalVisits = 0;
			var totalVisitors = 0;
			var maxSalesMonth = ''; // 记录销售额最高的月份
			var maxVisitsMonth = ''; // 记录访客数最多的月份
			var maxSalesAmount = 0; // 记录最高销售额
			var maxVisitsCount = 0; // 记录最高访客数

			// 假设有 12 个月的销售数据和访问数据
			for (var i = 0; i < 12; i++) {
				var salesAmount = Math.floor(Math.random() * 1000) + 500;
				var visits = Math.floor(Math.random() * 1000) + 500;

				totalSalesAmount += salesAmount;
				totalSalesVolume += Math.floor(Math.random() * 50) + 10;
				totalVisits += visits;
				totalVisitors += Math.floor(Math.random() * 200) + 50;

				// 记录销售额最高的月份和最高销售额
				if (salesAmount > maxSalesAmount) {
					maxSalesAmount = salesAmount;
					maxSalesMonth = (i + 1) + '月';
				}

				// 记录访客数最多的月份和最高访客数
				if (visits > maxVisitsCount) {
					maxVisitsCount = visits;
					maxVisitsMonth = (i + 1) + '月';
				}
			}

			// 创建数据信息列表项
			var dataInfoList = document.getElementById("dataInfoList");
			var dataItems = [ "總銷售額：" + "$" + "133069",
					"總銷售量：" + "525" + "",
					"總訪問量：" + "740" + "人", 
					"最高銷售額月份：" + "12月", "最高訪客數月份：" + "11月"
			// 这里可以根据需要添加更多信息
			];

			// 清空数据信息列表
			dataInfoList.innerHTML = '';

			// 将数据信息添加到列表中
			dataItems.forEach(function(item) {
				var listItem = document.createElement("li");
				listItem.textContent = item;
				listItem.style.listStyleType = 'none'; // 取消列表项前的默认点点
				listItem.style.fontSize = '20px'; // 设置文字大小为 20px
				listItem.style.marginBottom = '15px'; // 添加下方间距
				dataInfoList.appendChild(listItem);
			});
		}

		// 页面加载完成后生成数据信息
		window.addEventListener("load", generateDataInfo);

		// 登出==============================================================================
		// 获取登出按钮元素
		var logoutButton = document.getElementById('logoutButton');

		// 添加点击事件监听器
		logoutButton.addEventListener('click', function() {
			// 弹出确认对话框
			var confirmLogout = confirm('是否確定登出？');

			// 如果用户点击了确定
			if (confirmLogout) {
				// 重定向到指定的 HTML 文件
				window.location.href = 'test2.html';
			}
		});

		document.querySelector('.secondary-content').classList.add('slide-in');
	</script>

</body>

</html>
