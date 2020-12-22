require 'rails_helper'

RSpec.describe MemberHeadline, type: :model do
  context "validations" do
    it "should have a heading type inclusive of h1,h2,h3" do
      headline = FactoryBot.build(:member_headline, heading_type: "blah")
      expect(headline.valid?).to eq false
      expect(headline.errors[:heading_type][0]).to eq("is not included in the list") 
    end

    it "should have a heading_type" do
      headline = FactoryBot.build(:member_headline, heading_type: "")
      expect(headline.valid?).to eq false
      expect(headline.errors[:heading_type][0]).to eq("is not included in the list") 
    end

    it "should have a headline" do
      headline = FactoryBot.build(:member_headline, headline: "")
      expect(headline.valid?).to eq false
      expect(headline.errors[:headline][0]).to eq("can't be blank") 
    end

    it "should have a member" do 
      headline = FactoryBot.build(:member_headline, member: nil)
      expect(headline.valid?).to eq false
      expect(headline.errors[:member][0]).to eq("must exist") 
    end
  end

  it "should lowercase the heading type before saving to DB" do
    headline = FactoryBot.create(:member_headline, heading_type: "H1")
    expect(headline.heading_type).to eq "h1"

    db_row = MemberHeadline.first
    expect(db_row.heading_type).to eq "h1"

  end
end
