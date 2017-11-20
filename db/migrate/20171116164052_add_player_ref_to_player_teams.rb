class AddPlayerRefToPlayerTeams < ActiveRecord::Migration[5.1]
  def change
    add_reference :player_teams, :player, foreign_key: true
  end
end
