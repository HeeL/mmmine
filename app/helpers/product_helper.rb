module ProductHelper

  def format_price(product)
    price = product.price.to_s.gsub(',', '.').gsub(/[^0-9\.]+/, '')
    currency = get_currency(product.currency)
    "#{currency} #{price}"
  end

end