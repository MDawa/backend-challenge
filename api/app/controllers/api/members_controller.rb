class Api::MembersController < ApplicationController
    def index 
        # Only return needed columns and order by name
        members = Member.select(:id, :name,:short_url,:friendships_count).order(:name)

        render json: members.to_json, status: :ok
    end
end
