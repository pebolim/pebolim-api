class CreatePlayerTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :player_teams do |t|
      t.numeric :goals
      t.numeric :faults

      t.timestamps
    end
  end
end
