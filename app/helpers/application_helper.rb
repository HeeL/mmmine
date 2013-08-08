module ApplicationHelper

  CURRENCIES = [:usd, :nzd, :aud, :gbp]

  def js_msg(text_arr, type = '')
    js = text_arr.map{|text| "show_message(\"#{text.gsub(/"/, "'")}\"#{', "", "error"' if type == 'error'});" if text.present?}.reject{|i| i.nil?}
    javascript_tag("$(document).ready(function(){ #{js.join} });") unless js.empty?
  end

  def get_currency(currency_num)
    CURRENCIES[currency_num].to_s.upcase
  end

  def has_photo?
    current_user.photo.exists?
  end

  def clear_messages
    flash[:notice] = ''
    flash[:error] = ''
  end

  def product_url(id)
    "http://mmmine.com/#thing_popup#{id}"
  end

  def currencies_for_select
    CURRENCIES.each_with_index.map{|c, i| [c.upcase, i]}
  end

end
