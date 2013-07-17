require 'spec_helper'

describe CommentsController do

  describe "#create" do
    before :each do
      sign_in @user = FactoryGirl.create(:user)
    end

    it "creates a comment" do
      product = FactoryGirl.create(:product)
      get :create, text: 'test', product_id: product.id
      product.comments.last.text.should eq('test')
    end
  end
end