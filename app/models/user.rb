class User < ApplicationRecord
    has_many :partnerships
    has_many :goals

    has_many :teams, through: :partnerships
    has_many :games, through: :teams
    has_many :games_as_owner, class_name: 'Game'
end