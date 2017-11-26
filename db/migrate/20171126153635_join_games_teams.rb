class JoinGamesTeams < ActiveRecord::Migration[5.1]
  def change
    create_join_table :teams, :games do |t|
        t.boolean :winner
        t.integer :score
    end
  end
end
