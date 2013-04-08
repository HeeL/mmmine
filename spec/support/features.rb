module FeaturesHelper
  def login_user
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Log in'
    within('#login') do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
    end
    click_button 'Log in'
    user
  end
end
