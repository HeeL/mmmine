class PurchaseMailer < ActionMailer::Base
  helper :product, :application

  default from: 'no-reply@mmmine.com'
 
  def buyer(buyer, product)
    @product = product
    @seller = product.user
    @buyer = buyer
    mail(to: buyer.email, subject: "Congratulations, you've bought an item on mmmine")
  end
 
  def seller(buyer, product)
    @product = product
    @seller = product.user
    @buyer = buyer
    mail(to: @seller.email, subject: "Congratulations, you've sold an item on mmmine")
  end

end