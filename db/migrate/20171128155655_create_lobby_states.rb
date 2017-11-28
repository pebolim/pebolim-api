class CreateLobbyStates < ActiveRecord::Migration[5.1]
  def change
    create_table :lobby_states do |t|
      t.integer :state

      t.timestamps
    end
  end
end
