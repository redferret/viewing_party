# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_14_184141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "movie_party_id"
    t.bigint "friendship_id"
    t.index ["friendship_id"], name: "index_invitations_on_friendship_id"
    t.index ["movie_party_id"], name: "index_invitations_on_movie_party_id"
  end

  create_table "movie_parties", force: :cascade do |t|
    t.bigint "user_id"
    t.string "movie_title"
    t.string "movie_poster_path"
    t.datetime "time_date"
    t.string "movie_id"
    t.index ["user_id"], name: "index_movie_parties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "friendships", "users"
  add_foreign_key "invitations", "friendships"
  add_foreign_key "invitations", "movie_parties"
  add_foreign_key "movie_parties", "users"
end
