json.set! :games do
    json.array! @games.each_with_index.to_a do |game,index|
        json.id game.id
        json.local game.local
        json.match_day game.match_day
        json.result1 game.result1
        json.result2 game.result2
        json.winner 
        json.teams @teams[index]
        json.winner @winner[index]
    end
end
