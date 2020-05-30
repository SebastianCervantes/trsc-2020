$(document).ready(function() {
    $('input[name="deuda"], input[name="cantidad"], select[name="visita"], select[name="taller1"], select[name="taller2"]').change(function(){
        if ($(this).val())
        {
          $("#save_changes").removeAttr('disabled');
        }
      });
});