// 漢堡選單按鈕切換側邊欄擴展狀態
const hamBurger = document.querySelector(".toggle-btn");

hamBurger.addEventListener("click", function () {
  document.querySelector("#sidebar").classList.toggle("expand");
});

// 日曆初始化及生成
document.addEventListener("DOMContentLoaded", function () {
  // 月份名稱列表
  const month_names = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  // 判斷是否為閏年
  const isLeapYear = (year) => {
    return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
  };

  // 獲取二月的天數
  const getFebDays = (year) => {
    return isLeapYear(year) ? 29 : 28;
  };

  let calendar = document.querySelector(".calendar");
  let currDate = new Date();
  let month = currDate.getMonth();
  let year = currDate.getFullYear();
  let month_picker = document.querySelector("#month-picker");
  let calendar_header_year = calendar.querySelector("#year");

  // 生成日曆
  const generateCalendar = (month, year, day) => {
    let calendar_days = calendar.querySelector(".calendar-days");
    let days_of_month = [
      31,
      getFebDays(year),
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];

    calendar_days.innerHTML = "";

    let curr_month = `${month_names[month]}`;
    month_picker.innerHTML = curr_month;
    calendar_header_year.innerHTML = year;

    for (let i = 0; i < day; i++) {
      let empty_day = document.createElement("div");
      calendar_days.appendChild(empty_day);
    }

    for (let i = 1; i <= days_of_month[month]; i++) {
      let day = document.createElement("div");
      day.classList.add("calendar-day-hover");
      day.innerHTML = i;
      day.innerHTML += `<span></span>
                        <span></span>
                        <span></span>
                        <span></span>`;
      if (
        i === currDate.getDate() &&
        year === currDate.getFullYear() &&
        month === currDate.getMonth()
      ) {
        day.classList.add("curr-date");
      }
      calendar_days.appendChild(day);
    }
  };

  let first_day = new Date(year, month, 1).getDay();
  generateCalendar(month, year, first_day);

  let month_list = calendar.querySelector(".month-list");

  month_names.forEach((e, index) => {
    let month = document.createElement("div");
    month.innerHTML = `<div data-month="${index}">${e}</div>`;
    month.querySelector("div").onclick = () => {
      month_list.classList.remove("show");
      month_picker.innerHTML = e;
      month_picker.dataset.month = index;
      month = index;
      generateCalendar(index, year, first_day);
    };
    month_list.appendChild(month);
  });

  month_picker.onclick = () => {
    month_list.classList.add("show");
  };

  document.querySelector("#prev-year").onclick = () => {
    --year;
    first_day = new Date(year, month, 1).getDay();
    generateCalendar(month, year, first_day);
  };

  document.querySelector("#next-year").onclick = () => {
    ++year;
    first_day = new Date(year, month, 1).getDay();
    generateCalendar(month, year, first_day);
  };
});

// 簽到按鈕功能
const btncheck = document.getElementById("btncheck");

btncheck.addEventListener("click", function () {
  const currDates = document.querySelectorAll(".calendar-days div.curr-date");
  currDates.forEach(function (date) {
    date.style.backgroundColor = "red";
  });
});

// 打開側邊導航欄
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

// 關閉側邊導航欄
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

// 選單
var modal = document.getElementById("myModal");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
function openForm(mealType) {
  modal.style.display = "block";
  document.getElementById("mealType").innerText = mealType + "填寫表單";
}

// When the user clicks on <span> (x), close the modal
function closeForm() {
  modal.style.display = "none";
}



//
