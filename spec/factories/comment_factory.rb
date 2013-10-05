FactoryGirl.define do
  factory :comment do
    text 'Comment text'
    product
    user
  end
end