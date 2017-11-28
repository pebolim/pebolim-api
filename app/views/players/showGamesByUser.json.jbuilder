json.set! :games do
    json.array! @games do |game|
        json.id game.id
        json.match_day game.match_day
        json.local game.local
        json.teamGames game.team_games do |g|
            if(@teams.include?(g.team_id))
                json.winner g.winner
            end
            json.score g.score
        end
    end
end
