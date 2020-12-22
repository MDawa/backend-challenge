FactoryBot.define do
  factory :member_headline do
    headline { "My Headline" }
    heading_type { "h1" }
    member
  end
end
