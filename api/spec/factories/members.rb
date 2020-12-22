FactoryBot.define do
  factory :member do
    name { "First User" }
    url { "http://test.com/user1" }
    short_url { "http://tinyurl.com/1" }
  end
end
