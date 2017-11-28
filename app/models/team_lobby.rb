class TeamLobby < ApplicationRecord
    has_and_belongs_to_many :teams
    has_one :lobby_states
end
