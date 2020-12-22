class Api::MembersController < ApplicationController
    def index 
        # Only return needed columns and order by name
        members = Member.select(:id, :name,:short_url,:friendships_count).order(:name)

        render json: members.to_json, status: :ok
    end

    def create
        member = Member.create(members_params)

        render json: member.to_json, status: :created
    end

    # this API is to create a friendship, :id is the current user and member_id is the target member
    def friend
        member1 = params[:id]
        member2 = params[:member_id]

        begin 
            friendship = FactoryBot.create(:friendship, member1_id: member1, member2_id: member2)
        rescue 
            # Silently not do anything if a friendship already exists. 
        end

        render json: {message: "Friendship created"}.to_json, status: :created
    end

    def show 
        member = Member.find(params[:id])

        render json: member.to_json(include: {
            member_headlines: {only: [:id,:name]}
            #friendships: {only: [:id,:name]}
        }), status: :ok
    end

    private
    def members_params
        # TODO: Ideally, short_url shouldn't even be passed and be automatically generated, but due to time, I'm hardcoded it in
        params.permit(:name,:url,:short_url)
    end 
end
