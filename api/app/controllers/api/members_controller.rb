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

    private
    def members_params
        # TODO: Ideally, short_url shouldn't even be passed and be automatically generated, but due to time, I'm hardcoded it in
        params.permit(:name,:url,:short_url)
    end 
end
