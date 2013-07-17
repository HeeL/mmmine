require 'spec_helper'

describe ProductsController do

  describe "create product" do
    before :each do
      sign_in @user = FactoryGirl.create(:user)
    end

    it "creates a product" do
      url = 'http://www.google.com.ua/images/srpr/logo4w.png'
      price = '88'
      desc = 'description of a product'
      get :create, product: {url: url, price: price, description: desc}
      new_product = @user.products.first
      new_product.url.should eq(url)
      new_product.price.should eq(price)
      new_product.description.should eq(desc)
    end
  end

  describe "#index" do
    render_views

    it "sees the products on home page" do
      product = FactoryGirl.create(:product)
      get :index
      response.body.should have_xpath("//a[@href='#thing_popup#{product.id}']")
    end
  end

end