class CreateMemberHeadlines < ActiveRecord::Migration[6.0]
  def change
    create_table :member_headlines do |t|
      t.references :member, null: false, foreign_key: true
      t.string :headline
      t.string :heading_type

      t.timestamps
    end
  end
end
