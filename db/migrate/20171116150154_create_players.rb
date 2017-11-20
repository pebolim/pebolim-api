class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :password
      t.string :username
      t.integer :score

      t.timestamps
    end
  end
end
