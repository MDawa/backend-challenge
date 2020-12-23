require 'rails_helper'

RSpec.describe "Api::Members", type: :request do
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

    it "should list 1 member", blah: true do 

        get "#{path}/#{@m1.id}"

        expect(response).to have_http_status :ok
        expect(json["name"]).to eq @m1.name
        expect(json["url"]).to eq @m1.url
        expect(json["short_url"]).to eq @m1.short_url
        expect(json["member_headlines"]).to be_an_instance_of(Array)
        #expect(json["friendships"]).to be_an_instance_of(Array)
    end

    it "should search" do
    end

    context "New Member" do 
        it "should create a new member" do 
            # create attibutes to pass to API
            new_member = FactoryBot.attributes_for(:member3)

            post path, params: new_member
            expect(response).to have_http_status :created
            # should return new member
            expect(json["name"]).to eq new_member[:name]

            # Check DB
            member_db = Member.find_by(name: new_member[:name])
            expect(member_db.name).to eq new_member[:name]
        end

        it "should create a friendship of new member3 to member2" do
            new_member = FactoryBot.create(:member3)

            new_path = "#{path}/#{@m2.id}/friend"

            post new_path, params: {member_id: new_member.id }
            expect(response).to have_http_status :created

            # Check DB
            fs = Friendship.find_by(member1_id: @m2.id, member2_id: new_member.id)
            expect(fs).not_to be nil

        end
    end
end
