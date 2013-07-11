require 'spec_helper'

describe ProductsController do

  describe "create product" do
    before :each do
      sign_in @user = FactoryGirl.create(:user)
    end

    it "creates a product" do
      url = 'http://www.google.com.ua/images/srpr/logo4w.png'
      get :create, url: url
      @user.products.first.url.should eq(url)
    end
  end

  describe "#comment_create" do
    before :each do
      sign_in @user = FactoryGirl.create(:user)
    end

    it "creates a comment" do
      product = FactoryGirl.create(:product)
      get :comment_create, text: 'test', product_id: product.id
      product.comments.last.text.should eq('test')
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