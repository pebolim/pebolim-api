class CreateTeamGames < ActiveRecord::Migration[5.1]
  def change
    create_table :team_games do |t|
      t.boolean :winner
      t.integer :score

      t.timestamps
    end
  end
end
