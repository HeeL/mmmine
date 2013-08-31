FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@example.com"
    end
    name 'Firstname Lastname'
    password 'password'
    location 'Ukraine'
  end
end