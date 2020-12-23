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

    # Search API is supposed to traverse the friendship relation for related headlines
    def search
        member = Member.find(params[:id])
        query = params[:q]

        # Algorithm
        # 1. Find if any members satisfy the query, if not, return 0
        # 2. If match, then see if member is friend with current user, if not, then return member path

        # this should really return more than 1 value
        member_hit = MemberHeadline.find_by("lower(headline) like ?", "%#{query.downcase}%")
        id_path = member.friend_path(member_hit.member_id)
        if (id_path.empty?)
            render json: {results: []}.to_json, status: :ok
        else 
            headline = member_hit.headline 
            # transform the array to something useful
            members_path = id_path.map { |id|
                member_match = Member.find(id)
                {id: member_match.id, name: member_match.name}
            }
            render json: {results: [{headline: headline, members: members_path}]}.to_json, status: :ok
        end
    end 

    private
    def members_params
        # TODO: Ideally, short_url shouldn't even be passed and be automatically generated, but due to time, I'm hardcoded it in
        params.permit(:name,:url,:short_url)
    end 
end
