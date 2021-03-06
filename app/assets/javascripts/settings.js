$(document).ready(function() {
  $(window).on('load resize', function() {
	  var windowWidth = $(window).width();
		if (windowWidth < 750) {
			if (windowWidth < 400) {
				$('.row3, .row4').masonry({
					itemSelector: '.item',
					columnWidth: 300
				});
			}
			else {
				$('.row3').masonry({
					itemSelector: '.item',
					columnWidth: 230
				});
				$('.row4').masonry({
					itemSelector: '.item',
					columnWidth: 229
				});
			}
		} else {
			$('.row3').masonry({
    	  itemSelector: '.item',
    	  columnWidth: 248
    	});
    	$('.row4').masonry({
    	  itemSelector: '.item',
    	  columnWidth: 239
    	});
		}
		$('.row3, .row4').imagesLoaded( function() {
			$('.row3, .row4').masonry();
		});
    });

    $(document).ready(function() {

    $('.social a').tooltip({
      hide: { duration: 0 },
      show: { duration: 100 }
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

    });
    $(function() {
        $('input, textarea').placeholder();
    });
    $('#photo_f_b').on('click', function () {
        $('#photo').click();
        readURL(this);
        return false;
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#preview_photo').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $(window).live('scroll', function() { return false; });

    $('.mini_menu').css({
        'width':($(this).find('.mm_links').outerWidth())+'px'
    });


    $('a.signup').click(function(e) {
        e.preventDefault();
        $('#login').modal('hide');
    });

    $('a.login').click(function(e) {
        e.preventDefault();
        $('#signup').modal('hide');
    });

    $('.tabs li').click(function() {
        $(this).addClass('active').siblings().removeClass('active');

        var id = $(this).find('a').attr('href');
        $('.tab-content > div').slideUp();
        $(id).slideDown( function () {
        });
    });

    $('.nav-menu').on('mouseover', function(e){
      $('#notifications').slideUp('fast');
      el = $(e.target).parent().parent();
      if (!el.find('ul:visible').length && !el.hasClass('nav-menu')) {
        $('ul.nav-menu:visible').slideUp('fast');
        ul = el.find('ul');
        ul.slideDown('fast');
        ul.parent().parent().find('.drop').addClass('active');
      }
    });

    $('.nav-menu').on('mouseleave', function(e){
      if(!$('.nav-menu:hover').length) {
        ul = $(e.target).parent().parent().find('ul:visible');
        ul.slideUp('fast');
        ul.parent().parent().find('.drop').removeClass('active')
      }
    });

    $(document).ready(function() {
      $("input[type=checkbox]:not(#nav-menu-toggle), input[type=radio]").uniform();
      $('.modal').on('shown', function() {
        $("input[type=checkbox], input[type=radio]").uniform();
      });
  });
});


