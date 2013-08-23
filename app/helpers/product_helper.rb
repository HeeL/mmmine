module ProductHelper

  def format_price(product, sign = true)
    price = product.price.to_s.gsub(',', '.').gsub(/[^0-9\.]+/, '')
    currency = get_currency(product.currency)
    curreny_sign = get_currency_sign(product.currency)
    sign ? "#{curreny_sign}#{price} #{currency}" : "#{currency} #{price}"
  end

end