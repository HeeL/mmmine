$(document).ready(function(){
  $('#notification_count').on('click', function(e){
    if($('#notifications').is(':visible')) {
      $('#notifications').slideUp();
    }
    else {
      $('#notifications').slideDown();
      $.post('/users/mark_viewed_notification')
      span = $(e.target).find('span');
      span.text('0');
      span.addClass('zero');
    }
		$(window).scrollTop(0);
  });
});