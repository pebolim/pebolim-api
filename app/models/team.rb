class Team < ApplicationRecord
    #tournament
    has_many :matches_home, :class_name => 'Match', foreign_key => 'team1_id'
    has_many :matches_away, :class_name => 'Match', foreign_key => 'team2_id'

    #casual
    has_many :games_home, :class_name => 'CasualGame', foreign_key => 'team1_id'
    has_many :games_away, :class_name => 'CasualGame', foreign_key => 'team2_id'  

    has_many :invitations, :class_name => 'Invitation', foreign_key => 'team_id' 

    def matches
        matches_home + matches_away
    end

    def games
        games_home + games_away
    end
end
