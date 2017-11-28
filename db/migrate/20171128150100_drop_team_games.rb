class DropTeamGames < ActiveRecord::Migration[5.1]
  def change
    drop_table :team_games
  end
end
