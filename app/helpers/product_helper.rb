module ProductHelper

  def format_price(product, sign = true)
    price = product.price.to_s.gsub(',', '.').gsub(/[^0-9\.]+/, '')
    currency = get_currency(product.currency)
    curreny_sign = get_currency_sign(product.currency)
    sign ? "#{curreny_sign}#{price} #{currency}" : "#{currency} #{price}"
  end

  def make_mmmine_link
    following_product? ? "#delete_from_mmmine#{@product.id}" : "#make_mmmine#{@product.id}"
  end

  def make_mmmine_title
    following_product? ? 'remove' : 'save to Things I want'
  end

  def following_product?
    current_user && current_user.following?(@product)
  end

end