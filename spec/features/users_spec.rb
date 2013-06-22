require 'spec_helper'

describe UsersController do

  before :each do
    @user = login_user
  end

  describe '#edit' do
    it "updates all the fields" do
      fields = %w(email location website name)
      checks = %w(mentions_notify new_follower_notify product_save_notify publish_fb)
      visit '/profile/edit'
      fields.each do |f|
        fill_in f.capitalize, with: "new#{@user.send(f)}"
      end
      checks.each do |f|
        find("#user_user_setting_attributes_#{f}").set(false)
      end
      fill_in 'About', with: "new about"
      click_button 'Save Profile'

      fields.each do |f|
        page.should have_xpath("//input[@id='user_#{f}' and @value='new#{@user.send(f)}']")
      end
      page.should have_xpath("//textarea[@id='user_about' and contains(text(), 'new#{@user.about}')]")
      checks.each do |f|
        find("#user_user_setting_attributes_#{f}").should_not be_checked
      end
    end
  end

end