# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_22_193137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "member1_id", null: false
    t.bigint "member2_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member1_id"], name: "index_friendships_on_member1_id"
    t.index ["member2_id"], name: "index_friendships_on_member2_id"
  end

  create_table "member_headlines", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "headline"
    t.string "heading_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_member_headlines_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "short_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "friendships_count"
  end

  add_foreign_key "friendships", "members", column: "member1_id"
  add_foreign_key "friendships", "members", column: "member2_id"
  add_foreign_key "member_headlines", "members"
end
