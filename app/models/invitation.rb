class Invitation < ApplicationRecord
    belongs_to :team, class_name: 'Team'
    belongs_to :player, class_name: 'User'
    belongs_to :sent_by, class_name: 'User'
end