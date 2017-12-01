class TournamentGame < ApplicationRecord
    belongs_to :match, class_name: 'Match'
    belongs_to :game_state, class_name: 'GameState'

    has_many :goals, :class_name => 'TournamentGoal', :foreign_key => 'game_id'
end
