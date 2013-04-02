$(window).load( function() {
$('.items').masonry({
  itemSelector: '.item',
  columnWidth: 248,
  animationOptions: {
    duration: 400
  }
});
});

$(document).ready(function() {
	$(".popup").fancybox({
		padding		: 0,
		wrapCSS		: 's_popup',
		autoSize	: true,
		closeClick	: false
	});
	
$('.social a').tooltip({ 
    track: true, 
    delay: 0, 
    showURL: false, 
    showBody: " - ", 
    fade: 250 
});


    var from = $('.details .t_from'),
        share = $('.details .t_share');

  $('.social .other').click(function(){
     $(this).parent().parent().find(from).slideToggle();
     $(this).parent().parent().find(share).slideToggle();
  });

    $('.item').mouseleave(function() {
        setTimeout(function() {
            from.show();
            share.hide();
        }, 300)
    });

    $('.drop').on('click', function() {
        $(this).toggleClass('active').find('ul').slideToggle('fast')
    });

});