class Match < ApplicationRecord
    belongs_to :tournament

    has_and_belongs_to_many :teams

    has_many :encounters
    has_many :games, through: :encounters
end