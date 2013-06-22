require 'spec_helper'

describe User do
  subject { User }

  context 'create' do
    it "case insensitive to email" do
      user = FactoryGirl.create(:user, email: 'TeSt@gMaIL.com')
      user.email.should eq('test@gmail.com')
    end
  end

  context 'facebook' do
    context "user exists" do
      it "find a user" do
        fb_user = FactoryGirl.create(:user, uid: '123', provider: 'facebook')
        subject.find_fb_user(fb_auth_data).email.should eq(fb_user.email)
      end

      it "should not find a non facebook user" do
        non_fb_user = FactoryGirl.create(:user, uid: '1234', provider: 'facebook')
        fb_user = subject.find_fb_user(fb_auth_data)
        fb_user.should_not eq(non_fb_user)
        fb_user.uid.should eq(fb_auth_data.uid)
      end
    end

    context "user doesn't exist" do
      it "creates a user" do
        subject.last.try(:email).should be_nil
        fb_user = subject.find_fb_user(fb_auth_data)
        subject.last.try(:email).should eq(fb_user.email)
      end
    end

  end

  def fb_auth_data
    auth = {
      uid: '123',
      provider: 'facebook',
      info: OpenStruct.new({
        email: 'test@test.com',
        location: 'Munich, Germany',
        nickname: 'test.testovich'
      })
    }
    OpenStruct.new(auth)
  end

end
