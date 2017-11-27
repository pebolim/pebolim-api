class JoinTeamsPlayers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :teams, :players do |t|
      
    end
  end
end
