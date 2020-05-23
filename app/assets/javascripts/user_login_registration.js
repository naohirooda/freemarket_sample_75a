$(function() {
  $('#passcheck').change(function(){
    if ($(this).prop('checked')) {
      $('#js-password').attr('type','text');
      $('#js-password_confirmation').attr('type','text');
    } else {
      $('#js-password').attr('type','password');
      $('#js-password_confirmation').attr('type','password');
    }
  });
});