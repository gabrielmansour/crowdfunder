# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Tina"
    last_name  "Fey"
    sequence(:email) { |n| "tina#{n}@tinafey.com" }
    password "lemonzest"
  end
end
