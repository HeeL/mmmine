class PurchaseMailer < ActionMailer::Base
  helper :product, :application

  default from: 'no-reply@mmmine.com'
 
  def buyer(buyer, product)
    @product = product
    @seller = product.user
    @buyer = buyer
    mail(to: buyer.email, subject: "[mmmine] You have just purchased a product!")
  end
 
  def seller(buyer, product)
    @product = product
    @seller = product.user
    @buyer = buyer
    mail(to: @seller.email, subject: "[mmmine] Somebody has just purchased one of your products!")
  end

end