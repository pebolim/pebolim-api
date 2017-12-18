class MissingAttrs < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :is_locked, :boolean
    add_column :games, :start_date, :datetime
    add_column :games, :owner_id, :integer

    change_table :goals do |t|
      t.change :time, :integer
    end
  end
end
