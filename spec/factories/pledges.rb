# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pledge do
    user
    project
    amount 1
  end
end
