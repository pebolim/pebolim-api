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

ActiveRecord::Schema.define(version: 20180106205416) do

  create_table "encounters", force: :cascade do |t|
    t.integer "game_id"
    t.integer "match_id"
    t.index ["game_id"], name: "index_encounters_on_game_id"
    t.index ["match_id"], name: "index_encounters_on_match_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "state", default: 1, null: false
    t.boolean "belongs_to_tournment", default: false, null: false
    t.string "local"
    t.datetime "match_day"
    t.string "url"
    t.boolean "is_private", default: false, null: false
    t.datetime "start_date"
    t.datetime "finish_date"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "to_teams", default: false, null: false
    t.index ["owner_id"], name: "index_games_on_owner_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
    t.integer "time"
    t.index ["game_id"], name: "index_goals_on_game_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "fase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "matches_teams", force: :cascade do |t|
    t.integer "game_id"
    t.integer "match_id"
    t.index ["game_id"], name: "index_matches_teams_on_game_id"
    t.index ["match_id"], name: "index_matches_teams_on_match_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "game_id"
    t.integer "team_id"
    t.boolean "is_winner", default: false, null: false
    t.integer "goals", default: 0, null: false
    t.index ["game_id"], name: "index_participations_on_game_id"
    t.index ["team_id"], name: "index_participations_on_team_id"
  end

  create_table "partnerships", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.integer "state"
    t.index ["team_id"], name: "index_partnerships_on_team_id"
    t.index ["user_id"], name: "index_partnerships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.boolean "is_official", default: false, null: false
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "local"
    t.datetime "start_date"
    t.integer "max_games", default: 1, null: false
    t.integer "max_goals", default: 3, null: false
    t.integer "max_teams", default: 16, null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.string "nickname", null: false
    t.integer "age"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
