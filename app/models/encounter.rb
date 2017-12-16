class Encounter < ApplicationRecord
    belongs_to :match
    belongs_to :game
end