class Member < ApplicationRecord
    validates :name, presence: true
    validates :url, presence: true
    validates :short_url, presence: true

    # Join table friendship has counters referencing back to this model
    # there is an implicit 'friendship_count' column that keeps
    # record of number of friends this member has
    # so that we won't have to query that table just for counting

    has_many :member_headlines#, class_name: "MemberHeadline"
    has_and_belongs_to_many :friendships
end
