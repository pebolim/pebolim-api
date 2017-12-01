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

ActiveRecord::Schema.define(version: 20171128183416) do

  create_table "casual_game_goals", force: :cascade do |t|
    t.integer "time"
    t.integer "game_id"
    t.integer "player_id"
    t.index ["game_id"], name: "index_casual_game_goals_on_game_id"
    t.index ["player_id"], name: "index_casual_game_goals_on_player_id"
  end

  create_table "casual_games", force: :cascade do |t|
    t.string "local"
    t.datetime "match_day"
    t.boolean "is_private"
    t.integer "max_goals"
    t.integer "result1"
    t.integer "result2"
    t.datetime "finish_date"
    t.integer "best_atacker"
    t.integer "best_defender"
    t.integer "game_state_id"
    t.integer "owner_id"
    t.integer "team1_id"
    t.integer "team2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_state_id"], name: "index_casual_games_on_game_state_id"
    t.index ["owner_id"], name: "index_casual_games_on_owner_id"
    t.index ["team1_id"], name: "index_casual_games_on_team1_id"
    t.index ["team2_id"], name: "index_casual_games_on_team2_id"
  end

  create_table "fases", force: :cascade do |t|
    t.integer "level"
    t.string "name"
  end

  create_table "game_states", force: :cascade do |t|
    t.string "name"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "team_id"
    t.integer "player_id"
    t.integer "sent_by_id"
    t.index ["player_id"], name: "index_invitations_on_player_id"
    t.index ["sent_by_id"], name: "index_invitations_on_sent_by_id"
    t.index ["team_id"], name: "index_invitations_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "fase_id"
    t.integer "team1_id"
    t.integer "team2_id"
    t.index ["fase_id"], name: "index_matches_on_fase_id"
    t.index ["team1_id"], name: "index_matches_on_team1_id"
    t.index ["team2_id"], name: "index_matches_on_team2_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "attacker"
    t.integer "defender"
  end

  create_table "tournament_game_goals", force: :cascade do |t|
    t.integer "time"
    t.integer "game_id"
    t.integer "player_id"
    t.index ["game_id"], name: "index_tournament_game_goals_on_game_id"
    t.index ["player_id"], name: "index_tournament_game_goals_on_player_id"
  end

  create_table "tournament_games", force: :cascade do |t|
    t.integer "result1"
    t.integer "result2"
    t.datetime "finish_date"
    t.integer "best_atacker"
    t.integer "best_defender"
    t.integer "game_state_id"
    t.integer "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_state_id"], name: "index_tournament_games_on_game_state_id"
    t.index ["match_id"], name: "index_tournament_games_on_match_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "local"
    t.integer "max_games"
    t.integer "max_goals"
    t.integer "max_teams"
    t.datetime "finish_date"
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_tournaments_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "username"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
