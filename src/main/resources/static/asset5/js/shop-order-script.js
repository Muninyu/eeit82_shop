// navbar fixedtop
$(document).ready(function () {
    var navbar = $('#navbar');
    var navbarOffset = navbar.offset().top;

    $(window).scroll(function () {
        if ($(window).scrollTop() >= navbarOffset) {
            navbar.addClass('nav-fixed');
        } else {
            navbar.removeClass('nav-fixed');
        }
    });
});

// navbar hover
const nht = $(".nav-hover-text");
const nhc = $(".nav-hover-container");
for (let x = 0; x < nht.length; x++) {
    nht[x].addEventListener(
        "mouseover",
        (event) => {
            nht[x].setAttribute("style", "background-color: white; border-radius: 20px;");
            nhc[x].setAttribute("style", "color: black;");
        });
    nht[x].addEventListener(
        "mouseout",
        (event) => {
            nht[x].setAttribute("style", "");
            nhc[x].setAttribute("style", "");
        });
}

// order sum
var orderPrice = $(".order-price");
var orderCount = $(".order-count");
var orderSum = $(".order-sum");
var opt = $("#order-producttotal")[0];
var os = $("#order-send")[0];
var ot = $("#order-total")[0];
var tempopt = 0;
for (let x = 0; x < orderPrice.length; x++) {
    price = orderPrice[x].textContent.slice(1);
    tempSum = price*orderCount[x].textContent;
    orderSum[x].innerHTML = `$${tempSum}`;
    tempopt = tempopt + tempSum;
}
opt.textContent=`$${tempopt}`
ot.textContent=`$${parseInt(tempopt)+parseInt(os.textContent.slice(1))}`;