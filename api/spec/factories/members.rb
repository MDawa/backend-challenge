FactoryBot.define do
  factory :member do
    name { "First User" }
    url { "http://test.com/user1" }
    short_url { "http://tinyurl.com/1" }

    transient do
      headlines {false}
    end

    after :create do |member, options|
      if options.headlines 
        3.times do |i|
          create(:member_headline, headline: "My Headline #{i+1}", heading_type: "h#{i+1}", member: member)
        end
      end
    end
  end

  factory :member2, class: Member do
    name { "Second User" }
    url { "http://test.com/user2" }
    short_url { "http://tinyurl.com/2" }

    transient do
      headlines {false}
    end

    after :create do |member, options|
      if options.headlines 
        3.times do |i|
          create(:member_headline, headline: "My Headline #{i+1}", heading_type: "h#{i+1}", member: member)
        end
      end
    end
  end

  factory :member3, class: Member do
    name { "Third User" }
    url { "http://test.com/user3" }
    short_url { "http://tinyurl.com/3" }

    transient do
      headlines {false}
    end

    after :create do |member, options|
      if options.headlines 
        3.times do |i|
          create(:member_headline, headline: "My Headline #{i+1}", heading_type: "h#{i+1}", member: member)
        end
      end
    end
  end

  factory :outside_member, class: Member do
    name { "Outside User" }
    url { "http://test.com/outside1" }
    short_url { "http://tinyurl.com/outside1" }

    transient do
      headlines {false}
    end

    after :create do |member, options|
      if options.headlines 
        3.times do |i|
          create(:member_headline, headline: "My Headline #{i+1}", heading_type: "h#{i+1}", member: member)
        end
      end
    end

  end
end
