class Tournament < ApplicationRecord
    belongs_to :owner, class_name: 'User'

    has_many :games, :class_name => 'Match', :foreign_key => 'tournament_id'
    
end
