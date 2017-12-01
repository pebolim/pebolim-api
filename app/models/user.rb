class User < ApplicationRecord
    has_many :teams_as_attacker, :class_name => 'Team', foreign_key => 'attacker'
    has_many :teams_as_defender, :class_name => 'Team', foreign_key => 'defender'  

    has_many :invitations, :class_name => 'Invitation', foreign_key => 'player_id' 

    def teams
        teams_as_attacker + teams_as_defender
    end
end
    