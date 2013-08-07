$(document).ready(function(){

  $('#product_category_id').on('change', function(){
    $.get('/categories/subcategories/' + $(this).val(), function(data, e) {
      $('#product_sub_category_id').html(data);
    });
  });

  $('#new_product').on('submit', function(){
    if(form_not_filled()) {
      show_message('Please complete all the fields','','error');
      return false;
    }
    return true;
  });

  function form_not_filled(){
    return $('#new_product :input[value=""][type="file"]').length == 3 || $('#new_product :input[value=""][type!="file"]') == true
  }

  var page_num = 1

  if($('.products_list').length > 0) {
    $(window).on('scroll', function(){
      if(loading_hidden() && near_bottom()) {
        $('#products_loading').css('top', $(document).height() - 100);
        $('#products_loading').css('left', $(document).width() / 2);
        if(page_num > 0) {
          $('#products_loading').show();
          load_new_products();
        }
      }
    });
  }

  function load_new_products(){
    $.post('/products', {page: ++page_num}, function(data, e) {
      if(data == '') {
        page_num = 0;
        return false;
      }
      $('.products_list:last').parent().append(data);
      console.log(data);
    }).complete(function() {
      $('#products_loading').hide();
    });
  }

  function loading_hidden(){
    return $('#products_loading:visible').length == 0;
  }

  function near_bottom(){
    return $(window).scrollTop() > $(document).height() - $(window).height() - 50;
  }

});