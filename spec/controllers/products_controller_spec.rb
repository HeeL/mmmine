require 'spec_helper'

describe ProductsController do

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