FactoryGirl.define do
  factory :notification do
    from_user_id {FactoryGirl.create(:user).id}
    to_user_id {FactoryGirl.create(:user).id}
    action 1
    item_id {FactoryGirl.create(:product).id}
  end
end