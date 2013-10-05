require 'spec_helper'

describe CommentsController do

  describe "#create" do
    before do 
      @product = FactoryGirl.create(:product)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "creates a comment to a product" do
      cmt_text = 'Here is a text'
      xhr :get, :create, product_id: @product.id, text: cmt_text
      Comment.count.should eq(1)
      cmt = Comment.last
      cmt.text.should eq(cmt_text)
      cmt.user_id.should eq(@user.id)
      cmt.product.id.should eq(@product.id)
    end

  end

  describe "#destroy" do
    before :each do
      @cmt = FactoryGirl.create(:comment)
    end

    context "owner" do
      it "destroy a comment" do
        sign_in @cmt.user
        xhr :get, :destroy, id: @cmt.id
        Comment.where(id: @cmt.id).count.should eq(0)
      end
    end

    context "user not an owner" do
      it "doesn't allow to destroy a product" do
        sign_in FactoryGirl.create(:user)
        xhr :get, :destroy, id: @cmt.id
        Comment.where(id: @cmt.id).count.should eq(1)
      end
    end

  end

end