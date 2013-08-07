FactoryGirl.define do
  factory :product do
    price '99'
    description 'my product'
    user
  end
end