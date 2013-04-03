require 'spec_helper'

describe UsersController do

  before :each do
    @user = FactoryGirl.create(:user, name: 'Test', uid: '123')
    sign_in @user
  end

  describe '#logout' do
    it "signs out a user" do
      subject.current_user.should_not be_nil
      get :logout
      subject.current_user.should be_nil
    end
  end
  
  describe '#register' do
    it "signs up a user" do
      get :register, email: 'test@test.com', password: 's3cr3Tzz', name: 'Name'
      User.where(email: 'test@test.com').count.should == 1
    end
  end

  describe '#login' do
    before :each do
      sign_out subject.current_user
      @test_user = FactoryGirl.create(:user)
    end

    it "is not case sensitive for email" do
      get :login, email: @test_user.email.upcase, password: @test_user.password
      subject.current_user.should == @test_user
    end

    it "signs in a user" do
      get :login, email: @test_user.email, password: @test_user.password
      subject.current_user.should == @test_user
    end

    it "checks password and email" do
      get :login, email: @test_user.email, password: "nil_nil"
      subject.current_user.should be_nil
      get :login, email: 'nil_nil@nil_nil.com', password: @test_user.password
      subject.current_user.should be_nil
    end
    
  end

end