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

// cart sum
var productPrice = $(".product-price");
var productCount = $(".product-count");
var productSum = $(".product-sum");
var cpt = $("#cart-producttotal")[0];
var cs = $("#cart-send")[0];
var ct = $("#cart-total")[0];
var tempcpt = 0;
for (let x = 0; x < productPrice.length; x++) {
    price = productPrice[x].textContent.slice(1);
    tempSum = price*productCount[x].value;
    productSum[x].innerHTML = `$${tempSum}`;
    tempcpt = tempcpt + tempSum;
}
cpt.textContent=`$${tempcpt}`
ct.textContent=`$${parseInt(tempcpt)+parseInt(cs.textContent.slice(1))}`;

// cart plus minus button
function cart_btnminus(obj) {
    count = obj.nextElementSibling
    temp = parseInt(count.value);
    if (temp <= 0) {
        count.value = 0;
    } else{
        price = obj.parentElement.previousElementSibling.firstElementChild.textContent.slice(1);
        sum = obj.parentElement.nextElementSibling.firstElementChild;
        temp = temp - 1;
        count.value = temp;
        sum.innerHTML = `$${price * temp}`;
        tempcpt = 0;
        for (let x = 0; x < productPrice.length; x++) {
            price = productPrice[x].textContent.slice(1);
            tempSum = price*productCount[x].value;
            productSum[x].innerHTML = `$${tempSum}`;
            tempcpt = tempcpt + tempSum;
        }
        cpt.textContent=`$${tempcpt}`;
        ct.textContent=`$${parseInt(tempcpt)+parseInt(cs.textContent.slice(1))}`;
    }
}

function cart_btnplus(obj) {
    count = obj.previousElementSibling
    temp = parseInt(count.value);
    if (temp < 0) {
        count.value = 0;
    } else{
        price = obj.parentElement.previousElementSibling.firstElementChild.textContent.slice(1);
        sum = obj.parentElement.nextElementSibling.firstElementChild;
        temp = temp + 1;
        count.value = temp;
        sum.innerHTML = `$${price * temp}`;
        tempcpt = 0;
        for (let x = 0; x < productPrice.length; x++) {
            price = productPrice[x].textContent.slice(1);
            tempSum = price*productCount[x].value;
            productSum[x].innerHTML = `$${tempSum}`;
            tempcpt = tempcpt + tempSum;
        }
        cpt.textContent=`$${tempcpt}`;
        ct.textContent=`$${parseInt(tempcpt)+parseInt(cs.textContent.slice(1))}`;
    }
}
