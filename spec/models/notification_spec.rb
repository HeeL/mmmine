require 'spec_helper'

describe Notification do

  context 'add' do
    before do
      @data = {from_user_id: 1, to_user_id: 2, item_id: 3}
    end

    it "adds notification" do
      actions = Notification::ACTIONS
      action =  actions.first
      Notification.add(@data, action)
      Notification.count.should eq(1)
      notify = Notification.last
      notify.from_user_id.should == @data[:from_user_id]
      notify.to_user_id.should == @data[:to_user_id]
      notify.item_id.should == @data[:item_id]
      notify.action.should == actions.index(action)
    end

    it "doesn't add notification when action not found" do
      Notification.add(@data, :test).should be_false
      Notification.count.should eq(0)
    end
  end

end
