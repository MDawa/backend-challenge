FactoryBot.define do
  factory :member do
    name { "First User" }
    url { "http://test.com/user1" }
    short_url { "http://tinyurl.com/1" }
  end

  factory :member2, class: Member do
    name { "Second User" }
    url { "http://test.com/user2" }
    short_url { "http://tinyurl.com/2" }
  end

  factory :member3, class: Member do
    name { "Third User" }
    url { "http://test.com/user3" }
    short_url { "http://tinyurl.com/3" }
  end

  factory :outside_member, class: Member do
    name { "Outside User" }
    url { "http://test.com/outside1" }
    short_url { "http://tinyurl.com/outside1" }
  end
end
