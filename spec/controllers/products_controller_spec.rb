require 'spec_helper'

describe ProductsController do

  describe "#index" do
    render_views
    before :each do
      @product = FactoryGirl.create(:product)
    end

    it "shows the products on home page" do
      get :index
      response.body.should have_xpath("//a[@href='#thing_popup#{@product.id}']")
    end

    context "manage links" do
      before :each do
        sign_in @user = FactoryGirl.create(:user)
        @user_product = FactoryGirl.create(:product, user: @user)
        get :index
      end

      it "shows delete link only for owner of a product" do
          response.body.should have_xpath("//div[@id='thing_popup#{@user_product.id}']//a[@href='/products/destroy/#{@user_product.id}']")
          response.body.should_not have_xpath("//div[@id='thing_popup#{@product.id}']//a[@href='/products/destroy/#{@product.id}']")
      end

      it "shows report link to people who doesn't own the product" do
        response.body.should have_xpath("//div[@id='thing_popup#{@product.id}']//a[@href='#report']")
        response.body.should_not have_xpath("//div[@id='thing_popup#{@user_product.id}']//a[@href='#report']")
      end
    end
  end

  describe "#destroy" do
    before :each do
      @product = FactoryGirl.create(:product)
    end

    context "owner" do
      it "destroy a product" do
        sign_in @product.user
        get :destroy, id: @product.id
        Product.where(id: @product.id).count.should eq(0)
      end
    end

    context "user not an owner" do
      it "doesn't allow to destroy a product" do
        sign_in FactoryGirl.create(:user)
        get :destroy, id: @product.id
        Product.where(id: @product.id).count.should eq(1)
      end
    end


  end

end