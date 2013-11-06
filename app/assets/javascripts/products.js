$(document).ready(function(){

  $('#product_category_id').live('change', function(e){
    cat_select = $(e.target);
    $.get('/categories/subcategories/' + $(this).val(), function(data, e) {
      cat_select.parent().find('#product_sub_category_id').html(data);
    });
  });

  $('#new_product').on('ajaxSend', function(){
    $('#new_product_loading').show();
  });

  $('#new_product').on('ajaxComplete', function(){
    $('#new_product_loading').hide();
  });

  $('#new_product').on('submit', function(){
    if(form_not_filled()) {
      show_message('oops! We’re missing some information,<br /> please review your listing','','error');
      return false;
    }
    return true;
  });

  $('button[class*="delete-item-btn"]').live('click', function(e){
    if(confirm('Are you sure you want remove this item?')) {
      window.location.href = '/products/destroy/' + $(e.target).data('delete-item-id');
    }
  });

  $('.guest-buy-now, .guest-make-mine, .guest-share-product').live('click', function(e){
    scrollTo(0,35);
    $('#signup').modal('show');
  });

  comment_form = $('.comment-form[data-guest="true"]');
  comment_form.find('textarea').live('focus', function(){
    scrollTo(0,35);
    $('#signup').modal('show');
  });

  comment_form.live('submit', function(){
    scrollTo(0,35);
    $('#signup').modal('show');
    return false;
  });

  function form_not_filled(){
    return $('#new_product :input[value=""][type="file"]').length == 3 ||
    $('#new_product :input[value=""][type!="file"]') == true ||
    empty_field('product_title') ||
    empty_field('product_price') ||
    empty_field('product_size') ||
    empty_field('product_sub_category_id') ||
    empty_field('product_category_id') ||
    empty_field('product_description')
  }

  function empty_field(field_id) {
    return $('#' + field_id).val() == ''
  }

  $('.cancel-follow').live('click', function(e){
    $('#delete_from_mmmine' + $(e.target).data('cancel-follow')).modal('hide');
  });

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
    product_path = $('.products_list').data('product-path');
    $.post(product_path, {page: ++page_num}, function(data, e) {
      if(data == '') {
        page_num = 0;
        return false;
      }
      $('.products_list:last').parent().append(data);
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