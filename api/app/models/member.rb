class Member < ApplicationRecord
    validates :name, presence: true
    validates :url, presence: true
    validates :short_url, presence: true

    # Join table friendship has counters referencing back to this model
    # there is an implicit 'friendship_count' column that keeps
    # record of number of friends this member has
    # so that we won't have to query that table just for counting

    has_many :member_headlines
    has_and_belongs_to_many :friendships

    def friend?(id)
        my_id = self.id
        return Friendship.where(member1_id: my_id, member2_id: id).or(Friendship.where(member2_id: my_id, member1_id: id)).exists?
    end

    # This function returns the path to get from one member to the other
    def friend_path(id)
        my_id = self.id 
        return_array = [id]
        can_halt = false
        too_far = false

        return [my_id,id] if self.friend?(id)

        # Get all friends of the end id
        end_friends = Friendship.where("member1_id = ? or member2_id = ?", id, id).select(:member1_id, :member2_id).to_a

        # TODO: this only goes 3 deep because this is not an efficient way of doing things.
        end_friends.each_with_index do |f,i|
            can_halt = (f.member1_id == my_id or f.member2_id == my_id)
            next_id = (f.member2_id == id) ? f.member1_id : f.member2_id

            # if it reached my_id, then break out of the loops
            if can_halt
                return_array.push my_id
                break
            else 
                return_array.push next_id
                next_friends = Friendship.where("member1_id = ? or member2_id = ?", next_id, next_id).select(:member1_id, :member2_id).to_a
                next_friends.each_with_index do |ff,ii|
                    # check if it reached my_id
                    can_halt = (ff.member1_id == my_id or ff.member2_id == my_id)
                    next_id2 = (ff.member2_id == next_id) ? ff.member1_id : ff.member2_id
                    if can_halt
                        return_array.push my_id
                        break
                    else 
                        return_array.push next_id2
                        next_friends2 = Friendship.where("member1_id = ? or member2_id = ?", next_id2, next_id2).select(:member1_id, :member2_id).to_a
                        next_friends2.each_with_index do |fff,iii|
                            can_halt = (fff.member1_id == my_id or fff.member2_id == my_id)
                            next_id3 = (fff.member2_id == next_id2) ? fff.member1_id : fff.member2_id
                            if can_halt
                                return_array.push my_id
                                break
                            else 
                                return_array.push next_id3
                                next_friends3 = Friendship.where("member1_id = ? or member2_id = ?", next_id3, next_id3).select(:member1_id, :member2_id).to_a
                                next_friends3.each_with_index do |ffff,iiii|
                                    can_halt = (ffff.member1_id == my_id or ffff.member2_id == my_id)
                                    #next_id3 = (fff.member2_id == next_id2) ? fff.member1_id : fff.member2_id
                                    if can_halt
                                        return_array.push my_id
                                        break
                                    else 
                                        return_array.pop
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        return (return_array == [id]) ? [] : return_array.reverse
    end
end
