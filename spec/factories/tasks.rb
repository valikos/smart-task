FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence(2, false, 0) }
    association :project, factory: :project
  end
end
