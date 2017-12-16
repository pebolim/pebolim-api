class Team < ApplicationRecord
    has_many :partnerships
    has_many :participations
    
    has_and_belongs_to_many :matches

    has_many :users, through: :partnerships
    has_many :games, through: :participations
    has_many :tournaments, through: :matches
end