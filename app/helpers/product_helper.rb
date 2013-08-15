module ProductHelper

  def format_price(product)
    price = product.price.to_s.gsub(',', '.').gsub(/[^0-9\.]+/, '')
    currency = get_currency(product.currency)
    curreny_sign = get_currency_sign(product.currency)
    "#{curreny_sign}#{price} #{currency}"
  end

end