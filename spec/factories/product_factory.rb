FactoryGirl.define do
  factory :product do
    url 'http://www.google.com.ua/images/srpr/logo4w.png'
    price '99'
    description 'my product'
    user
  end
end