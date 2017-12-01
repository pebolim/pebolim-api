class CasualGoal < ApplicationRecord
    belongs_to :game, class_name: 'CasualGame'
    belongs_to :player, class_name: 'User'
end