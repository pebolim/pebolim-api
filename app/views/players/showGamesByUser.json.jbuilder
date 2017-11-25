json.set! :games do
        json.array! @games do |game|
                json.id game.id
                json.matchday game.matchDay
                
        end
end
