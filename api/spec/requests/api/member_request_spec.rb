require 'rails_helper'

RSpec.describe "Api::Members", type: :request, blah: true do
    let(:path) { "/api/members" }
    let(:headers) { {"Accept" => "application/json", "Content-Type" => "application/json"} }

    before(:each) do
        # Create users
        @m1 = FactoryBot.create(:member);
        @m2 = FactoryBot.create(:member2);

        # create friendships
        FactoryBot.create(:friendship, member1: @m1, member2: @m2)
    end

    it "should list all members (2)" do
        get path 

        expect(response).to have_http_status :ok
        expect(json.count).to eq 2
    end

    it "should create a new user" do 
        # create attibutes to pass to API
        new_member = FactoryBot.attributes_for(:member3)

        post path, params: new_member
        puts new_member.inspect
    end
end
