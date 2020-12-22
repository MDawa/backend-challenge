class MemberHeadline < ApplicationRecord
    belongs_to :member

    validates :heading_type, inclusion: { in: ["h1","h2","h3"] }, presence: true
    validates :headline, presence: true 

    before_validation { heading_type.downcase!}
end
