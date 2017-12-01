class Match < ApplicationRecord
    belongs_to :tournament, class_name: 'Tournament'
    belongs_to :team1, class_name: 'Team'
    belongs_to :team2, class_name: 'Team'
    belongs_to :fase, class_name: 'Fase'

    has_many :games, :class_name => 'TournamentGame', :foreign_key => 'match_id'
    
end
