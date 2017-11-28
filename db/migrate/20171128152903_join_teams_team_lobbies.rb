class JoinTeamsTeamLobbies < ActiveRecord::Migration[5.1]
  def change
    create_join_table :teams, :team_lobbies do |t|
    end
  end
end
