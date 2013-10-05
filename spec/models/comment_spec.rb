require 'spec_helper'

describe Comment do

  context 'create' do
    before do
      @cmt = FactoryGirl.create(:comment)
    end

    it "creates one notification" do
      Notification.count.should eq(1)
    end

    it "notifies the user" do
      notify = Notification.last
      notify.from_user_id.should == @cmt.user.id
      notify.to_user_id.should == @cmt.product.user.id
      notify.item_id.should == @cmt.product.id
    end
  end

end
