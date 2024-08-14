// ---- 菜單按鈕事件處理 ----
const hamBurger = document.querySelector(".toggle-btn");

if (hamBurger) {
  hamBurger.addEventListener("click", function () {
    document.querySelector("#sidebar").classList.toggle("expand");
  });
}
// ---- 菜單按鈕事件處理結束 ----


// ---- 全局變量定義 ----
let foodData = [];
let dietLog = {};
let currentDate = new Date().toISOString().split("T")[0]; // 初始化為今天的日期
// ---- 全局變量定義結束 ----


// ---- 搜索卡路里功能 ----
function searchCalories() {
  const searchInput = document.getElementById("searchInput").value.trim().toLowerCase();
  const resultsDiv = document.getElementById("results");
  resultsDiv.innerHTML = "";

  const foundItems = foodData.filter((item) =>
    item["名稱"].toLowerCase().includes(searchInput)
  );

  if (foundItems.length === 0) {
    resultsDiv.innerHTML = `<p>No results found for "${searchInput}".</p>`;
  } else {
    const list = document.createElement("ul");
    foundItems.forEach((item) => {
      const listItem = document.createElement("li");
      const calories = parseFloat(item["熱量(kcal)"]).toFixed(2);
      const unit = item["單位"];
      const weight = item["重量(大約)"];
      listItem.innerHTML = `${item["名稱"]}, 卡路里: ${calories} kcal, 單位: ${unit}, 重量(約): ${weight}`;

      const addButton = document.createElement("button");
      addButton.textContent = "新增";
      addButton.classList.add('btn', 'btn-primary');
      addButton.style.marginLeft = '10px';
      addButton.style.marginTop = '5px';
      addButton.onclick = () => addToDietLog(item["名稱"], calories, unit, weight);
      listItem.appendChild(addButton);
      list.appendChild(listItem);
    });
    resultsDiv.appendChild(list);
  }
}
// ---- 搜索卡路里功能結束 ----


// ---- 添加到飲食日誌功能 ----
function addToDietLog(foodName, calories, unit, weight) {
  if (!dietLog[currentDate]) {
    dietLog[currentDate] = [];
  }
  dietLog[currentDate].push({ foodName, calories, unit, weight });

  const logEntry = {
    date: currentDate,
    mealName: foodName,
    meal: Math.round(calories) // 确保参数名和后端一致
  };

  fetch("/eat/submit_form", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: new URLSearchParams(logEntry)
  })
    .then((response) => {
      if (response.ok) {
        // 提交成功後刷新頁面
        // location.reload();
        return response.text();
      }
      throw new Error('Network response was not ok.');
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}
// ---- 添加到飲食日誌功能結束 ----


function fetchMealsByDate(date) {
  fetch(`/eat/user_meals?date=${date}`)
    .then(response => response.json())
    .then(data => {
      console.log("Fetched meals data: ", data);
      updateDietLog(data);
    })
    .catch(error => console.error("Error fetching meals:", error));
}

// ---- 更新飲食日誌功能 ----
function updateDietLog(log) {
  const dietLogUl = document.getElementById("dietLog");
  dietLogUl.innerHTML = "";

  let totalCalories = 0;
  log.forEach((item) => {
    const listItem = document.createElement("li");
    listItem.textContent = `${item.meal_name}, 卡路里:${item.calories} kcal`;

    const deleteButton = document.createElement("button");
     deleteButton.style.marginLeft = '10px';
     deleteButton.style.marginTop = '5px';
    deleteButton.textContent = "X";
    deleteButton.classList.add('btn', 'btn-danger');
    deleteButton.style.marginLeft = '10px';
    deleteButton.onclick = () => deleteMeal(item.id); // 确保传递 meal_id
    listItem.appendChild(deleteButton);

    dietLogUl.appendChild(listItem);
    totalCalories += item.calories;
  });

  document.getElementById("totalCalories").textContent = totalCalories;
}
// ---- 更新飲食日誌功能結束 ----
function deleteMeal(mealId) {
  if (mealId !== undefined && mealId !== null) {
    fetch(`/eat/delete_meal?mealId=${mealId}`, {
      method: 'DELETE'
    })
    .then(response => {
      if (response.ok) {
		location.reload();
        return response.text();
      }
      throw new Error('Network response was not ok.');
    })
    .then(result => {
      console.log(result);
      fetchMealsByDate(currentDate); // 删除成功后刷新页面
    })
    .catch(error => console.error('Error deleting meal:', error));
  } else {
    console.error('Invalid mealId:', mealId);
  }
}
// ---- 獲取用戶用餐記錄功能 ----
function fetchMealsByDate(date) {
  fetch(`/eat/user_meals?date=${date}`)
    .then(response => response.json())
    .then(data => {
		console.log("Fetched meals data: ", data);
      updateDietLog(data);
    })
    .catch(error => console.error("Error fetching meals:", error));
}
// ---- 獲取用戶用餐記錄功能結束 ----


// ---- DOM 加載後執行初始化代碼 ----
document.addEventListener("DOMContentLoaded", function () {
  var modal = document.getElementById("myModal");

  var span = document.getElementsByClassName("close")[0];

  function openForm(mealType) {
    modal.style.display = "block";
    document.getElementById("mealType").innerText = mealType + "填寫表單";
  }

  function closeForm() {
    modal.style.display = "none";
  }

  document.getElementById("logDate").value = currentDate;
  document.getElementById("displayDate").textContent = currentDate;
  fetchMealsByDate(currentDate); // 初始化時從資料庫抓取當天的飲食記錄

  fetch("/json/food.json")
    .then((response) => response.json())
    .then((data) => {
      foodData = data.product;
    })
    .catch((error) => console.error("Error loading JSON data:", error));

  document.getElementById("logDate").addEventListener("change", function (event) {
    currentDate = event.target.value;
    document.getElementById("displayDate").textContent = currentDate;
    fetchMealsByDate(currentDate); // 選擇新日期時抓取對應日期的飲食記錄
  });
});
// ---- DOM 加載後執行初始化代碼結束 ----


function refreshPage() {
  location.reload();
}
