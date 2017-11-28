class CreateTeamLobbies < ActiveRecord::Migration[5.1]
  def change
    create_table :team_lobbies do |t|
      t.references :lobby_states, null:false, foreign_key:true
      t.boolean :is_private
      t.text :url

      t.timestamps
    end
  end
end
