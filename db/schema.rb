# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_28_152824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "spotify_track_id"
    t.boolean "playing", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spotify_track_id"], name: "index_players_on_spotify_track_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "spotify_tracks", force: :cascade do |t|
    t.string "uri"
    t.string "artist"
    t.string "artist_url"
    t.string "album"
    t.string "album_url"
    t.string "song"
    t.string "song_url"
    t.string "album_cover_url"
    t.string "preview_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uri"], name: "index_spotify_tracks_on_uri", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "url"
    t.string "spotify_token"
    t.string "spotify_refresh_token"
    t.string "spotify_uid"
    t.string "google_uid"
    t.string "google_token"
    t.string "google_refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["google_uid"], name: "index_users_on_google_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["spotify_uid"], name: "index_users_on_spotify_uid", unique: true
  end

  add_foreign_key "players", "spotify_tracks"
  add_foreign_key "players", "users"
end
