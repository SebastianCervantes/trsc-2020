$('.dropdown').click(function () {
    $('.dropdown-menu').toggleClass('active');
});
$('.dropdown').focusout(function () {
    $(this).find('.dropdown-menu').toggleClass('active');
});
/*End Dropdown Menu*/