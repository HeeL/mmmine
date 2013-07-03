require 'spec_helper'

describe ProductsController do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  it "creates a product" do
    url = 'http://www.google.com.ua/images/srpr/logo4w.png'
    get :create, url: url
    @user.products.first.url.should eq(url) 
  end

end