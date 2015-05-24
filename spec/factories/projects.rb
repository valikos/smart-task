FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.sentence(3, true, 1) }
    association :user, factory: :user
  end
end
