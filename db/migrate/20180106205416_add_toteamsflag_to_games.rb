class AddToteamsflagToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :to_teams, :boolean, null: false, default:false
    remove_column :games, :is_locked
  end
end
