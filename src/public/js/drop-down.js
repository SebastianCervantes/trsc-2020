$('.dropdown').click(function () {
    $('.dropdown').toggleClass('active');
});
$('.dropdown').focusout(function () {
    $('.dropdown').removeClass('active');
});

/*End Dropdown Menu*/