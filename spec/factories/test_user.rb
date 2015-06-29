class TestUser
  attr_accessor  :email, :password, :fbid, :name
end

FactoryGirl.define do
  factory :test_user do
    name 'Sharon Amiggjefjddd Smithwitz'
    fbid '119190691749949'
    email 'zfbzhik_smithwitz_1435589527@tfbnw.net'
    password 'testing'
  end
end
