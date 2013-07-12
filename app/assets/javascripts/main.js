function show_message(text, title, type){
  if(typeof(title)==='undefined') title = '';
  if(typeof(type)==='undefined') type = '';

  $.pnotify( {type: type, title: title, text: text} );
}

function track_remote_messages(el){
  el.on('ajax:error', function(data, status, xhr) {
    show_message('Status: ' + status.status + '\n' + status.statusText, 'Error', 'error');
  });
  el.on('ajax:success', function(data, response, xhr) {
    if (response.status == 'error') {
      show_message(response.text, 'Error', 'error');
    }
    else {
      show_message(response.text, 'Success');
    }
  });
}

function show_hide(el, show) {
  show ? el.fadeIn() : el.fadeOut()
}

$(document).ready(function(){
  if(popup = window.location.href.match(/#thing_popup([0-9]+)/)){
    $(popup[0]).modal('show');
  }
});
