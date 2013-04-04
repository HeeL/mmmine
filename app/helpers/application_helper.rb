module ApplicationHelper

  def js_msg(text_arr, type = '')
    js = text_arr.map{|text| "show_message(\"#{text.gsub(/"/, "'")}\"#{', "", "error"' if type == 'error'});" if text.present?}.reject{|i| i.nil?}
    javascript_tag("$(document).ready(function(){ #{js.join} });") unless js.empty?
  end

  def has_photo?
    current_user.photo.exists?
  end

end
