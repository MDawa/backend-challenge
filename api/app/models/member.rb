class Member < ApplicationRecord
    validates :name, presence: true
    validates :url, presence: true
    validates :short_url, presence: true

    has_many :member_headlines
end
