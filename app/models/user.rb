class User < ApplicationRecord
    has_many :partnerships
    has_many :goals

    has_many :teams, through: :partnerships
    
    has_many :games, through: :teams
end