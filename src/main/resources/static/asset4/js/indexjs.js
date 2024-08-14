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

// ==============passwd btn start
const modal = document.getElementById("myModal");
    
    // Get the button that opens the modal
    const btn = document.getElementById("myBtn");
    
    // Get the <span> element that closes the modal
const span = document.getElementsByClassName("close")[0];

function modalOpen(){
	//按鈕是在表單內，點擊按鈕會觸發表單的默認提交行為。 阻止這個默認行為
	event.preventDefault();
    modal.style.display = "block";
}
function modalClose(){
    modal.style.display = "none";
}

btn.addEventListener('click',modalOpen)
span.addEventListener('click',modalClose)


// ==============passwd btn end