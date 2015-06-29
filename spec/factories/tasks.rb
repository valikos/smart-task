FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence(2, false, 0) }
    due_date nil
    association :project, factory: :project
  end
end
