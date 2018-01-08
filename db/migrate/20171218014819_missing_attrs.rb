class MissingAttrs < ActiveRecord::Migration[5.1]
  def change
    change_table :goals do |t|
      t.change :time, :integer
    end
  end
end
