FactoryBot.define do
  factory :member do
    name { "First User" }
    url { "http://test.com/user1" }
    short_url { "http://tinyurl.com/1" }

    transient do
      member_headline do 
        create_list(:member_headline, 3).each_with_index do |mh, i|
          mh.headline  = "My Headline #{i}"
          mh.heading_type = "h#{i}"
        end
      end
    end
  end

  factory :member2, class: Member do
    name { "Second User" }
    url { "http://test.com/user2" }
    short_url { "http://tinyurl.com/2" }

    transient do
      member_headline do 
        create_list(:member_headline, 3).each_with_index do |mh, i|
          mh.headline = "My Second Headline #{i}"
          mh.heading_type = "h#{i}"
        end
      end
    end
  end

  factory :member3, class: Member do
    name { "Third User" }
    url { "http://test.com/user3" }
    short_url { "http://tinyurl.com/3" }

    transient do
      member_headline do 
        create_list(:member_headline, 3).each_with_index do |mh, i|
          mh.headline = "My Third Headline #{i}"
          mh.heading_type = "h#{i}"
        end
      end
    end
  end

  factory :outside_member, class: Member do
    name { "Outside User" }
    url { "http://test.com/outside1" }
    short_url { "http://tinyurl.com/outside1" }

    transient do
      member_headline do 
        create_list(:member_headline, 3).each_with_index do |mh, i|
          mh.headline = "My Outside Headline #{i}"
          mh.heading_type = "h#{i}"
        end
      end
    end

  end
end
