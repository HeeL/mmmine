FactoryGirl.define do
  factory :product do
    title 'Title'
    description 'my product'
    size '12'
    price '99'
    currency '1'
    user
    category
    sub_category
  end
end