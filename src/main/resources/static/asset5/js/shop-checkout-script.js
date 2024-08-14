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