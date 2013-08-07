module ProductHelper

  def format_price(price)
    '$' + price.to_s.gsub(',', '.').gsub(/[^0-9\.]+/, '')
  end

  def can_manage?
    current_user && current_user.id == @product.user.id
  end

end