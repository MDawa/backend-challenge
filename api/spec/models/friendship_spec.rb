require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context "friendship between member1 and member2" do 
    before :each do 
      @m1 = FactoryBot.create(:member)
      @m2 = FactoryBot.create(:member2)

      @f = FactoryBot.create(:friendship, member1: @m1, member2: @m2)
    end
    it "should be friends between member1 and member2" do
      expect(@f.member1.id).to eq @m1.id
      expect(@f.member2.id).to eq @m2.id
    end 

    it "should have 1 friendship count for member1 and member2" do
      expect(@m1.friendships_count).to eq 1
      expect(@m2.friendships_count).to eq 1
    end

    it "should increment friendship count if member3 becomes friends with member1" do
      m3 = FactoryBot.create(:member3)

      f2 = FactoryBot.create(:friendship, member1: @m1, member2: m3)
      expect(@m1.friendships_count).to eq 2
      expect(@m2.friendships_count).to eq 1
      expect(m3.friendships_count).to eq 1
    end

    it "should decrement friendship count if member2 unfriends member1" do 
      Friendship.where(member1: @m1.id, member2: @m2.id).destroy_all

      # Refresh records
      @m1.reload
      @m2.reload

      expect(Friendship.count).to eq 0
      expect(@m1.friendships_count).to eq 0
      expect(@m2.friendships_count).to eq 0
    end

    it "shouldn't create extra friendship if relationship exists" do
      f = FactoryBot.build(:friendship, member1: @m1, member2: @m2)

      expect(f.valid?).to eq false
      expect(f.errors.messages[:base][0]).to eq("friendship exists") 
      expect(Friendship.count).to eq 1
    end

    it "shouldn't matter if member1 is in column 'member2' or member2 is in column 'member1'" do
      f = FactoryBot.build(:friendship, member2: @m1, member1: @m2)

      expect(f.valid?).to eq false
      expect(f.errors.messages[:base][0]).to eq("friendship exists") 
      expect(Friendship.count).to eq 1
    end

  end
end
