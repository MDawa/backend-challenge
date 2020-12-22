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

#   context "relationships", blah: true do 
#     # TODO: factory bot is not adding the assocations to headlines
#     it "should have 3 headlines for member1" do
#       pending("TODO: factory bot is not adding the assocations to headlines")
#       expect(1).to be(1)
#       member = FactoryBot.create(:member)
# puts MemberHeadline.count
#        member.member_headlines.each do |x|
#         puts x.inspect
#       end    
#     end
#   end 
end
