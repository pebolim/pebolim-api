class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.datetime :match_day 
      t.string :local

      t.timestamps
    end
  end
end
