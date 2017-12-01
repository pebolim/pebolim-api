class TournamentGoal < ApplicationRecord
    belongs_to :game, class_name: 'TournamentGame'
    belongs_to :player, class_name: 'User'
end