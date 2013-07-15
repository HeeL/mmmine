module ProductHelper

  def product_site
    @product.url.match(/\/\/([^\/]+)/).try(:[], 1)
  end

end