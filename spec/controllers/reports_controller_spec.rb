require 'spec_helper'

describe ReportsController do

  describe "report on a product" do
    context "reason provided" do
      before :each do
        post :create, reason_num: '2', product_id: '123'
        @mail = ActionMailer::Base.deliveries.last
      end

      it "set proper subject and product url" do
        @mail.subject.should == "[mmmine] User reported on a product!"
        @mail.body.should include("http://mmmine.com/#thing_popup123")
      end

      it "set provdided reason" do
        post :create, reason_num: '2', product_id: '123'
        @mail = ActionMailer::Base.deliveries.last
        @mail.body.should include("Incorrect price")
      end
    end

    context "no reason provided" do
      it "set reason as 'not given'" do
        post :create, product_id: '123'
        mail = ActionMailer::Base.deliveries.last
        mail.body.should include("Not given")
      end
    end

  end
end
