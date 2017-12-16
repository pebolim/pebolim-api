class Game < ApplicationRecord
    has_many :participations
    has_many :goals

    has_one :encounter
    has_one :match, through: :encounter
    has_one :tournament, through: :match    

    has_many :scorers, :class_name => 'User', through: :goals
    has_many :teams, through: :participations
    has_many :users, through: :teams
end