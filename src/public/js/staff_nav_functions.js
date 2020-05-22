// var allStates = $(".nav-button");

// allStates.on("click", function() {
  
//   allStates.removeClass("active");
//   $(this).addClass("active");
  
// });

$(document).ready(function() {
    $("nav [href]").each(function() {
        if (this.href == window.location.href) {
            $(this).addClass("active");
        }
    });
});