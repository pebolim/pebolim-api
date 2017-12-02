json.set! :games do
    json.array! @games do |game|
        json.id game.id
        json.local game.local
        json.match_day game.match_day
        json.result1 game.result1
        json.result2 game.result2
    end
end
