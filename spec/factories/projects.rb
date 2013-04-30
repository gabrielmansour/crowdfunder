# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    user
    title "5D Glasses"
    teaser "Experience the world as it was meant to be experienced!"
    description "..."
    goal 12000
  end
end
