class AddFriendshipCountToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :friendships_count, :integer
  end
end
