class CasualGamesAttrs < ActiveRecord::Migration[5.1]
  def change
    add_column :casual_games, :is_locked, :boolean
    add_column :casual_games, :start_date, :datetime
  end
end
