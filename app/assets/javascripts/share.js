$(document).ready(function(){
  $('.share-product #users').tagit({
    allowSpaces: true,
    caseSensitive: false,
    placeholderText: 'Mention your friends',
    autocomplete: {
      source: function( request, response ) {
        $.get('/users/match_names', {name: request.term}, function(data){
          response(data);
        });
      },
      minLength: 2
    },
    afterTagAdded: function(event, input) {
      lang = input.tag.find('span.tagit-label').text();
      $.get('/users/match_names', {name: lang, exact: 1}, function(data){
        if(data.length == 0) {
          show_message("The user with this name doesn't exist");
          $(event.target).tagit('removeTagByLabel', lang);
        }
      });
    }
  });
	
	$('.responsive-menu-toggle').on('click', function(e) {
		e.preventDefault();
		toggleTarget(this);
	});
	
	$('.search-box-toggle').on('click', function(e) {
		e.preventDefault();
		toggleTarget(this);
	});
	
	$('.show-filters-toggle').on('click', function(e) {
		e.preventDefault();
		toggleTarget(this);
	});
	
});

function toggleTarget(toggle) {
	
  	var menuWrap = $(toggle).attr('data-target');
		if ($(menuWrap).hasClass('on')) {
		  $(menuWrap).slideUp(200).removeClass('on');
		} 
		else {
			$(menuWrap).slideDown(200).addClass('on');
		}

}