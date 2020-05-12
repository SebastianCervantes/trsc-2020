$(document).ready(function(){

    $('#image-section-home').delay(500).animate({opacity: '1'});
  
    $flag = true;
    $abierto = false;
      $('#burger-menu, #menu-display > a').click(function(){
      $('#burger-menu').toggleClass('open');
      if($flag){
        $('#menu-display').addClass('fade')
        $flag = false;
      } else {
        $('#menu-display').removeClass('fade');
        $flag = true;
      }
    });
  
    $('#close').click(function(){
      $('#check-in').fadeOut();
      $abierto = !$abierto;
    });
  
    $("select").change(function(){
      $(this).addClass( "selected" );
    });
  
  });
  
  $(window).scroll(function() {
    if ($(window).scrollTop() > 10) {
        $('#navBar').addClass('floatingNav');
    } else {
        $('#navBar').removeClass('floatingNav');
    }
  });