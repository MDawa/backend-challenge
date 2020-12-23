require 'rails_helper'

RSpec.describe Member, type: :model do
  context "validations" do
    it "should require a name" do
      member = FactoryBot.build :member, name: ""
      expect(member.valid?).to eq false
      expect(member.errors[:name][0]).to eq("can't be blank") 
    end

    it "should require a url" do
      member = FactoryBot.build :member, url: ""
      expect(member.valid?).to eq false
      expect(member.errors[:url][0]).to eq("can't be blank") 
    end

    it "should require a short_url" do
      member = FactoryBot.build :member, short_url: ""
      expect(member.valid?).to eq false
      expect(member.errors[:short_url][0]).to eq("can't be blank") 
    end
  end

  context "relationships" do 
    it "should have 3 headlines for member1" do
      member = FactoryBot.create(:member, headlines: true)
      expect(member.member_headlines.count).to eq 3 
    end

    it "should have no headlines for member2" do
      member = FactoryBot.create(:member2, headlines: false)
      expect(member.member_headlines.count).to eq 0
    end

    it "should have a headline 'My Third Headline 1' for member3" do
      member = FactoryBot.create(:member3, headlines: true)
      expect(member.member_headlines.count).to eq 3

      selected_headline = member.member_headlines.select {|h| h["headline"] == "My Third Headline 1" }
      expect(selected_headline).not_to be nil 
    end

    context "friend?" do
      it "should return true if checking member2 is friends with member1" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        FactoryBot.create(:friendship, member1: member1, member2: member2)

        member1.reload

        expect(member1.friend?(member2.id)).to eq true
        expect(member2.friend?(member1.id)).to eq true
      end

      it "should return true if checking member2 is friends with member1 if put in DB inversely" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        FactoryBot.create(:friendship, member2: member1, member1: member2)

        member1.reload

        expect(member1.friend?(member2.id)).to eq true
        expect(member2.friend?(member1.id)).to eq true
      end   
    end

    context "friend_path(id)" do 
      it "should return a friends path member1 -> member2 -> member3" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        member3 = FactoryBot.create(:member3)
        FactoryBot.create(:friendship, member1: member1, member2: member2)
        FactoryBot.create(:friendship, member1: member2, member2: member3)

        # It's always assumed the first friend is you
        expect(member1.friend_path(member3.id)).to eq [member1.id, member2.id, member3.id]
      end

      it "should return a friends path member1 -> member2 -> member3 if put in DB inversely" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        member3 = FactoryBot.create(:member3)
        FactoryBot.create(:friendship, member2: member1, member1: member2)
        FactoryBot.create(:friendship, member2: member2, member1: member3)

        # It's always assumed the first friend is you
        expect(member1.friend_path(member3.id)).to eq [member1.id, member2.id, member3.id]
      end


      it "should return a friends path member3 -> member1 -> member2 -> outside" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        member3 = FactoryBot.create(:member3)
        outside = FactoryBot.create(:outside_member)
        FactoryBot.create(:friendship, member1: member3, member2: member1)
        FactoryBot.create(:friendship, member1: member1, member2: member2)
        FactoryBot.create(:friendship, member1: member2, member2: outside)

        # It's always assumed the first friend is you
        expect(member3.friend_path(outside.id)).to eq [member3.id, member1.id, member2.id, outside.id]
      end

      it "should return a friends path member3 -> member1 -> member2 -> outside if put in DB inversely" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        member3 = FactoryBot.create(:member3)
        outside = FactoryBot.create(:outside_member)
        FactoryBot.create(:friendship, member2: member3, member1: member1)
        FactoryBot.create(:friendship, member2: member1, member1: member2)
        FactoryBot.create(:friendship, member2: member2, member1: outside)

        # It's always assumed the first friend is you
        expect(member3.friend_path(outside.id)).to eq [member3.id, member1.id, member2.id, outside.id]
      end  
      
      it "should return an empty array if not friends, or too far apart" do 
        member1 = FactoryBot.create(:member)
        member2 = FactoryBot.create(:member2)
        member3 = FactoryBot.create(:member3)
        outside = FactoryBot.create(:outside_member)
        FactoryBot.create(:friendship, member1: member3, member2: member1)
        FactoryBot.create(:friendship, member1: member1, member2: member2)

        # It's always assumed the first friend is you
        expect(member3.friend_path(outside.id)).to eq []
      end
    end
  end 
end
