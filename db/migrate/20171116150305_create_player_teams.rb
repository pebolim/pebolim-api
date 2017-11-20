class CreatePlayerTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :player_teams do |t|
      t.integer :goals
      t.integer :faults

      t.timestamps
    end
  end
end
