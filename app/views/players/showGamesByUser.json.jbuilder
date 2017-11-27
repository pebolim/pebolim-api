json.set! :games do
    json.array! @games do |game|
        json.id game.id
        json.match_day game.match_day
        json.local game.local
        
    end
end