class CasualGame < ApplicationRecord
    belongs_to :owner, class_name: 'User'
    belongs_to :team1, class_name: 'Team'
    belongs_to :team2, class_name: 'Team'
    belongs_to :game_state, class_name: 'GameState'

    has_many :goals, :class_name => 'CasualGoal', :foreign_key => 'game_id'
end
