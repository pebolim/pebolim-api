class AddTeamRefToPlayerTeams < ActiveRecord::Migration[5.1]
  def change
    add_reference :player_teams, :team, foreign_key: true
  end
end
