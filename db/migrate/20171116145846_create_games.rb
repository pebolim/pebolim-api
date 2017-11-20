class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.timestamps :matchDay 

      t.timestamps
    end
  end
end
