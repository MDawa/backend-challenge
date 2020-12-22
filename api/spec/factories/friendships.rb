FactoryBot.define do
  factory :friendship do
    association :member1, factory: :member
    association :member2, factory: :member2
  end
end
