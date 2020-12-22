class Friendship < ApplicationRecord
  belongs_to :member1, counter_cache: true, class_name: "Member"
  belongs_to :member2, counter_cache: true, class_name: "Member"

  before_validation do |doc|
    # # Make sure member1 and member2 are not inverse of each other
    if (Friendship.where(member1: doc.member1, member2: doc.member2).exists? or Friendship.where(member2: doc.member1, member1: doc.member2).exists?)
      errors.add(:base, "friendship exists")
      throw :abort
    else
      true
    end
  end
end
