class DatabaseReformulation < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
    drop_table :teams
    drop_table :invitations
    drop_table :casual_games
    drop_table :tournament_games
    drop_table :game_states
    drop_table :tournament_game_goals
    drop_table :casual_game_goals
    drop_table :tournaments
    drop_table :matches
    drop_table :fases

    create_table :users do |t|
      t.string    :email, null: false, unique: true
      t.string    :password, null: false
      t.string    :nickname, null: false, unique: true
      t.integer   :age
      t.string    :image_url

      t.timestamps
    end

    create_table :teams do |t|
      t.boolean   :is_official, null: false, default: false
      t.string    :name
      t.string    :image_url

      t.timestamps
    end

    create_table :partnerships do |t|
      t.belongs_to  :team, index: true
      t.belongs_to  :user, index: true
      # 1(em espera) 2(pendente) 3(aceite) 4(removida)
      t.integer     :state
    end

    create_table :games do |t|
      # 1(em espera) 2(a decorrer) 3(terminado) 4(cancelado)
      t.integer     :state, null: false, default:1
      t.boolean     :belongs_to_tournment, null: false, default:false
      t.string      :local
      t.datetime    :match_day 
      t.string      :url
      t.boolean     :is_private, null: false, default:false
      t.boolean     :is_locked, null: false, default:false
      t.datetime    :start_date
      t.datetime    :finish_date
      t.references  :owner, references: :user, index: true

      t.timestamps
    end

    create_table :participations do |t|
      t.belongs_to  :game, index: true
      t.belongs_to  :team, index: true
      t.boolean     :is_winner, null: false, default:false
      t.integer     :goals, null: false, default:0
    end    

    create_table :goals do |t|
      t.belongs_to  :game, index: true
      t.belongs_to  :user, index: true
      t.datetime    :time
    end

    create_table :tournaments do |t|
      t.string      :local
      t.datetime    :start_date
      t.integer     :max_games, null: false, default:1
      t.integer     :max_goals, null: false, default:3
      t.integer     :max_teams, null: false, default:16
      # 1(em espera) 2(a decorrer) 3(terminado) 4(cancelado)
      t.integer     :state, null: false, default:1

      t.timestamps
    end
    
    create_table :matches do |t|
      t.belongs_to  :tournament, index: true
      # 1(final) 2(meia-final) 3(quartos-final) 4(oitavos)...
      t.integer     :fase

      t.timestamps
    end

    create_table :matches_teams do |t|
      t.belongs_to  :game, index: true
      t.belongs_to  :match, index: true
    end

    create_table :encounters do |t|
      t.belongs_to  :game, index: true
      t.belongs_to  :match, index: true
    end

  end
end
