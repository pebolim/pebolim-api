class NewDatabase < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :username
      t.integer :age

      t.timestamps
    end

    create_table :teams do |t|
      t.string :name
      t.integer :attacker #user 
      t.integer :defender #user 
    end

        
    create_table :invitations do |t|
      t.references :team, references: :team, foreign_key: true
      t.references :player, references: :user, foreign_key: true
      t.references :sent_by, references: :user, foreign_key: true
    end

    create_table :casual_games do |t|
      t.string :local
      t.datetime :match_day 
      t.string :local
      t.boolean :is_private     
      t.integer :max_goals
      t.integer :result1
      t.integer :result2
      t.datetime :finish_date
      t.integer :best_atacker
      t.integer :best_defender

      t.references :game_state, references: :game_state, foreign_key: true
      t.references :owner, references: :user, foreign_key: true
      t.references :team1, references: :team, foreign_key: true
      t.references :team2, references: :team, foreign_key: true

      t.timestamps
    end

    create_table :tournament_games do |t|
      t.integer :result1
      t.integer :result2
      t.datetime :finish_date
      t.integer :best_atacker
      t.integer :best_defender

      t.references :game_state, references: :game_state, foreign_key: true
      t.references :match, references: :match, foreign_key: true

      t.timestamps
    end


    create_table :game_states do |t|
      t.string :name
    end

    create_table :tournament_game_goals do |t|
      t.integer :time

      t.references :game, references: :tournament_game, foreign_key: true
      t.references :player, references: :user, foreign_key: true
    end

    create_table :casual_game_goals do |t|
      t.integer :time

      t.references :game, references: :casual_game, foreign_key: true
      t.references :player, references: :user, foreign_key: true
    end  

    create_table :tournaments do |t|
      t.string :local
      t.integer :max_games
      t.integer :max_goals
      t.integer :max_teams
      t.datetime :finish_date

      t.references :owner, references: :user, foreign_key: true
    end

    create_table :matches do |t|
      t.references :tournament, references: :tournament, foreign_key: true
      t.references :fase, references: :fase, foreign_key: true
      t.references :team1, references: :team, foreign_key: true
      t.references :team2, references: :team, foreign_key: true
    end

    create_table :fases do |t|
      t.integer :level
      t.string :name
    end

  end
end
