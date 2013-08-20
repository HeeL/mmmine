$(document).ready(function() {
    $(window).load( function() {
    	$('.row3').masonry({
    	  itemSelector: '.item',
    	  columnWidth: 248
    	});
    	$('.row4').masonry({
    	  itemSelector: '.item',
    	  columnWidth: 247
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

    $(document).on('click', function() {
            $('.drop').removeClass('active').find('ul').slideUp('fast')
    });

    $('.drop').on('click', function(e) {
        $('.drop').removeClass('active').find('ul').slideUp('fast');
        $(this).toggleClass('active').find('ul').stop().slideToggle('fast');
        e.stopPropagation();
    });

    $('.drop').on('mouseover', function(e) {
        $(this).addClass('active');
    });

    $('.drop').on('mouseleave', function(e) {
        if (!$(this).find('ul:visible').length) {
          $(this).removeClass('active');
        }
    });

    $('.drop a').on('click', function() {
        var id = $(this).attr('href');
        $(id).modal('show');
    });

    $(document).ready(function() {
        $("input[type=checkbox], input[type=radio]").uniform();

        $('.modal').on('shown', function() {
            $("input[type=checkbox], input[type=radio]").uniform();
        })
  });
});


