class Missingattr2 < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :finish_date, :datetime
  end
end
