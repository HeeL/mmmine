module ProductHelper

  def product_site
    @product.url.match(/\/\/([^\/]+)/).try(:[], 1)
  end

  def format_price(price)
    '$' + price.to_s.gsub(',', '.').gsub(/[^0-9\.]+/, '')
  end

end