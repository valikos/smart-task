FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.sentence(2) }
    association :task, factory: :task
  end
end
