var hamburger = document.getElementById('Hamburger');
var header_nav = document.getElementById('Header-Nav');

hamburger.addEventListener('click', function () {
    header_nav.classList.toggle("active");
});