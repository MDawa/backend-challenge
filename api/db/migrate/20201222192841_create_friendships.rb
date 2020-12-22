class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :member1, null: false, foreign_key: { to_table: 'members' }
      t.references :member2, null: false, foreign_key: { to_table: 'members' }

      t.timestamps
    end

    # These indexes automatically was created in postgres
    # add_index :friendships, :member1_id
    # add_index :friendships, :member2_id
  end
end
