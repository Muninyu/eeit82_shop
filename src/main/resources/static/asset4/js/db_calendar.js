document.addEventListener("DOMContentLoaded", () => {
    const calendar = document.getElementById("calendar");
    const signedInDaysElement = document.getElementById("signedInDays");
    const currentMonthElement = document.getElementById("currentMonth");
    const prevMonthButton = document.getElementById("prevMonth");
    const nextMonthButton = document.getElementById("nextMonth");

    let signedInDays = 0;
    let currentDate = new Date();
    const today = new Date();

    prevMonthButton.addEventListener("click", () => {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar();
    });

    nextMonthButton.addEventListener("click", () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar();
    });

    // 從後端取得簽到資料
    fetch('http://localhost:3000/api/signin')
        .then(response => response.json())
        .then(data => {
            // 初始化日曆
            renderCalendar(data);
        });

    function renderCalendar(data = []) {
        calendar.innerHTML = `
    <div class="day-header">S</div>
    <div class="day-header">M</div>
    <div class="day-header">T</div>
    <div class="day-header">W</div>
    <div class="day-header">T</div>
    <div class="day-header">F</div>
    <div class="day-header">S</div>
`;

        signedInDays = 0;
        signedInDaysElement.textContent = signedInDays;

        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();
        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        currentMonthElement.textContent = currentDate.toLocaleDateString('zh-Hant', { year: 'numeric', month: 'long' });

        for (let i = 0; i < firstDay; i++) {
            const emptyCell = document.createElement("div");
            calendar.appendChild(emptyCell);
        }

        for (let day = 1; day <= daysInMonth; day++) {
            const date = new Date(year, month, day);
            const dateStr = date.toISOString().split('T')[0];
            const signedIn = data.some(d => d.date === dateStr && d.signedIn);
            const dayElement = createDayElement(day, dateStr, signedIn, date);
            calendar.appendChild(dayElement);
            if (signedIn) signedInDays++;
        }

        signedInDaysElement.textContent = signedInDays;
    }

    function createDayElement(day, dateStr, signedIn, date) {
        const dayElement = document.createElement("div");
        dayElement.textContent = day;

        if (date < today) {
            dayElement.className = "db-day past";
        } else if (date.toDateString() === today.toDateString()) {
            dayElement.className = signedIn ? "db-day signed" : "db-day not-signed";
            dayElement.addEventListener("click", () => toggleSignIn(dayElement, dateStr));
        } else {
            dayElement.className = "db-day future";
        }

        return dayElement;
    }

    function toggleSignIn(dayElement, dateStr) {
        const signedIn = !dayElement.classList.contains("signed");
        dayElement.classList.toggle("signed", signedIn);
        dayElement.classList.toggle("not-signed", !signedIn);
        signedInDays += signedIn ? 1 : -1;
        signedInDaysElement.textContent = signedInDays;

        // 更新簽到資料到後端
        fetch('http://localhost:3000/api/signin', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ date: dateStr, signedIn })
        });
    }

    renderCalendar();
});
// navbar===start
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.menu-icon').addEventListener('click', function() {
        const navbar = document.querySelector('.navbar');
        const mainContent = document.querySelector('.main-content');
        
        if (navbar.classList.contains('expanded')) {
            navbar.classList.remove('expanded');
            mainContent.classList.remove('shifted');
        } else {
            navbar.classList.add('expanded');
            mainContent.classList.add('shifted');
        }
    });
});
// navbar===end