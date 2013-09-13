#encoding: utf-8

module ApplicationHelper

  CURRENCIES = [:usd, :nzd, :aud, :gbp]

  def js_msg(text_arr, type = '')
    js = text_arr.map{|text| "show_message(\"#{text.gsub(/"/, "'")}\"#{', "", "error"' if type == 'error'});" if text.present?}.reject{|i| i.nil?}
    javascript_tag("$(document).ready(function(){ #{js.join} });") unless js.empty?
  end

  def get_currency(currency_num)
    CURRENCIES[currency_num].to_s.upcase
  end

  def get_currency_sign(currency_num)
    get_currency(currency_num) == 'GBP' ? '£' : '$'
  end

  def nice_date(date, capitalize = true)
    date = distance_of_time_in_words(Time.now, date)
    "#{capitalize ? date.capitalize : date} ago"
  end

  def notify_text(notify)
    [:follow_user, :share_product, :follow_product, :comment_product, :mention_user]

    {
      follow_user: "started following you",
      share_product: "showed you an #{link_to 'item', product_url(notify.item_id, true)}",
      follow_product: "saved your #{link_to 'item', product_url(notify.item_id, true)}",
      comment_product: "commented on your #{link_to 'item', product_url(notify.item_id, true)}"
    }[Notification::ACTIONS[notify.action]].html_safe
  end

  def has_photo?
    current_user.photo.exists?
  end

  def clear_messages
    flash[:notice] = ''
    flash[:error] = ''
  end

  def product_url(id, reload = false)
    "http://mmmine.com/#{reload && request.fullpath == '/' ? '?r' : '' }#thing_popup#{id}"
  end

  def currencies_for_select
    CURRENCIES.each_with_index.map{|c, i| [c.upcase, i]}
  end

  def at_profile_page?
    params[:controller] == "users" && params[:action] == "show" && !params[:id]
  end

  def at_edit_profile_page?
    params[:controller] == "users" && params[:action] == "edit"
  end

  def subs_cols(subs)
    cols = []
    cols << subs[0, (subs.count   / 2.to_f).round]
    cols << subs[(subs.count   / 2.to_f).round, subs.count]
    cols
  end

end
